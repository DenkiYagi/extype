package extype;

import extype.Maybe;

class LinkedNodeList<T> {
    public var first(default, null):Maybe<LinkedNode<T>>;
    public var last(default, null):Maybe<LinkedNode<T>>;
    public var length(default, null):Int;

    public function new(?iterable:Iterable<T>) {
        this.first = Maybe.empty();
        this.last = Maybe.empty();
        this.length = 0;

        if (iterable != null) {
            for (x in iterable) add(x);
        }
    }

    public function add(value:T):LinkedNode<T> {
        final node = new LinkedNode(this, value);

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

    public function exists(node:LinkedNode<T>):Bool {
        return node.list == this;
    }

    public function remove(node:LinkedNode<T>):Bool {
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

    public function iterator():LinkedNodeIterator<T> {
        return new LinkedNodeIterator(first);
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

class LinkedNode<T> {
    @:allow(extype.LinkedNodeList)
    var list(default, null):Maybe<LinkedNodeList<T>>;

    public final value:T;
    public var prev(default, null):Maybe<LinkedNode<T>>;
    public var next(default, null):Maybe<LinkedNode<T>>;

    @:allow(extype.LinkedNodeList)
    function new(list:LinkedNodeList<T>, value:T) {
        this.list = Maybe.of(list);
        this.value = value;
        this.prev = Maybe.empty();
        this.next = Maybe.empty();
    }

    @:allow(extype.LinkedNodeList)
    function append(node:LinkedNode<T>):Void {
        this.next = Maybe.of(node);
        node.prev = Maybe.of(this);
    }

    @:allow(extype.LinkedNodeList)
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

class LinkedNodeIterator<T> {
    var current:Maybe<LinkedNode<T>>;

    public function new(firstNode:Maybe<LinkedNode<T>>) {
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
