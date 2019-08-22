package extype;

import extype.orderedmap.StringOrderedMap;
import extype.orderedmap.IntOrderedMap;
import extype.orderedmap.EnumValueOrderedMap;
import extype.orderedmap.ObjectOrderedMap;

/**
    Represents a collection of keys and values.
    You can iterate through the keys in insertion order.

    This is a multi-type abstract, it is instantiated as one of its specialization types
    depending on its type parameters.
**/
@:multiType
abstract OrderedMap<K, V>(IOrderedMap<K, V>) {
    /**
        Creates a new forward.

        This becomes a constructor call to one of the specialization types in the output.
        The rules for that are as follows:

        1. if `K` is a `String`, `extype.orderedmap.StringOrderedMap` is used
        2. if `K` is an `Int`, `extype.orderedmap.IntOrderedMap` is used
        3. if `K` is an `EnumValue`, `extype.orderedmap.EnumValueOrderedMap` is used
        4. if `K` is an `{function hashCode():Int;}`, `extype.orderedmap.HashOrderedMap` is used
        5. if `K` is any other class or structure, `extype.orderedmap.ObjectOrderedMap` is used
        6. if `K` is any other type, it causes a compile-time error
    **/
    public function new();

    /**
        Returns the number of key/value pairs in this Map object.
    **/
    public var length(get, never):Int;

    inline function get_length():Int {
        return this.length;
    }

    /**
        Returns the current mapping of `key`.
    **/
    public inline function get(key:K):V {
        return this.get(key);
    }

    /**
        Maps key to value.

        If `key` already has a mapping, the previous value disappears.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function set(key:K, value:V):Void {
        this.set(key, value);
    }

    /**
        Returns true if key `has` a mapping, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function exists(key:K):Bool {
        return this.exists(key);
    }

    /**
        Removes the mapping of key and returns true if such a mapping existed, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public inline function remove(key:K):Bool {
        return this.remove(key);
    }

    /**
        Returns an Iterator over the keys of this Map.
    **/
    public inline function keys():Iterator<K> {
        return this.keys();
    }

    /**
        Returns an Iterator over the values of this Map.
    **/
    public inline function iterator():Iterator<V> {
        return this.iterator();
    }

    /**
        Returns an Iterator over the keys and values of this Map.
    **/
    public inline function keyValueIterator():KeyValueIterator<K, V> {
        return this.keyValueIterator();
    }

    /**
        Returns a shallow copy of this Map.
    **/
    public inline function copy():OrderedMap<K, V> {
        return cast this.copy();
    }

    /**
        Returns a String representation of this Map.
    **/
    public inline function toString():String {
        return this.toString();
    }

    @:to static inline function toStringMap<K:String, V>(t:IOrderedMap<K, V>):StringOrderedMap<V> {
        return new StringOrderedMap<V>();
    }

    @:to static inline function toIntMap<K:Int, V>(t:IOrderedMap<K, V>):IntOrderedMap<V> {
        return new IntOrderedMap<V>();
    }

    @:to static inline function toEnumValueMapMap<K:EnumValue, V>(t:IOrderedMap<K, V>):EnumValueOrderedMap<K, V> {
        return new EnumValueOrderedMap<K, V>();
    }

    @:to static inline function toObjectMap<K:{}, V>(t:IOrderedMap<K, V>):ObjectOrderedMap<K, V> {
        return new ObjectOrderedMap<K, V>();
    }

    @:from static inline function fromStringMap<V>(map:StringOrderedMap<V>):OrderedMap<String, V> {
        return cast map;
    }

    @:from static inline function fromIntMap<V>(map:IntOrderedMap<V>):OrderedMap<Int, V> {
        return cast map;
    }

    @:from static inline function fromEnumValueMap<K:EnumValue, V>(map:EnumValueOrderedMap<K, V>):OrderedMap<K, V> {
        return cast map;
    }

    @:from static inline function fromObjectMap<K:{}, V>(map:ObjectOrderedMap<K, V>):OrderedMap<Int, V> {
        return cast map;
    }
}

interface IOrderedMap<K, V> extends Map.IMap<K, V> {
    /**
        Returns a shallow copy of this Map.
    **/
    function copy():IOrderedMap<K, V>;
}
