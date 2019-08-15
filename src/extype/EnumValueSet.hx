package extype;

import extype.Set.ISet;
import haxe.ds.EnumValueMap;

/**
    Represents a set of `EnumValue` values.
    You can iterate through the values of a set in insertion order.
**/
class EnumValueSet<T:EnumValue> implements ISet<T> {
    final keys:EnumValueMap<T, Int>;
    final values:Array<T>;

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        this.keys = new EnumValueMap();
        this.values = [];
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:T):Void {
        if (!keys.exists(value)) {
            keys.set(value, values.length);
            values.push(value);
        }
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public function exists(value:T):Bool {
        return keys.exists(value);
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:T):Bool {
        final index = keys.get(value);
        return if (index != null) {
            keys.remove(value);
            values.splice(index, 1);
            true;
        } else {
            false;
        }
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    public function iterator():Iterator<T> {
        return values.iterator();
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():EnumValueSet<T> {
        final set = new EnumValueSet();
        for (x in inline iterator()) set.add(x);
        return set;
    }

    /**
        Reterns a new array that contains the values in this set.
    **/
    public function array():Array<T> {
        return values.copy();
    }

    inline function get_length():Int {
        return values.length;
    }
}
