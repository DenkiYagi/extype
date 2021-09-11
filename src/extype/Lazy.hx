package extype;

/**
    Represents a lazy value.
**/
abstract Lazy<T>(LazyInternal<T>) {
    public inline function new(fn:()->T) {
        this = Init(fn);
    }

    /**
        Gets the lazily initialized value.
    **/
    public inline function get():T {
        return switch (this) {
            case Init(fn):
                final value = fn();
                this = Created(value);
                value;
            case Created(value):
                value;
        }
    }
}

private enum LazyInternal<T> {
    Init(fn:()->T);
    Created(value:T);
}
