package extype;

abstract Unit(Dynamic) {
    public extern inline function new() {
        #if js
        this = js.Lib.undefined;
        #else
        this = null;
        #end
    }

    public static final _ = new Unit();
}
