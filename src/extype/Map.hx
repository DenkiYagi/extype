package extype;

import extype.map.StringMap;
import extype.map.IntMap;
import extype.map.EnumValueMap;
import extype.map.ObjectMap;
import haxe.macro.Context;
import haxe.macro.Expr;

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
    public inline function copy():Map<K, V> {
        return cast this.copy();
    }

    /**
        Returns a String representation of this Map.
    **/
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

    @:from static inline function fromObjectMap<K:{}, V>(map:ObjectMap<K, V>):Map<Int, V> {
        return cast map;
    }

    /**
        Creates a Map object from the map literal.
    **/
    public static macro function of(expr:Expr):Expr {
        return switch (expr.expr) {
            case EArrayDecl(elements):
                macro $b{
                    [macro final map = new extype.Map()].concat(elements.map(elem -> {
                        return switch (elem.expr) {
                            case EBinop(OpArrow, eKey, eVal):
                                macro map.set(${eKey}, ${eVal});
                            case _:
                                Context.error("Invalid syntax: expected a => b", elem.pos);
                        }
                    })).concat([macro map])
                };
            case _:
                Context.error("Invalid syntax: map literal required", expr.pos);
        }
    }
}

interface IMap<K, V> {
    var length(get, never):Int;

    function get(k:K):Null<V>;
    function set(k:K, v:V):Void;
    function exists(k:K):Bool;
    function remove(k:K):Bool;
    function keys():Iterator<K>;
    function iterator():Iterator<V>;
    function keyValueIterator():KeyValueIterator<K, V>;
    function copy():IMap<K, V>;
    function toString():String;
}
