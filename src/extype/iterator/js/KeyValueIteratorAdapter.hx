package extype.iterator.js;

#if js
import js.lib.Iterator;
import js.lib.Map.MapEntry;

/**
    Represents a `js.lib.Iterator<js.lib.Map.MapEntry<K, V>>` adapter that can be used for Haxe's `KeyValueIterator<K, V>`.
**/
class KeyValueIteratorAdapter<K, V> {
    final iterator:Iterator<MapEntry<K, V>>;
    var current:IteratorStep<MapEntry<K, V>>;

    public inline function new(iterator:Iterator<MapEntry<K, V>>) {
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
    public inline function next():{key:K, value:V} {
        final entry = current.value;
        current = iterator.next();
        return new KeyValuePair(entry.key, entry.value);
    }
}

private class KeyValuePair<K, V> {
    public var key:K;
    public var value:V;

    public function new(key:K, value:V) {
        this.key = key;
        this.value = value;
    }
}
#end
