package extype;

import utest.ui.Report;
import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Set in JsSet;
#else
import haxe.ds.ObjectMap;
#end

/**
    Represents a set of object values.
    You can iterate through the values of a set in insertion order.
**/
class ObjectSet<T:{}> implements ISet<T> {
    #if js
    final set:JsSet<T>;
    #else
    final indexes:ObjectMap<T, Int>;
    final values:Array<T>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.set = new JsSet();
        #else
        this.indexes = new ObjectMap();
        this.values = [];
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:T):Void {
        #if js
        set.add(value);
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
        return set.has(value);
        #else
        return indexes.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:T):Bool {
        #if js
        return set.delete(value);
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
        return new extype.js.IteratorAdapter(set.values());
        #else
        return values.iterator();
        #end
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():ObjectSet<T> {
        final copy = new ObjectSet();
        for (x in inline iterator()) copy.add(x);
        return copy;
    }

    /**
        Reterns a new array that contains the values in this set.
    **/
    public function array():Array<T> {
        #if js
        return Syntax.code("Array.from({0})", set);
        #else
        return values.copy();
        #end
    }

    /**
        Returns a String representation of this set.
    **/
    public inline function toString():String {
        return '{${[for (x in this) Std.string(x)].join(",")}}';
    }

    inline function get_length():Int {
        #if js
        return set.size;
        #else
        return values.length;
        #end
    }
}
