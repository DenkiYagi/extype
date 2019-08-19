package extype;

@:forward(length, exists, iterator, copy, array, toString)
abstract ReadOnlySet<T>(OrderedSet<T>) from OrderedSet<T> {}
