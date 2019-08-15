package extype;

import haxe.display.JsonModuleTypes.JsonExpr;
import extype.Set.ISet;
#if js
import js.Syntax;
import js.lib.Set in JsSet;
#else
import haxe.ds.IntMap;
#end

/**
    Represents a set of `Int` values.
    You can iterate through the values of a set in insertion order.
**/
class IntSet implements ISet<Int> {
    #if js
    final set:JsSet<Int>;
    #else
    final keys:IntMap<Int>;
    final values:Array<Int>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.set = new JsSet();
        #else
        this.keys = new IntMap();
        this.values = [];
        #end
    }

    /**
        Adds a specified value to this set.
    **/
    public function add(value:Int):Void {
        #if js
        set.add(value);
        #else
        if (!keys.exists(value)) {
            keys.set(value, values.length);
            values.push(value);
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
        return keys.exists(value);
        #end
    }

    /**
        Removes a specified value to this set and returns true if such a value existed, false otherwise.
    **/
    public function remove(value:Int):Bool {
        #if js
        return set.delete(value);
        #else
        final index = keys.get(value);
        return if (index != null) {
            keys.remove(value);
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
    public function iterator():Iterator<Int> {
        #if js
        return new extype.js.IteratorAdapter(set.values());
        #else
        return values.iterator();
        #end
    }

    /**
        Returns a new shallow copy of this set.
    **/
    public function copy():IntSet {
        final copy = new IntSet();
        for (x in inline iterator()) copy.add(x);
        return copy;
    }

    /**
        Reterns a new array that contains the values in this set.
    **/
    public function array():Array<Int> {
        #if js
        return Syntax.code("Array.from({0})", set);
        #else
        return values.copy();
        #end
    }

    inline function get_length():Int {
        #if js
        return set.size;
        #else
        return values.length;
        #end
    }
}
