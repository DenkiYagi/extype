package extype;

abstract Unit(Dynamic) {
    public inline function new() {
        this = null;
    }

    public static var _(get, never): Unit;
    static inline function get__() return new Unit();
}