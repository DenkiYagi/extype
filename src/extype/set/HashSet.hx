package extype.set;

import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Map in JsMap;
import extype.js.IteratorAdapter;
#else
import extype.Unit;
import extype.map.IntMap;
#end

/**
    Represents a set of `{function hashCode():Int;}` values.
**/
class HashSet<T:{function hashCode():Int;}> implements ISet<T> {
    #if js
    final map:JsMap<Int, T>;
    #else
    final map:IntMap<T>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public inline function new() {
        #if js
        this.map = new JsMap();
        #else
        this.map = new IntMap();
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public inline function add(value:T):Void {
        map.set(value.hashCode(), value);
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public inline function exists(value:T):Bool {
        #if js
        return map.has(value.hashCode());
        #else
        return map.exists(value.hashCode());
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public inline function remove(value:T):Bool {
        #if js
        return map.delete(value.hashCode());
        #else
        return map.remove(value.hashCode());
        #end
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    #if js
    public inline function iterator():IteratorAdapter<T> {
        return new IteratorAdapter(map.values());
    }
    #else
    public inline function iterator():Iterator<T> {
        return map.iterator();
    }
    #end

    /**
        Returns a new shallow copy of this set.
    **/
    public inline function copy():ObjectSet<T> {
        final copy = new ObjectSet();
        for (x in this) {
            copy.add(x);
        }
        return copy;
    }

    /**
        Reterns a new array that contains the values of this set.
    **/
    public inline function array():Array<T> {
        #if js
        return Syntax.code("Array.from({0})", map.values());
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
        final buff = [];
        for (x in this) {
            buff.push(Std.string(x));
        }
        return '{${buff.join(",")}}';
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #else
        return map.length;
        #end
    }
}
