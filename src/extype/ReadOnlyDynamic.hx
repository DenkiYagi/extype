package extype;

abstract ReadOnlyDynamic<T>(Dynamic<T>) {
    inline function new(x:Dynamic) {
        this = x;
    }

    @:op(a.b)
    inline function getByDotAccess(field:String):Null<T> {
        return Reflect.field(this, field);
    }

    @:arrayAccess
    inline function getByArrayAccess(field:String):Null<T> {
        return Reflect.field(this, field);
    }

    @:from
    static inline function fromDynamic<T>(x:Dynamic<T>):ReadOnlyDynamic<T> {
        return new ReadOnlyDynamic(x);
    }

    @:from
    static inline function fromObject<T:{}>(x:T):ReadOnlyDynamic<Dynamic> {
        return new ReadOnlyDynamic(x);
    }
}
