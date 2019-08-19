package extype.util;

class TransformIterator<T, U> {
    final iterator:Iterator<T>;
    final transform:(value:T) -> U;

    public function new(iterator:Iterator<T>, transform:(value:T) -> U) {
        this.iterator = iterator;
        this.transform = transform;
    }

    public inline function hasNext():Bool {
        return iterator.hasNext();
    }

    public inline function next():U {
        return transform(iterator.next());
    }
}