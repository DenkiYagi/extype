package extype.map;

import extype.Map.IMap;
#if js
import js.lib.Map in JsMap;
import extype.iterator.js.IteratorAdapter;
import extype.iterator.js.KeyValueIteratorAdapter;
#elseif neko
import extype.Pair;
import extype.iterator.TransformIterator;
#else
import haxe.ds.ObjectMap in StdMap;
#end

/**
    Represents a Map object of `{}` keys.
**/
class ObjectMap<K:{}, V> implements IMap<K, V> {
    #if js
    final map:JsMap<K, V>;
    #elseif neko
	final hash:Dynamic;
    #else
    final map:StdMap<K, V>;
    var _length:Int;
    #end

    /**
        Returns the number of key/value pairs in this Map object.
    **/
    public var length(get, never):Int;

    public inline function new() {
        #if js
        this.map = new JsMap();
        #elseif neko
        this.hash = untyped __dollar__hnew(0);
        #else
        this.map = new StdMap();
        this._length = 0;
        #end
    }

    /**
        Returns the current mapping of `key`.
    **/
    public inline function get(key:K):Null<V> {
        #if neko
        final entry:ObjectMapEntry<K, V> = untyped __dollar__hget(hash, getId(key), null);
        return (entry != null) ? entry.value : null;
        #else
        return map.get(key);
        #end
    }

    /**
        Maps key to value.

        If `key` already has a mapping, the previous value disappears.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function set(key:K, value:V):Void {
        #if js
        map.set(key, value);
        #elseif neko
        untyped __dollar__hset(hash, assignId(key), new ObjectMapEntry(key, value), null);
        #else
        if (!map.exists(key)) _length++;
        map.set(key, value);
        #end
    }

    /**
        Returns true if key `has` a mapping, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function exists(key:K):Bool {
        #if js
        return map.has(key);
        #elseif neko
        return untyped __dollar__hmem(hash, getId(key), null);
        #else
        return map.exists(key);
        #end
    }

    /**
        Removes the mapping of key and returns true if such a mapping existed, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function remove(key:K):Bool {
        #if js
        return map.delete(key);
        #elseif neko
        return untyped __dollar__hremove(hash, getId(key), null);
        #else
        final ret = map.remove(key);
        if (ret) _length--;
        return ret;
        #end
    }

    /**
        Returns an Iterator over the keys of this Map.
    **/
    public inline function keys():Iterator<K> {
        #if js
        return new IteratorAdapter(map.keys());
        #elseif neko
        final list = new List<K>();
        untyped __dollar__hiter(hash, (_, entry) -> {
            list.push(entry.key);
        });
        return list.iterator();
        #else
        return map.keys();
        #end
    }

    /**
        Returns an Iterator over the values of this Map.
    **/
    public inline function iterator():Iterator<V> {
        #if js
        return new IteratorAdapter(map.values());
        #elseif neko
        final list = new List<V>();
        untyped __dollar__hiter(hash, (_, entry) -> {
            list.push(entry.value);
        });
        return list.iterator();
        #else
        return map.iterator();
        #end
    }

    /**
        Returns an Iterator over the keys and values of this Map.
    **/
    public inline function keyValueIterator():KeyValueIterator<K, V> {
        #if js
        return new KeyValueIteratorAdapter(map.entries());
        #elseif neko
        final list = new List<ObjectMapEntry<K, V>>();
        untyped __dollar__hiter(hash, (_, entry) -> {
            list.push(entry);
        });
        return list.iterator();
        #else
        return map.keyValueIterator();
        #end
    }

    /**
        Returns a shallow copy of this Map.
    **/
    public inline function copy():ObjectMap<K, V> {
        final newMap = new ObjectMap();
        #if js
        map.forEach((v, k, _) -> newMap.set(k, v));
        #elseif neko
        for (k => v in this) newMap.set(k, v);
        #else
        for (k => v in map) newMap.set(k, v);
        #end
        return newMap;
    }

    /**
        Returns a String representation of this Map.
    **/
    public inline function toString():String {
        final buff = [];
        #if js
        map.forEach((v, k, _) -> buff.push('${k}=>${v}'));
        #elseif neko
        for (k => v in this) buff.push('${k}=>${v}');
        #else
        for (k => v in map) buff.push('${k}=>${v}');
        #end
        return '[${buff.join(",")}]';
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #elseif neko
        return untyped __dollar__hcount(hash);
        #else
        return _length;
        #end
    }

    #if neko
    static var count:Int = 0;

    static inline function assignId(obj:{}):Int {
        return if (untyped obj.__id__ == null) {
            final newId = count++;
            untyped obj.__id__ = newId;
            newId;
        } else {
            untyped obj.__id__;
        }
    }

    static inline function getId(obj:{}):Int {
        return untyped obj.__id__;
    }
    #end
}

#if neko
private class ObjectMapEntry<K:{}, V> {
    public var key:K;
    public var value:V;

    public function new(key:K, value:V) {
        this.key = key;
        this.value = value;
    }
}
#end
