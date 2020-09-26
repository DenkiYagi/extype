package extype._internal;

import js.lib.KeyValue in JsKeyValue;
import js.lib.Iterator;

@:noCompletion
class HaxeKeyValueIterator<K, V> {
    final iterator:Iterator<JsKeyValue<K, V>>;
    var lastStep: js.lib.Iterator.IteratorStep<JsKeyValue<K, V>>;

    public inline function new(iterator:js.lib.Iterator<JsKeyValue<K, V>>) {
        this.iterator = iterator;
        lastStep = iterator.next();
    }

    public inline function hasNext():Bool {
        return !lastStep.done;
    }

    public inline function next():{key:K, value:V} {
        final v = lastStep.value;
        lastStep = iterator.next();
        return new KeyValue(v.key, v.value);
    }
}

private class KeyValue<K, V> {
    public var key:K;
    public var value:V;

    public function new(key:K, value:V) {
        this.key = key;
        this.value = value;
    }
}