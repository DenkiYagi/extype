package extype;

typedef Map<K, V> = haxe.ds.Map<K, V>;

interface IMap<K, V> extends haxe.Constraints.IMap<K, V> {
    /**
        Returns the number of key/value pairs in this Map object.
    **/
    var length(get, never):Int;
}
