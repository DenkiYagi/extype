package extype;

import extype.OrderedSet.IOrderedSet;
#if js
import js.Syntax;
import js.lib.Map in JsMap;
import extype.js.IteratorAdapter;
#else
import extype.LinkedList;
import haxe.ds.HashMap;
#end

/**
    Represents a set of `{function hashCode():Int;}` values.
    You can iterate through the values in insertion order.
**/
class HashSet<T:{function hashCode():Int;}> implements IOrderedSet<T> {
    #if js
    final map:JsMap<Int, T>;
    #else
    final map:HashMap<T, LinkedListNode<T>>;
    final list:LinkedList<T>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.map = new JsMap();
        #else
        this.map = new HashMap();
        this.list = new LinkedList();
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:T):Void {
        #if js
        map.set(value.hashCode(), value);
        #else
        if (!map.exists(value)) {
            addInternal(value);
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
        return map.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:T):Bool {
        #if js
        return map.delete(value.hashCode());
        #else
        return if (map.exists(value)) {
            list.remove(map.get(value));
            map.remove(value);
            true;
        } else {
            false;
        }
        #end
    }

    /**
        Returns an Iterator over the values of this set.
    **/
    #if js
    public function iterator():IteratorAdapter<T> {
        return new IteratorAdapter(map.values());
    }
    #else
    public function iterator():LinkedListIterator<T> {
        return list.iterator();
    }
    #end

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():HashSet<T> {
        final copy = new HashSet();
        for (x in inline iterator()) {
            #if js
            copy.add(x);
            #else
            copy.addInternal(x);
            #end
        }
        return copy;
    }

    /**
        Reterns a new array that contains the values of this set.
    **/
    public function array():Array<T> {
        #if js
        return Syntax.code("Array.from({0})", map.values());
        #else
        final array = [];
        iter(array.push);
        return array;
        #end
    }

    /**
        Returns a String representation of this set.
    **/
    public function toString():String {
        final buff = [];
        iter(x -> buff.push(Std.string(x)));
        return '{${buff.join(",")}}';
    }

    inline function iter(fn:(value:T) -> Void):Void {
        #if js
        map.forEach((x, _, _) -> fn(x));
        #else
        list.iter(fn);
        #end
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #else
        return list.length;
        #end
    }

    #if !js
    inline function addInternal(value:T):Void {
        map.set(value, list.add(value));
    }
    #end
}
