package extype;

import haxe.ds.Option;

abstract Maybe<T>(Null<T>) {
    extern inline function new(x: Null<T>) {
        this = x;
    }

    @:from
    public static function of<T>(x: T): Maybe<T> {
        return new Maybe(x);
    }

    public static extern inline function empty<T>(): Maybe<T> {
        return null;
    }

    public extern inline function get(): Null<T> {
        return this;
    }

    public extern inline function getUnsafe(): T {
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

    public inline function fold<U>(ifEmpty: Void -> U, fn: T -> U): U {
        return if (nonEmpty()) {
            fn(this);
        } else {
            ifEmpty();
        }
    }

    @:to
    public inline function toOption(): Option<T> {
        return if (nonEmpty()) {
            Some(this);
        } else {
            None;
        }
    }

    @:from
    public static inline function fromOption<T>(x: Option<T>): Maybe<T> {
        return switch (x) {
            case Some(v): Maybe.of(v);
            case None: Maybe.empty();
        }
    } 
}