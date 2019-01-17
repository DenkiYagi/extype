package extype;

abstract Maybe<T>(Null<T>) {
    @:expose inline function new(x: Null<T>) {
        this = x;
    }

    @:extern public static inline function of<T>(x: T): Maybe<T> {
        if (x == null) throw new Error("No value");
        return new Maybe(x);
    }

    @:from
    @:extern public static inline function ofNullable<T>(x: Null<T>): Maybe<T> {
        #if js
        return new Maybe((x == null) ? null : x);
        #else
        return new Maybe(x);
        #end
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
        #if js
        return untyped __strict_eq__(this, null);
        #else
        return this == null;
        #end
    }

    public inline function nonEmpty(): Bool {
        #if js
        return untyped __strict_neq__(this, null);
        #else
        return this != null;
        #end
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