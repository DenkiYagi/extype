package extype.set;

import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Set in JsSet;
import extype.iterator.js.IteratorAdapter;
#else
import extype.Unit;
import extype.map.ObjectMap;
#end

/**
    Represents a set of `{}` values.
**/
class ObjectSet<T:{}> implements ISet<T> {
    #if js
    final set:JsSet<T>;
    #else
    final map:ObjectMap<T, Unit>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public inline function new() {
        #if js
        this.set = new JsSet();
        #else
        this.map = new ObjectMap();
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public inline function add(value:T):Void {
        #if js
        set.add(value);
        #else
        map.set(value, new Unit());
        #end
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public inline function exists(value:T):Bool {
        #if js
        return set.has(value);
        #else
        return map.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public inline function remove(value:T):Bool {
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
    public inline function iterator():IteratorAdapter<T> {
        return new IteratorAdapter(set.values());
    }
    #else
    public inline function iterator():Iterator<T> {
        return map.keys();
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
        final buff = [];
        for (x in this) {
            buff.push(Std.string(x));
        }
        return '{${buff.join(",")}}';
    }

    inline function get_length():Int {
        #if js
        return set.size;
        #else
        return map.length;
        #end
    }
}
