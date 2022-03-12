package extype.extern;

abstract ValueOrArray<T>(Dynamic) from T from Array<T> {
    @:to
    public inline function toArray():Array<T> {
        return if (Std.isOfType(this, Array)) {
            this;
        } else {
            [this];
        }
    }

    @:to
    public inline function toValue():T {
        return if (Std.isOfType(this, Array)) {
            (this : Array<T>)[0];
        } else {
            this;
        }
    }
}
