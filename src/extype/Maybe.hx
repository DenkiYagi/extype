package extype;

abstract Maybe<T>(Null<T>) from Null<T> {
    @:extern public static inline function of<T>(x: T): Maybe<T> {
        if (x == null) throw new Error("No value");
        return x;
    }

    @:extern public static inline function ofNullable<T>(x: Null<T>): Maybe<T> {
        return x;
    }

    @:extern public static inline function empty<T>(): Maybe<T> {
        return null;
    }

    public inline function get(): Null<T> {
        return this;
    }

    public inline function getOrElse(x: T): T {
        return if (nonEmpty()) {
            this;
        } else {
            x;
        }
    }

    public inline function getOrThrow(): T {
        if (isEmpty()) throw new Error("No value");
        return this;
    }

    public inline function isEmpty(): Bool {
        return this == null;
    }

    public inline function nonEmpty(): Bool {
        return this != null;
    }

    public inline function forEach(fn: T -> Void): Void {
        if (nonEmpty()) fn(this);
    }

    public inline function map<U>(fn: T -> U): Maybe<U> {
        return if (nonEmpty()) {
            fn(this);
        } else {
            empty();
        }
    }

    public inline function flatMap<U>(fn: T -> Maybe<U>): Maybe<U> {
        return if (nonEmpty()) {
            fn(this);
        } else {
            empty();
        }
    }

    public inline function filter(fn: T -> Bool): Maybe<T> {
        return if (nonEmpty() && fn(this)) {
            this;
        } else {
            empty();
        }
    }

    public inline function match<U>(fn: T -> U, elseFn: Void -> U): U {
        return if (nonEmpty()) {
            fn(this);
        } else {
            elseFn();
        }
    }
}