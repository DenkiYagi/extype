package extype;

/**
    Represents a value with lazy initialization.
**/
class Lazy<T> {
    var value:LazyValue<T>;

    /**
        Gets a value that indicates whether a value has been initialized.
    **/
    public var isInitialized(get, never):Bool;

    inline function get_isInitialized():Bool {
        return switch (value) {
            case Uninitialized(_): false;
            case Initialized(_): true;
        }
    }

    public inline function new(fn:()->T) {
        this.value = Uninitialized(fn);
    }

    /**
        Gets the lazily initialized value.
    **/
    public inline function get():T {
        return switch (value) {
            case Uninitialized(fn):
                final x = fn();
                this.value = Initialized(x);
                x;
            case Initialized(x):
                x;
        }
    }
}

private enum LazyValue<T> {
    Uninitialized(fn:()->T);
    Initialized(x:T);
}
