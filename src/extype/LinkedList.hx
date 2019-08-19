package extype;

import extype.Maybe;

/**
    Represents a doubly linked list.
**/
class LinkedList<T> {
    public var first(default, null):Maybe<LinkedListNode<T>>;
    public var last(default, null):Maybe<LinkedListNode<T>>;
    public var length(default, null):Int;

    public function new(?iterable:Iterable<T>) {
        this.first = Maybe.empty();
        this.last = Maybe.empty();
        this.length = 0;

        if (iterable != null) {
            for (x in iterable) add(x);
        }
    }

    public function add(value:T):LinkedListNode<T> {
        final node = new LinkedListNode(this, value);

        if (length == 0) {
            first = Maybe.of(node);
            last = Maybe.of(node);
        } else {
            last.getUnsafe().append(node);
            last = Maybe.of(node);
        }
        length++;

        return node;
    }

    public function exists(node:LinkedListNode<T>):Bool {
        return node.list == this;
    }

    public function remove(node:LinkedListNode<T>):Bool {
        return if (node.list == this) {
            if (node == first) first = first.getUnsafe().next;
            if (node == last) last = last.getUnsafe().prev;
            node.remove();
            length--;
            true;
        } else {
            false;
        }
    }

    public function iterator():LinkedListIterator<T> {
        return new LinkedListIterator(first);
    }

    public inline function iter(fn:(value:T) -> Void):Void {
        var current = first;
        while (current.nonEmpty()) {
            final node = current.getUnsafe();
            fn(node.value);
            current = node.next;
        }
    }
}

class LinkedListNode<T> {
    @:allow(extype.LinkedList)
    var list(default, null):Maybe<LinkedList<T>>;

    public final value:T;
    public var prev(default, null):Maybe<LinkedListNode<T>>;
    public var next(default, null):Maybe<LinkedListNode<T>>;

    @:allow(extype.LinkedList)
    function new(list:LinkedList<T>, value:T) {
        this.list = Maybe.of(list);
        this.value = value;
        this.prev = Maybe.empty();
        this.next = Maybe.empty();
    }

    @:allow(extype.LinkedList)
    function append(node:LinkedListNode<T>):Void {
        this.next = Maybe.of(node);
        node.prev = Maybe.of(this);
    }

    @:allow(extype.LinkedList)
    function remove():Void {
        final prev = this.prev;
        final next = this.next;

        prev.iter(x -> x.next = next);
        next.iter(x -> x.prev = prev);

        this.list = Maybe.empty();
        this.prev = Maybe.empty();
        this.next = Maybe.empty();
    }
}

class LinkedListIterator<T> {
    var current:Maybe<LinkedListNode<T>>;

    @:allow(extype.LinkedList)
    function new(firstNode:Maybe<LinkedListNode<T>>) {
        this.current = firstNode;
    }

    public inline function hasNext():Bool {
        return current.nonEmpty();
    }

    public inline function next():T {
        final node = current.getUnsafe();
        current = node.next;
        return node.value;
    }
}
