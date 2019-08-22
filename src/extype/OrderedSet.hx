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
import extype.orderedset.HashOrderedSet;
import extype.orderedset.ObjectOrderedSet;

@:multiType
@:forward
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

    @:to static inline function toStringSet<T:String>(x:IOrderedSet<T>):StringOrderedSet {
        return new StringOrderedSet();
    }

    @:to static inline function toIntSet<T:Int>(x:IOrderedSet<T>):IntOrderedSet {
        return new IntOrderedSet();
    }

    @:to static inline function toEnumValueSet<T:EnumValue>(x:IOrderedSet<T>):EnumValueOrderedSet<T> {
        return new EnumValueOrderedSet();
    }

    @:to static inline function toHashSet<T:{function hashCode():Int;}>(x:IOrderedSet<T>):HashOrderedSet<T> {
        return new HashOrderedSet();
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

    @:from static inline function fromHashSet<T:{function hashCode():Int;}>(x:HashOrderedSet<T>):OrderedSet<T> {
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
