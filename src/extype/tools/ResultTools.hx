package extype.tools;

import extype.Result;
import haxe.ds.Either;

class ResultTools {
    public static inline function toEither<T, E>(result:Result<T, E>):Either<E, T> {
        return switch (result) {
            case Success(value): Right(value);
            case Failure(error): Left(error);
        }
    }

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

    public static inline function get<T, E>(result:Result<T, E>):Null<T> {
        return switch (result) {
            case Success(v): v;
            case Failure(e): null;
        }
    }

    #if !target.static
    public static inline function getUnsafe<T, E>(result:Result<T, E>):T {
        return switch (result) {
            case Success(v): v;
            case Failure(e): null;
        }
    }
    #end

    public static inline function getOrThrow<T, E>(result:Result<T, E>, ?errorFn:() -> Dynamic):T {
        switch (result) {
            case Success(v): return v;
            case Failure(e): throw (errorFn == null) ? e : errorFn();
        }
    }

    public static inline function getOrElse<T, E>(result:Result<T, E>, x:T):T {
        return switch (result) {
            case Success(v): v;
            case Failure(e): x;
        }
    }

    public static inline function orElse<T, E>(result:Result<T, E>, x:Result<T, E>):Result<T, E> {
        return switch (result) {
            case Success(v): Success(v);
            case Failure(e): x;
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
