package extype;

@:forward(length, get, exists, keys, iterator, keyValueIterator, copy, toString)
abstract ReadOnlyMap<K, V>(_Map<K, V>) from Map.IMap<K, V> {}

private typedef _Map<K, V> = {
    var length(get, never):Int;
    function get(k:K):Null<V>;
    function set(k:K, v:V):Void;
    function exists(k:K):Bool;
    function remove(k:K):Bool;
    function keys():Iterator<K>;
    function iterator():Iterator<V>;
    function keyValueIterator():KeyValueIterator<K, V>;
    function copy():Map.IMap<K, V>;
    function toString():String;
}
