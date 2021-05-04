package extype;

@:forward(length, get, exists, keys, iterator, keyValueIterator, copy, toString)
abstract ReadOnlyMap<K, V>(MapLike<K, V>) from Map.IMap<K, V> {}

private typedef MapLike<K, V> = {
    var length(get, never):Int;
    function get(k:K):Null<V>;
    function set(k:K, v:V):Void;
    function exists(k:K):Bool;
    function remove(k:K):Bool;
    function keys():Iterator<K>;
    function iterator():Iterator<V>;
    function keyValueIterator():KeyValueIterator<K, V>;
    function copy():MapLike<K, V>;
    function toString():String;
    function clear():Void;
}
