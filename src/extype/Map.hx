package extype;

import extype.map.StringMap;
import extype.map.IntMap;
import extype.map.EnumValueMap;
import extype.map.HashMap;
import extype.map.ObjectMap;

/**
    Represents a collection of keys and values.

    This is a multi-type abstract, it is instantiated as one of its specialization types
    depending on its type parameters.
**/
@:multiType
abstract Map<K, V>(IMap<K, V>) {
    /**
        Creates a new forward.

        This becomes a constructor call to one of the specialization types in the output.
        The rules for that are as follows:

        1. if `K` is a `String`, `extype.map.StringMap` is used
        2. if `K` is an `Int`, `extype.map.IntMap` is used
        3. if `K` is an `EnumValue`, `extype.map.EnumValueMap` is used
        4. if `K` is an `{function hashCode():Int;}`, `extype.map.HashMap` is used
        5. if `K` is any other class or structure, `extype.map.ObjectMap` is used
        6. if `K` is any other type, it causes a compile-time error
    **/
    public function new();

    public var length(get, never):Int;

    inline function get_length():Int {
        return this.length;
    }

    public inline function set(key:K, value:V)
        this.set(key, value);

    public inline function exists(key:K)
        return this.exists(key);

    public inline function remove(key:K)
        return this.remove(key);

    public inline function keys():Iterator<K> {
        return this.keys();
    }

    public inline function iterator():Iterator<V> {
        return this.iterator();
    }

    public inline function keyValueIterator():KeyValueIterator<K, V> {
        return this.keyValueIterator();
    }

    public inline function copy():Map<K, V> {
        return cast this.copy();
    }

    public inline function toString():String {
        return this.toString();
    }

    @:to static inline function toStringMap<K:String, V>(t:IMap<K, V>):StringMap<V> {
        return new StringMap<V>();
    }

    @:to static inline function toIntMap<K:Int, V>(t:IMap<K, V>):IntMap<V> {
        return new IntMap<V>();
    }

    @:to static inline function toEnumValueMapMap<K:EnumValue, V>(t:IMap<K, V>):EnumValueMap<K, V> {
        return new EnumValueMap<K, V>();
    }

    @:to static inline function toHashMap<K:{function hashCode():Int;}, V>(t:IMap<K, V>):HashMap<K, V> {
        return new HashMap<K, V>();
    }

    @:to static inline function toObjectMap<K:{}, V>(t:IMap<K, V>):ObjectMap<K, V> {
        return new ObjectMap<K, V>();
    }

    @:from static inline function fromStringMap<V>(map:StringMap<V>):Map<String, V> {
        return cast map;
    }

    @:from static inline function fromIntMap<V>(map:IntMap<V>):Map<Int, V> {
        return cast map;
    }

    @:from static inline function fromEnumValueMap<K:EnumValue, V>(map:EnumValueMap<K, V>):Map<K, V> {
        return cast map;
    }

    @:from static inline function fromHashMap<K:{function hashCode():Int;}, V>(map:HashMap<K, V>):Map<Int, V> {
        return cast map;
    }

    @:from static inline function fromObjectMap<K:{}, V>(map:ObjectMap<K, V>):Map<Int, V> {
        return cast map;
    }
}

interface IMap<K, V> {
    /**
        Returns the number of key/value pairs in this Map object.
    **/
    var length(get, never):Int;

    function get(k:K):Null<V>;
    function set(k:K, v:V):Void;
    function exists(k:K):Bool;
    function remove(k:K):Bool;
    function keys():Iterator<K>;
    function iterator():Iterator<V>;
    function keyValueIterator():KeyValueIterator<K, V>;

    /**
        Returns a shallow copy of this Map.
    **/
    function copy():IMap<K, V>;

    function toString():String;
}
