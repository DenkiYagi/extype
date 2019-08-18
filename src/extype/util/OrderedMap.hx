package extype.internal;

import extype.Map.IMap;
#if js
import extype.js.IteratorAdapter;
import extype.js.KeyValueIteratorAdapter;
import js.lib.Map in JsMap;
#else
import haxe.ds.BalancedTree;
#end

@:noCompletion
class OrderedMap<K, V> implements IMap<K, V> {
    #if js
    final map:JsMap<K, V>;
    #else
    final btree:BalancedTree<K, V>;
    var size: Maybe<Int>;
    #end

    /**
        Returns the number of values in this set.
    **/
    public var length(get, never):Int;

    public function new() {
        #if js
        this.map = new JsMap();
        #else
        this.btree = new BalancedTree();
        this.size = Maybe.empty();
        #end
    }

    public function get(key:K):Maybe<V> {
        #if js
        return map.get(key);
        #else
        return btree.get(key);
        #end
    }

    public function set(key:K, value:V):Void {
        #if js
        map.set(key, value);
        #else
        btree.set(key, value);
        size = Maybe.empty();
        #end
    }

    public function exists(key:K):Bool {
        #if js
        return map.has(key);
        #else
        return btree.exists(key);
        #end
    }

    public function remove(key:K):Bool {
        #if js
        return map.delete(key);
        #else
        return if (btree.remove(key)) {
            size = Maybe.empty();
            true;
        } else {
            false;
        }
        #end
    }

    public function keys():Iterator<K> {
        #if js
        return new IteratorAdapter(map.keys());
        #else
        return btree.keys();
        #end
    }

    public function iterator():Iterator<V> {
        #if js
        return new IteratorAdapter(map.values());
        #else
        return btree.iterator();
        #end
    }

    public function keyValueIterator():KeyValueIterator<K, V> {
        #if js
        return new KeyValueIteratorAdapter(map.entries());
        #else
        return btree.keyValueIterator();
        #end
    }

    public function copy():OrderedMap<K, V> {
        final copy = new OrderedMap();
        for (x in inline keyValueIterator()) copy.set(x.key, x.value);
        return copy;
    }

    public function toString():String {
        #if js
        final entries = [];
        map.forEach((value, key, _) -> entries.push('${key}=>${value}'));
        return '{${entries.join(",")}}';
        #else
        return '{${[for (x in inline keyValueIterator()) '${x.key}=>${x.value}'].join(",")}}';
        #end
    }

    inline function get_length():Int {
        #if js
        return map.size;
        #else
        return if (size.isEmpty()) {
            final count = Lambda.count(btree);
            size = Maybe.of(count);
            count;
        } else {
            size.getUnsafe();
        }
        #end
    }
}