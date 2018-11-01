package extype;

abstract ReadOnlyDynamic<T>(Dynamic<T>) from Dynamic<T> {
    @:arrayAccess inline function get(key: String): T {
        #if js
        return untyped __js__("{0}[{1}]", this, key);
        #else
        return Reflect.field(this, key);
        #end
    }
}