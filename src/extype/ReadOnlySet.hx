package extype;

@:forward(length, exists, iterator, copy, toArray, toString)
abstract ReadOnlySet<T>(Set<T>) from Set<T> {}
