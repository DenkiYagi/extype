package extype;

import haxe.ds.Map;

@:forward(get, exists, keys, iterator, keyValueIterator, copy, toString)
abstract ReadOnlyMap<K, V>(Map<K, V>) from Map<K, V> {
}