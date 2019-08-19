package extype;

@:forward(length, exists, iterator, copy, array, toString)
abstract ReadOnlySet<T>(Set<T>) from Set<T> {}
