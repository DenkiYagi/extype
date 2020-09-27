package extype.tools;

import extype.Nullable;
import extype.NoDataException;
import extype.Maybe;
import haxe.ds.Option;

class MaybeTools {
    public static inline function toNullable<T>(maybe:Maybe<T>):Nullable<T> {
        return switch (maybe) {
            case Some(v): Nullable.of(v);
            case None: Nullable.empty();
        }
    }

    public static inline function toOption<T>(maybe:Maybe<T>):Option<T> {
        return switch (maybe) {
            case Some(v): Option.Some(v);
            case None: Option.None;
        }
    }

    public static inline function isEmpty<T>(maybe:Maybe<T>):Bool {
        return switch (maybe) {
            case Some(_): false;
            case None: true;
        }
    }

    public static inline function nonEmpty<T>(maybe:Maybe<T>):Bool {
        return switch (maybe) {
            case Some(_): true;
            case None: false;
        }
    }

    public static inline function get<T>(maybe:Maybe<T>):Null<T> {
        return switch (maybe) {
            case Some(v): v;
            case None: null;
        }
    }

    #if !target.static
    public static inline function getUnsafe<T>(maybe:Maybe<T>):T {
        return switch (maybe) {
            case Some(v): v;
            case None: null;
        }
    }
    #end

    public static inline function getOrThrow<T>(maybe:Maybe<T>, ?errorFn:() -> Dynamic):T {
        switch (maybe) {
            case Some(v): return v;
            case None: throw (errorFn == null) ? new NoDataException() : errorFn();
        }
    }

    public static inline function getOrElse<T>(maybe:Maybe<T>, x:T):T {
        return switch (maybe) {
            case Some(v): v;
            case None: x;
        }
    }

    public static inline function orElse<T>(maybe:Maybe<T>, x:Maybe<T>):Maybe<T> {
        return switch (maybe) {
            case Some(v): maybe;
            case None: x;
        }
    }

    public static inline function map<T, U>(maybe:Maybe<T>, fn:T->U):Maybe<U> {
        return switch (maybe) {
            case Some(a): Some(fn(a));
            case None: None;
        }
    }

    public static inline function flatMap<T, U>(maybe:Maybe<T>, fn:T->Maybe<U>):Maybe<U> {
        return switch (maybe) {
            case Some(a): fn(a);
            case None: None;
        }
    }

    public static inline function flatten<T>(maybe:Maybe<Maybe<T>>):Maybe<T> {
        return switch (maybe) {
            case Some(Some(a)): Some(a);
            case _: None;
        }
    }

    public static inline function has<T>(maybe:Maybe<T>, value:T):Bool {
        return switch (maybe) {
            case Some(a) if (a == value): true;
            case _: false;
        }
    }

    public static inline function exists<T>(maybe:Maybe<T>, fn:T->Bool):Bool {
        return switch (maybe) {
            case Some(a) if (fn(a)): true;
            case _: false;
        }
    }

    public static inline function find<T>(maybe:Maybe<T>, fn:T->Bool):Null<T> {
        return switch (maybe) {
            case Some(a) if (fn(a)): a;
            case _: null;
        }
    }

    public static inline function filter<T>(maybe:Maybe<T>, fn:T->Bool):Maybe<T> {
        return switch (maybe) {
            case Some(a) if (fn(a)): maybe;
            case _: None;
        }
    }

    public static inline function fold<T, U>(maybe:Maybe<T>, ifEmpty:()->U, fn:T->U):U {
        return switch (maybe) {
            case Some(v): fn(v);
            case None: ifEmpty();
        }
    }

    public static inline function iter<T>(maybe:Maybe<T>, fn:T->Void):Void {
        switch (maybe) {
            case Some(x): fn(x);
            case None:
        }
    }

    public static inline function match<T>(maybe:Maybe<T>, fn:T->Void, ifEmpty:()->Void):Void {
        switch (maybe) {
            case Some(x): fn(x);
            case None: ifEmpty();
        }
    }
}
