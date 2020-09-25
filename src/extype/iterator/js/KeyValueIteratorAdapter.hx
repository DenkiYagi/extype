package extype.iterator.js;

#if js
import js.lib.Iterator;
import js.lib.KeyValue;

/**
    Represents a `js.lib.Iterator<js.lib.Map.MapEntry<K, V>>` adapter that can be used for Haxe's `KeyValueIterator<K, V>`.
**/
@:deprecated("extype.iterator.js.KeyValueIteratorAdapter is deprecated.")
class KeyValueIteratorAdapter<K, V> {
    final iterator:Iterator<KeyValue<K, V>>;
    var current:IteratorStep<KeyValue<K, V>>;

    public inline function new(iterator:Iterator<KeyValue<K, V>>) {
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
