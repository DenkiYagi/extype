package extype;

/**
    Represents a value with lazy initialization.
**/
abstract Lazy<T>(LazyInternal<T>) {
    /**
        Gets a value that indicates whether a value has been initialized.
    **/
    public var isInitialized(get, never):Bool;

    inline function get_isInitialized():Bool {
        return switch (this) {
            case Uninitialized(_): false;
            case Initialized(_): true;
        }
    }

    public inline function new(fn:()->T) {
        this = Uninitialized(fn);
    }

    /**
        Gets the lazily initialized value.
    **/
    public inline function get():T {
        return switch (this) {
            case Uninitialized(fn):
                final value = fn();
                this = Initialized(value);
                value;
            case Initialized(value):
                value;
        }
    }
}

private enum LazyInternal<T> {
    Uninitialized(fn:()->T);
    Initialized(value:T);
}
