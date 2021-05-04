package extype;

@:forward(length, exists, iterator, copy, array, toString)
abstract ReadOnlySet<T>(SetLike<T>) from Set.ISet<T> {}

private typedef SetLike<T> = {
    var length(get, never):Int;
    function add(value:T):Void;
    function exists(value:T):Bool;
    function remove(value:T):Bool;
    function iterator():Iterator<T>;
    function copy():SetLike<T>;
    function array():Array<T>;
    function toString():String;
    function clear():Void;
}
