package extype.extern;

@:forward
abstract ReadOnlyIndexable<TObject:{}, TValue>(TObject) from TObject to TObject {
    @:arrayAccess
    inline function get(field: String): Maybe<TValue> {
        #if js
        return js.Syntax.code("{0}[{1}]", this, field);
        #else 
        return Reflect.field(this, field);
        #end
    }

    @:op(a.b) 
    inline function getByDotAccess(field: String): Maybe<TValue> {
        return get(field);
    }
}