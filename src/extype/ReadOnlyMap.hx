package extype;

@:forward(get, exists, keys, iterator, keyValueIterator, copy, toString)
abstract ReadOnlyMap<K, V>(haxe.Constraints.IMap<K, V>) {
    @:from static inline function fromMap<K, V>(map:Map<K, V>):ReadOnlyMap<K, V> {
        return cast map;
    }

    @:from static inline function fromHaxeMap<K, V>(map:haxe.ds.Map<K, V>):ReadOnlyMap<K, V> {
        return cast map;
    }

    public var length(get, never):Int;

    inline function get_length():Int {
        final map:Null<Map.IMap<K, V>> = Std.downcast(this, Map.IMap);
        return if (map != null) {
            map.length;
        } else {
            Lambda.count(map);
        }
    }
}
