package extype;

@:forward(length, exists, iterator, copy, array, toString)
abstract ReadOnlySet<T>(_Set<T>) from Set.ISet<T> {}

private typedef _Set<T> = {
    var length(get, never):Int;
    function add(value:T):Void;
    function exists(value:T):Bool;
    function remove(value:T):Bool;
    function iterator():Iterator<T>;
    function copy():_Set<T>;
    function array():Array<T>;
    function toString():String;
}
