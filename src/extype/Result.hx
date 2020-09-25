package extype;

@:using(extype.tools.ResultTools)
enum Result<T, E> {
    Success(value:T);
    Failure(error:E);
}
