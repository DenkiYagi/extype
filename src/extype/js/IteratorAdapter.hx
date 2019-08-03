package extype.js;

#if js
/**
    Represents a `js.lib.Iterator` adapter that can be used for Haxe's `Iterator`.
**/
class IteratorAdapter<T> {
    final iterator:js.lib.Iterator<T>;
    var current:js.lib.Iterator.IteratorStep<T>;

    public inline function new(iterator:js.lib.Iterator<T>) {
        this.iterator = iterator;
        this.current = iterator.next();
    }

    /**
        @see `Iterator.hasNext()`
    **/
    public inline function hasNext():Bool {
        return !current.done;
    }

    /**
        @see `Iterator.next()`
    **/
    public inline function next():T {
        final value = current.value;
        current = iterator.next();
        return value;
    }
}
#end
