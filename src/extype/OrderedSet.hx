package extype;

/**
    Represents a set of values.
    You can iterate through the values in insertion order.

    This is a multi-type abstract, it is instantiated as one of its specialization types
    depending on its type parameters.
**/
import extype.orderedset.StringOrderedSet;
import extype.orderedset.IntOrderedSet;
import extype.orderedset.EnumValueOrderedSet;
import extype.orderedset.ObjectOrderedSet;

@:multiType
abstract OrderedSet<T>(IOrderedSet<T>) {
    /**
        Creates a new Set.

        This becomes a constructor call to one of the specialization types in the output.
        The rules for that are as follows:

        1. if `T` is a `String`, `extype.orderedset.StringOrderedSet` is used
        2. if `T` is an `Int`, `extype.orderedset.IntOrderedSet` is used
        3. if `T` is an `EnumValue`, `extype.orderedset.EnumValueOrderedSet` is used
        4. if `T` is an `{function hashCode():Int;}`, `extype.orderedset.HashOrderedSet` is used
        5. if `T` is any other class or structure, `extype.orderedset.ObjectOrderedSet` is used
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
    public inline function copy():OrderedSet<T> {
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

    @:to static inline function toStringSet<T:String>(x:IOrderedSet<T>):StringOrderedSet {
        return new StringOrderedSet();
    }

    @:to static inline function toIntSet<T:Int>(x:IOrderedSet<T>):IntOrderedSet {
        return new IntOrderedSet();
    }

    @:to static inline function toEnumValueSet<T:EnumValue>(x:IOrderedSet<T>):EnumValueOrderedSet<T> {
        return new EnumValueOrderedSet();
    }

    @:to static inline function toObjectSet<T:{}>(x:IOrderedSet<T>):ObjectOrderedSet<T> {
        return new ObjectOrderedSet();
    }

    @:from static inline function fromIntSet(x:IntOrderedSet):OrderedSet<Int> {
        return cast x;
    }

    @:from static inline function fromStringSet(x:StringOrderedSet):OrderedSet<String> {
        return cast x;
    }

    @:from static inline function fromEnumValueSet<T:EnumValue>(x:EnumValueOrderedSet<T>):OrderedSet<T> {
        return cast x;
    }

    @:from static inline function fromObjectSet<T:{}>(x:ObjectOrderedSet<T>):OrderedSet<T> {
        return cast x;
    }

    @:to inline function toSet():Set<T> {
        return cast (this : Set.ISet<T>);
    }
}

interface IOrderedSet<T> extends Set.ISet<T> {
    function copy():IOrderedSet<T>;
}
