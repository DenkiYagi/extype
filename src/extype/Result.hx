package extype;

enum Result<T> {
    Success(value:T);
    Failure(error:Dynamic);
}
