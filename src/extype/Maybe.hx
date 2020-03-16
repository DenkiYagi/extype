package extype;

import haxe.ds.Option;

abstract Maybe<T>(Null<T>) {
    inline function new(x:Null<T>) {
        this = x;
    }

    @:from
    public static inline function of<T>(x:T):Maybe<T> {
        return new Maybe(x);
    }

    @:from
    public static inline function fromOption<T>(x:Option<T>):Maybe<T> {
        return switch (x) {
            case Some(v): Maybe.of(v);
            case None: Maybe.empty();
        }
    }

    @:to
    public inline function toOption():Option<T> {
        return if (nonEmpty()) {
            Some(this);
        } else {
            None;
        }
    }

    public static inline function empty<T>():Maybe<T> {
        return null;
    }

    public inline function get():Null<T> {
        return this;
    }

    public inline function getUnsafe():T {
        return this;
    }

    public inline function getOrThrow(?errorFn:() -> Error):T {
        if (isEmpty()) {
            throw (errorFn == null) ? new NoDataError() : errorFn();
        }
        return this;
    }

    public inline function getOrElse(x:T):T {
        return if (nonEmpty()) {
            this;
        } else {
            x;
        }
    }

    public inline function orElse(x:Maybe<T>):Maybe<T> {
        return if (nonEmpty()) {
            Maybe.of(this);
        } else {
            x;
        }
    }

    public inline function isEmpty():Bool {
        return this == null;
    }

    public inline function nonEmpty():Bool {
        return this != null;
    }

    public inline function iter(fn:(value:T) -> Void):Void {
        if (nonEmpty()) fn(this);
    }

    public inline function foreach(fn:(value:T) -> Bool):Void {
        if (nonEmpty()) fn(this);
    }

    public inline function map<U>(fn:(value:T) -> U):Maybe<U> {
        return if (nonEmpty()) {
            fn(this);
        } else {
            empty();
        }
    }

    public inline function flatMap<U>(fn:(value:T) -> Maybe<U>):Maybe<U> {
        return if (nonEmpty()) {
            fn(this);
        } else {
            empty();
        }
    }

    public inline function filter(fn:(value:T) -> Bool):Maybe<T> {
        return if (nonEmpty() && fn(this)) {
            this;
        } else {
            empty();
        }
    }

    public inline function fold<U>(ifEmpty:Void->U, fn:(value:T) -> U):U {
        return if (nonEmpty()) {
            fn(this);
        } else {
            ifEmpty();
        }
    }
}
