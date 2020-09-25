package extype.tools;

import extype.Result;

class ResultTools {
    public static inline function isSuccess<T, E>(result:Result<T, E>):Bool {
        return switch (result) {
            case Success(_): true;
            case Failure(_): false;
        }
    }

    public static inline function isFailure<T, E>(result:Result<T, E>):Bool {
        return switch (result) {
            case Success(_): false;
            case Failure(_): true;
        }
    }

    public static inline function map<T, E, U>(result:Result<T, E>, fn:T->U):Result<U, E> {
        return switch (result) {
            case Success(v): Success(fn(v));
            case Failure(v): Failure(v);
        }
    }

    public static inline function flatMap<T, E, U>(result:Result<T, E>, fn:T->Result<U, E>):Result<U, E> {
        return switch (result) {
            case Success(v): fn(v);
            case Failure(v): Failure(v);
        }
    }

    public static inline function mapFailure<T, E, EE>(result:Result<T, E>, fn:E->EE):Result<T, EE> {
        return switch (result) {
            case Success(v): Success(v);
            case Failure(v): Failure(fn(v));
        }
    }

    public static inline function flatMapFailure<T, E, EE>(result:Result<T, E>, fn:E->Result<T, EE>):Result<T, EE> {
        return switch (result) {
            case Success(v): Success(v);
            case Failure(v): fn(v);
        };
    }

    public static inline function fold<T, E, U>(result:Result<T, E>, fnSuccess:T->U, fnFailure:E->U):U {
        return switch (result) {
            case Success(v): fnSuccess(v);
            case Failure(v): fnFailure(v);
        }
    }

    public static inline function iter<T, E>(result:Result<T, E>, fn:T->Void):Void {
        switch (result) {
            case Success(v): fn(v);
            case Failure(v):
        }
    }

    public static inline function match<T, E>(result:Result<T, E>, fnSuccess:T->Void, fnFailure:E->Void):Void {
        switch (result) {
            case Success(v): fnSuccess(v);
            case Failure(v): fnFailure(v);
        }
    }
}
