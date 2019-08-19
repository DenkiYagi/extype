package extype.orderedmap;

import extype.OrderedMap.IOrderedMap;
#if js
import js.lib.Map in JsMap;
import extype.js.IteratorAdapter;
import extype.js.KeyValueIteratorAdapter;
#else
import extype.LinkedList;
import extype.util.TransformIterator;
import haxe.ds.StringMap in HaxeMap;
#end

/**
    Represents a Map object of `String` keys.
    You can iterate through the keys in insertion order.
**/
class StringOrderedMap<V> implements IOrderedMap<String, V> {
    #if js
    final map:JsMap<String, V>;
    #else
    final map:HaxeMap<LinkedListNode<Pair<String, V>>>;
    final list:LinkedList<Pair<String, V>>;
    #end

    /**
        Returns the number of key/value pairs in this Map object.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.map = new JsMap();
        #else
        this.map = new HaxeMap();
        this.list = new LinkedList();
        #end
    }

    /**
        Returns the current mapping of `key`.
    **/
    public function get(key:String):Null<V> {
        #if js
        return map.get(key);
        #else
        final node = Maybe.of(map.get(key));
        return node.map(x -> x.value.value2).get();
        #end
    }

    /**
        Maps key to value.

        If `key` already has a mapping, the previous value disappears.

        If `key` is `null`, the result is unspecified.
    **/
    public function set(key:String, value:V):Void {
        #if js
        map.set(key, value);
        #else
        if (map.exists(key)) {
            list.remove(map.get(key));
        }
        map.set(key, list.add(new Pair(key, value)));
        #end
    }

    /**
        Returns true if key `has` a mapping, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public function exists(key:String):Bool {
        #if js
        return map.has(key);
        #else
        return map.exists(key);
        #end
    }

    /**
        Removes the mapping of key and returns true if such a mapping existed, false otherwise.

        If `key` is `null`, the result is unspecified.
    **/
    public function remove(key:String):Bool {
        #if js
        return map.delete(key);
        #else
        return if (map.exists(key)) {
            list.remove(map.get(key));
            map.remove(key);
            true;
        } else {
            false;
        }
        #end
    }

    /**
        Returns an Iterator over the keys of this Map.
    **/
    public function keys():Iterator<String> {
        #if js
        return new IteratorAdapter(map.keys());
        #else
        return new TransformIterator(list.iterator(), pair -> pair.value1);
        #end
    }

    /**
        Returns an Iterator over the values of this Map.
    **/
    public function iterator():Iterator<V> {
        #if js
        return new IteratorAdapter(map.values());
        #else
        return new TransformIterator(list.iterator(), pair -> pair.value2);
        #end
    }

    /**
        Returns an Iterator over the keys and values of this Map.
    **/
    public function keyValueIterator():KeyValueIterator<String, V> {
        #if js
        return new KeyValueIteratorAdapter(map.entries());
        #else
        return new TransformIterator(list.iterator(), pair -> new StringMapEntry(pair.value1, pair.value2));
        #end
    }

    /**
        Returns a shallow copy of this Map.
    **/
    public function copy():StringOrderedMap<V> {
        final newMap = new StringOrderedMap();
        #if js
        map.forEach((v, k, _) -> newMap.set(k, v));
        #else
        list.iter(pair -> newMap.set(pair.value1, pair.value2));
        #end
        return newMap;
    }

    /**
        Returns a String representation of this Map.
    **/
    public function toString():String {
        final buff = [];
        #if js
        map.forEach((v, k, _) -> buff.push('${k}=>${v}'));
        #else
        list.iter(pair -> buff.push('${pair.value1}=>${pair.value2}'));
        #end
        return '{${buff.join(",")}}';
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #else
        return list.length;
        #end
    }
}

private class StringMapEntry<V> {
    public var key:String;
    public var value:V;

    public function new(key:String, value:V) {
        this.key = key;
        this.value = value;
    }
}
