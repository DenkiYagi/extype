package extype;

import extype.orderedmap.StringOrderedMap;
import extype.orderedmap.IntOrderedMap;
import extype.orderedmap.EnumValueOrderedMap;
import extype.orderedmap.HashOrderedMap;
import extype.orderedmap.ObjectOrderedMap;

/**
    Represents a collection of keys and values.
    You can iterate through the keys in insertion order.

    This is a multi-type abstract, it is instantiated as one of its specialization types
    depending on its type parameters.
**/
@:multiType
@:forward
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

    @:to static inline function toStringMap<K:String, V>(t:IOrderedMap<K, V>):StringOrderedMap<V> {
        return new StringOrderedMap<V>();
    }

    @:to static inline function toIntMap<K:Int, V>(t:IOrderedMap<K, V>):IntOrderedMap<V> {
        return new IntOrderedMap<V>();
    }

    @:to static inline function toEnumValueMapMap<K:EnumValue, V>(t:IOrderedMap<K, V>):EnumValueOrderedMap<K, V> {
        return new EnumValueOrderedMap<K, V>();
    }

    @:to static inline function toHashMap<K:{function hashCode():Int;}, V>(t:IOrderedMap<K, V>):HashOrderedMap<K, V> {
        return new HashOrderedMap<K, V>();
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

    @:from static inline function fromHashMap<K:{function hashCode():Int;}, V>(map:HashOrderedMap<K, V>):OrderedMap<Int, V> {
        return cast map;
    }

    @:from static inline function fromObjectMap<K:{}, V>(map:ObjectOrderedMap<K, V>):OrderedMap<Int, V> {
        return cast map;
    }
}

interface IOrderedMap<K, V> {
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
    function copy():IOrderedMap<K, V>;

    function toString():String;
}
