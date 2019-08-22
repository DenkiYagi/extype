package extype.orderedset;

import extype.OrderedSet.IOrderedSet;
#if js
import js.Syntax;
import js.lib.Set in JsSet;
import extype.iterator.js.IteratorAdapter;
#else
import haxe.ds.IntMap;
import extype.LinkedList;
#end

/**
    Represents a set of `Int` values.
    You can iterate through the values in insertion order.
**/
class OrderedIntSet implements IOrderedSet<Int> {
    #if js
    final set:JsSet<Int>;
    #else
    final map:IntMap<LinkedListNode<Int>>;
    final list:LinkedList<Int>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.set = new JsSet();
        #else
        this.map = new IntMap();
        this.list = new LinkedList();
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:Int):Void {
        #if js
        set.add(value);
        #else
        if (!map.exists(value)) {
            addInternal(value);
        }
        #end
    }

    /**
        Returns true if this set has a specified value, false otherwise.
    **/
    public function exists(value:Int):Bool {
        #if js
        return set.has(value);
        #else
        return map.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:Int):Bool {
        #if js
        return set.delete(value);
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
    public function iterator():IteratorAdapter<Int> {
        return new IteratorAdapter(set.values());
    }
    #else
    public function iterator():LinkedListIterator<Int> {
        return list.iterator();
    }
    #end

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():OrderedIntSet {
        final copy = new OrderedIntSet();
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
    public function array():Array<Int> {
        #if js
        return Syntax.code("Array.from({0})", set);
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
        return '{${array().join(",")}}';
    }

    inline function iter(fn:(value:Int) -> Void):Void {
        #if js
        set.forEach((x, _, _) -> fn(x));
        #else
        list.iter(fn);
        #end
    }

    inline function get_length():Int {
        #if js
        return set.size;
        #else
        return list.length;
        #end
    }

    #if !js
    inline function addInternal(value:Int):Void {
        map.set(value, list.add(value));
    }
    #end
}
