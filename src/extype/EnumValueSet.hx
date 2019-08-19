package extype;

import extype.Set.ISet;
import extype.LinkedNodeList;
import haxe.ds.EnumValueMap;

/**
    Represents a set of `EnumValue` values.
    You can iterate through the values in insertion order.
**/
class EnumValueSet<T:EnumValue> implements ISet<T> {
    final map:EnumValueMap<T, LinkedNode<T>>;
    final list:LinkedNodeList<T>;

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        this.map = new EnumValueMap();
        this.list = new LinkedNodeList();
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:T):Void {
        if (!map.exists(value)) {
            addInternal(value);
        }
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public function exists(value:T):Bool {
        return map.exists(value);
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:T):Bool {
        return if (map.exists(value)) {
            list.remove(map.get(value));
            map.remove(value);
            true;
        } else {
            false;
        }
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    public function iterator():LinkedNodeIterator<T> {
        return list.iterator();
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():EnumValueSet<T> {
        final copy = new EnumValueSet();
        for (x in inline iterator()) {
            copy.addInternal(x);
        }
        return copy;
    }

    /**
        Reterns a new array that contains the values in this set.
    **/
    public function array():Array<T> {
        final array = [];
        iter(array.push);
        return array;
    }

    /**
        Returns a String representation of this set.
    **/
    public function toString():String {
        return '{${array().join(",")}}';
    }

    inline function iter(fn:(value:T) -> Void):Void {
        list.iter(fn);
    }

    inline function get_length():Int {
        return list.length;
    }

    inline function addInternal(value:T):Void {
        map.set(value, list.add(value));
    }
}
