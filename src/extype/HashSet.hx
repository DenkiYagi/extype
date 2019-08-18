package extype;

import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Map in JsMap;
#else
import haxe.ds.HashMap;
#end

/**
    Represents a set of `{function hashCode():Int;}` values.
    You can iterate through the values of a set in insertion order.
**/
class HashSet<T:{function hashCode():Int;}> implements ISet<T> {
    #if js
    final map:JsMap<Int, T>;
    #else
    final indexes:HashMap<T, Int>;
    final values:Array<T>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.map = new JsMap();
        #else
        this.indexes = new HashMap();
        this.values = [];
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:T):Void {
        #if js
        map.set(value.hashCode(), value);
        #else
        if (!indexes.exists(value)) {
            indexes.set(value, values.length);
            values.push(value);
        }
        #end
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public function exists(value:T):Bool {
        #if js
        return map.has(value.hashCode());
        #else
        return indexes.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:T):Bool {
        #if js
        return map.delete(value.hashCode());
        #else
        final index = indexes.get(value);
        return if (index != null) {
            indexes.remove(value);
            values.splice(index, 1);
            true;
        } else {
            false;
        }
        #end
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    public function iterator():Iterator<T> {
        #if js
        return new extype.js.IteratorAdapter(map.values());
        #else
        return values.iterator();
        #end
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():HashSet<T> {
        final copy = new HashSet();
        #if js
        for (x in inline iterator()) copy.add(x);
        #else
        for (x in values) copy.add(x);
        #end
        return copy;
    }

    /**
        Reterns a new array that contains the values in this set.
    **/
    public function array():Array<T> {
        #if js
        return Syntax.code("Array.from({0})", map.values());
        #else
        return values.copy();
        #end
    }

    /**
        Returns a String representation of this set.
    **/
    public function toString():String {
        #if js
        return '{${[for (x in inline iterator()) Std.string(x)].join(",")}}';
        #else
        return '{${[for (x in values) Std.string(x)].join(",")}}';
        #end
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #else
        return values.length;
        #end
    }
}