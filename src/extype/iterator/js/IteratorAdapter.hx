package extype.iterator.js;

#if js
import js.lib.Iterator;
/**
    Represents a `js.lib.Iterator<T>` adapter that can be used for Haxe's `Iterator<T>`.
**/
class IteratorAdapter<T> {
    final iterator:Iterator<T>;
    var current:IteratorStep<T>;

    public inline function new(iterator:Iterator<T>) {
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
