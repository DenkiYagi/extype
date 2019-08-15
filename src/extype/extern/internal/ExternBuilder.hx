package extype.extern.internal;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

using Lambda;

@:noCompletion
class ExternBuilder {
    public static function build(): ComplexType {
        final localType = Context.getLocalType();
        return Context.toComplexType(switch (localType) {
            case TInst(_, [type]):
                resolveAnonymousType(type).map(t -> convert(t)).getOrElse(localType);
            case _:
                localType;
        });
    }

    static function convert(type: Type): Type {
        final typeBuilder = new TypeBuilder();

        var fields = getFields(type).map(f -> [
            Start({
                name: f.name,
                nativeName: getNativeValue(f.meta),
                type: f.type,
            }),
            End
        ]).flatten();

        while (fields.length > 0) {
            switch (fields.shift()) {
                case Start(fld):
                    typeBuilder.emitStart(fld.name, fld.nativeName);
                    fields = getFields(fld.type).map(f -> [
                        Start({
                            name: f.name,
                            nativeName: getNativeValue(f.meta),
                            type: f.type,
                        }),
                        End
                    ]).flatten().concat(fields);
                case End:
                    typeBuilder.emitEnd();
            }
        }

        return typeBuilder.build(type);
    }

    static function resolveAnonymousType(type: Type): Maybe<Type> {
        var acc = type;
        while (true) {
            switch (acc) {
                case TAnonymous(_):
                    return Maybe.of(acc);
                case TType(t, _):
                    acc = t.get().type;
                case _:
                    return Maybe.empty();
            }
        }
    }

    static function getFields(type: Type): Array<ClassField> {
        return switch (resolveAnonymousType(type).get()) {
            case TAnonymous(a): a.get().fields;
            case _: [];
        }
    }

    static function getNativeValue(meta: MetaAccess): Maybe<String> {
        final natives = meta.extract(":native")
            .map(x -> (x.params.length == 1) ? getString(x.params[0]) : Maybe.empty())
            .filter(x -> x.nonEmpty());
        return (natives.length > 0) ? natives[0] : Maybe.empty();
    }

    static function getString(expr: Expr): Maybe<String> {
        return switch (expr.expr) {
            case EConst(CString(s)): Maybe.of(s);
            case _: Maybe.empty();
        }
    }
}

private class TypeBuilder {
    static var sequence = 0;
    final stack: Array<{
        final name: String;
        final nativeName: Maybe<String>;
        final transformers: Array<ExprOf<{} -> Void>>;
    }>;
    var transformers: Array<Expr>;

    public function new() {
        this.stack = [];
        this.transformers = [];
    }

    public function emitStart(name: String, nativeName: Maybe<String>): Void {
        stack.push({
            name: name,
            nativeName: nativeName,
            transformers: []
        });
    }

    public function emitEnd(): Void {
        if (stack.length == 0) throw "illegal state";

        final current = stack.pop();
        var exprs = [];

        if (current.nativeName.nonEmpty() && current.name != current.nativeName.get()) {
            final nativeName = current.nativeName.getUnsafe();
            exprs.push(macro Reflect.setField(o, $v{nativeName}, v));
            exprs.push(macro Reflect.deleteField(o, $v{current.name}));
        }
        if (current.transformers.length > 0) {
            exprs = exprs.concat(current.transformers.map(e -> macro ${e}(v)));
        }

        if (exprs.length > 0) {
            final fn = macro function (o: {}) {
                if (o != null) $b{ [macro final v = Reflect.field(o, $v{current.name})].concat(exprs) };
            }
            switch (stack.length) {
                case 0:
                    this.transformers.push(fn);
                case final len:
                    final parent = stack[len - 1];
                    parent.transformers.push(fn);
            }
        }
    }

    function generateTypePath(): TypePath {
        final paths = Context.getLocalModule().split(".");
        final name = paths.pop();
        return {
            pack: paths,
            name: '${name}_Extern${sequence++}'
        };
    }

    public function build(orignal: Type): Type {
        return if (transformers.length > 0) {
            final typePath = generateTypePath();

            Context.defineType({
                kind: TypeDefKind.TDAbstract(macro: {}),
                pack: typePath.pack,
                name: typePath.name,
                fields: [
                    // new
                    {
                        name: "new",
                        kind: FFun({
                            args: [{name: "x", type: Context.toComplexType(orignal)}],
                            expr: macro {
                                $b{transformers.map(e -> macro ${e}(x))};
                                this = x;
                            },
                            ret: null
                        }),
                        pos: Context.currentPos()
                    },
                    // from
                    {
                        name: "from",
                        access: [AStatic],
                        meta: [{name: ":from", pos: Context.currentPos()}],
                        kind: FFun({
                            args: [{name: "x", type: Context.toComplexType(orignal)}],
                            expr: macro return new $typePath(x),
                            ret: null
                        }),
                        pos: Context.currentPos()
                    }
                ],
                pos: Context.currentPos(),
            }, null);

            Context.getType('${typePath.pack.join(".")}.${typePath.name}');
        } else {
            orignal;
        }
    }
}

private enum VisitEvent<T> {
    Start(x: T);
    End;
}
