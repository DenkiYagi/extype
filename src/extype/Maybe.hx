package extype;

@:using(extype.tools.MaybeTools)
enum Maybe<T> {
    Some(x:T);
    None;
}