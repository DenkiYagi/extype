package extype;

@:forward(copy, filter, indexOf, iterator, keyValueIterator, join, lastIndexOf, map, slice, contains, toString)
abstract ReadOnlyArray<T>(Array<T>) from Array<T> to Iterable<T> {
    /**
        The length of `this` Array.
    **/
    public var length(get, never):Int;
    inline function get_length() {
        return this.length;
    }

    @:arrayAccess inline function get(i:Int) {
        return this[i];
    }

    /**
        Returns a new Array by appending the elements of `a` to the elements of
        `this` Array.

        This operation does not modify `this` Array.

        If `a` is the empty Array `[]`, a copy of `this` Array is returned.

        The length of the returned Array is equal to the sum of `this.length`
        and `a.length`.

        If `a` is `null`, the result is unspecified.
    **/
    public inline function concat(a:ReadOnlyArray<T>):Array<T> {
        return this.concat(cast a);
    }

    /**
        Casts `this` Array to mutable `Array`.
    **/
    public inline function toArrayUnsafe():Array<T> {
        return this;
    }
}
