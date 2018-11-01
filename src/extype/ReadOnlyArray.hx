package extype;

@:forward(length, concat, join, toString, indexOf, lastIndexOf, copy, map, filter, iterator)
abstract ReadOnlyArray<T>(Array<T>) from Array<T> {
    @:arrayAccess inline function get(i: Int) {
        return this[i];
    }
}
