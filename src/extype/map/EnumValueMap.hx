package extype.map;

import extype.Map.IMap;
import haxe.ds.EnumValueMap in StdMap;

/**
    Represents a Map object of `EnumValue` keys.
**/
class EnumValueMap<K:EnumValue, V> implements IMap<K, V> {
    final map:StdMap<K, V>;
    var _length:Int;

    /**
        Returns the number of key/value pairs in this Map object.
    **/
    public var length(get, never):Int;

    public inline function new() {
        this.map = new StdMap();
        this._length = 0;
    }

    /**
        Returns the current mapping of `key`.
    **/
    public inline function get(key:K):Null<V> {
        return map.get(key);
    }

    /**
        Maps key to value.

        If `key` already has a mapping, the previous value disappears.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function set(key:K, value:V):Void {
        if (!map.exists(key)) _length++;
        map.set(key, value);
    }

    /**
        Returns true if key `has` a mapping, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function exists(key:K):Bool {
        return map.exists(key);
    }

    /**
        Removes the mapping of key and returns true if such a mapping existed, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function remove(key:K):Bool {
        final ret = map.remove(key);
        if (ret) _length--;
        return ret;
    }

    /**
        Returns an Iterator over the keys of this Map.
    **/
    public inline function keys():Iterator<K> {
        return map.keys();
    }

    /**
        Returns an Iterator over the values of this Map.
    **/
    public inline function iterator():Iterator<V> {
        return map.iterator();
    }

    /**
        Returns an Iterator over the keys and values of this Map.
    **/
    public inline function keyValueIterator():KeyValueIterator<K, V> {
        return map.keyValueIterator();
    }

    /**
        Returns a shallow copy of this Map.
    **/
    public inline function copy():EnumValueMap<K, V> {
        final newMap = new EnumValueMap();
        for (k => v in map) newMap.set(k, v);
        return newMap;
    }

    /**
        Returns a String representation of this Map.
    **/
    public inline function toString():String {
        final buff = [];
        for (k => v in map) buff.push('${k}=>${v}');
        return '[${buff.join(",")}]';
    }

    inline function get_length():Int {
        return _length;
    }
}
