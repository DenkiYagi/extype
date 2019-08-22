package extype;

import extype.set.StringSet;
import extype.set.IntSet;
import extype.set.EnumValueSet;
import extype.set.ObjectSet;
import haxe.macro.Context;
import haxe.macro.Expr;

/**
    Represents a set of values.

    This is a multi-type abstract, it is instantiated as one of its specialization types
    depending on its type parameters.
**/
@:multiType
abstract Set<T>(ISet<T>) {
    /**
        Creates a new Set.

        This becomes a constructor call to one of the specialization types in the output.
        The rules for that are as follows:

        1. if `T` is a `String`, `extype.StringSet` is used
        2. if `T` is an `Int`, `extype.IntSet` is used
        3. if `T` is an `EnumValue`, `extype.EnumValueSet` is used
        5. if `T` is any other class or structure, `extype.ObjectSet` is used
        6. if `T` is any other type, it causes a compile-time error
    **/
    public function new();

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    inline function get_length():Int {
        return this.length;
    }

    /**
        Adds a specified value to this set.
    **/
    public inline function add(value:T):Void {
        this.add(value);
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public inline function exists(value:T):Bool {
        return this.exists(value);
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public inline function remove(value:T):Bool {
        return this.remove(value);
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    public inline function iterator():Iterator<T> {
        return this.iterator();
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public inline function copy():Set<T> {
        return cast this.copy();
    }

    /**
        Reterns a new array that contains the values of this set.
    **/
    public inline function array():Array<T> {
        return this.array();
    }

    /**
        Returns a String representation of this set.
    **/
    public inline function toString():String {
        return this.toString();
    }

    @:to static inline function toStringSet<T:String>(x:ISet<T>):StringSet {
        return new StringSet();
    }

    @:to static inline function toIntSet<T:Int>(x:ISet<T>):IntSet {
        return new IntSet();
    }

    @:to static inline function toEnumValueSet<T:EnumValue>(x:ISet<T>):EnumValueSet<T> {
        return new EnumValueSet();
    }

    @:to static inline function toObjectSet<T:{}>(x:ISet<T>):ObjectSet<T> {
        return new ObjectSet();
    }

    @:from static inline function fromStringSet(x:StringSet):Set<String> {
        return cast x;
    }

    @:from static inline function fromIntSet(x:IntSet):Set<Int> {
        return cast x;
    }

    @:from static inline function fromEnumValueSet<T:EnumValue>(x:EnumValueSet<T>):Set<T> {
        return cast x;
    }

    @:from static inline function fromObjectSet<T:{}>(x:ObjectSet<T>):Set<T> {
        return cast x;
    }

    /**
        Creates a Set object from the array literal.
    **/
    public static macro function of(expr:Expr):Expr {
        return switch (expr.expr) {
            case EArrayDecl(elements):
                macro $b{
                    [macro final set = new extype.Set()].concat(elements.map(elem -> {
                        return macro set.add(${elem});
                    })).concat([macro set])
                };
            case _:
                Context.error("Invalid syntax: array literal required", expr.pos);
        }
    }
}

interface ISet<T> {
    var length(get, never):Int;

    function add(value:T):Void;
    function exists(value:T):Bool;
    function remove(value:T):Bool;
    function iterator():Iterator<T>;
    function copy():ISet<T>;
    function array():Array<T>;
    function toString():String;
}
