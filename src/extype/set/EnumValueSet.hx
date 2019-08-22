package extype.set;

import extype.Set.ISet;
import extype.Unit;
import extype.map.EnumValueMap;

/**
    Represents a set of `EnumValue` values.
**/
class EnumValueSet<T:EnumValue> implements ISet<T> {
    final map:EnumValueMap<T, Bool>;

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public inline function new() {
        this.map = new EnumValueMap();
    }

    /**
        Adds a specified value to this set.
    **/
    public inline function add(value:T):Void {
        map.set(value, true);
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public inline function exists(value:T):Bool {
        return map.exists(value);
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public inline function remove(value:T):Bool {
        return map.remove(value);
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    public inline function iterator():Iterator<T> {
        return map.keys();
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public inline function copy():EnumValueSet<T> {
        final copy = new EnumValueSet();
        for (x in this) {
            copy.add(x);
        }
        return copy;
    }

    /**
        Reterns a new array that contains the values of this set.
    **/
    public inline function array():Array<T> {
        final array = [];
        for (x in this) {
            array.push(x);
        }
        return array;
    }

    /**
        Returns a String representation of this set.
    **/
    public inline function toString():String {
        final buff = [];
        for (x in this) {
            buff.push(Std.string(x));
        }
        return '{${buff.join(",")}}';
    }

    inline function get_length():Int {
        return map.length;
    }
}
