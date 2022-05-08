package extype.extern;

@:forward
abstract Indexable<TObject:{}, TValue>(TObject) from TObject to TObject {
    @:arrayAccess
    public inline function get(field:String):Nullable<TValue> {
        #if js
        return js.Syntax.code("{0}[{1}]", this, field);
        #else
        return Reflect.field(this, field);
        #end
    }

    @:op(a.b)
    inline function getByDotAccess(field:String):Nullable<TValue> {
        return get(field);
    }

    @:arrayAccess
    public inline function set(field:String, value:TValue):TValue {
        #if js
        return js.Syntax.code("{0}[{1}] = {2}", this, field, value);
        #else
        Reflect.setField(this, field, value);
        return value;
        #end
    }

    @:op(a.b)
    inline function setByDotAccess(field:String, value:TValue):TValue {
        return set(field, value);
    }
}
