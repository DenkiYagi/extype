package extype.set;

import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Set in JsSet;
import extype.iterator.js.IteratorAdapter;
#else
import extype.Unit;
import extype.map.IntMap;
#end

/**
    Represents a set of `Int` values.
**/
class IntSet implements ISet<Int> {
    #if js
    final set:JsSet<Int>;
    #else
    final map:IntMap<Unit>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public inline function new() {
        #if js
        this.set = new JsSet();
        #else
        this.map = new IntMap();
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public inline function add(value:Int):Void {
        #if js
        set.add(value);
        #else
        map.set(value, new Unit());
        #end
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public inline function exists(value:Int):Bool {
        #if js
        return set.has(value);
        #else
        return map.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public inline function remove(value:Int):Bool {
        #if js
        return set.delete(value);
        #else
        return map.remove(value);
        #end
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    #if js
    public inline function iterator():IteratorAdapter<Int> {
        return new IteratorAdapter(set.values());
    }
    #else
    public inline function iterator():Iterator<Int> {
        return map.keys();
    }
    #end

    /**
        Returns a new shallow copy of this set.
    **/
    public inline function copy():IntSet {
        final copy = new IntSet();
        for (x in this) {
            copy.add(x);
        }
        return copy;
    }

    /**
        Reterns a new array that contains the values of this set.
    **/
    public inline function array():Array<Int> {
        #if js
        return Syntax.code("Array.from({0})", set);
        #else
        final array = [];
        for (x in this) {
            array.push(x);
        }
        return array;
        #end
    }

    /**
        Returns a String representation of this set.
    **/
    public inline function toString():String {
        return '{${array().join(",")}}';
    }

    inline function get_length():Int {
        #if js
        return set.size;
        #else
        return map.length;
        #end
    }
}
