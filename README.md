# extype
**Enhanced standard types for Haxe**

![Test](https://github.com/DenkiYagi/haxe-extype/workflows/Test/badge.svg)

## Requirement
+ Haxe 4.0+

## Tested platforms
* JavaScript
* Eval
* NekoVM
* CPP

# Install
```
haxelib install extype
```

# API
## extype
### Unit
`Unit` is a type that indicates no value.

### Maybe
`Maybe<T>` is a wrapper type that can either have a value or null.

### Result
`Result<T>` is a wrapper type that can either have a value or error.

### Tuple2 - Tuple10
`Tuple[2-10]` can hold any values of several different types.

### Pair
`Pair<T1, T2>` is an alias of `Tuple2<T1, T2>`.

### Map
`Map<K, V>` is a collection of key/value pairs.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `K` is a `String`, `extype.map.StringMap` is used
2. if `K` is an `Int`, `extype.map.IntMap` is used
3. if `K` is an `EnumValue`, `extype.map.EnumValueMap` is used
5. if `K` is any other class or structure, `extype.map.ObjectMap` is used
6. if `K` is any other type, it causes a compile-time error

### OrderedMap
`Map<K, V>` is a collection of key/value pairs. You can iterate through the keys in insertion order.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `K` is a `String`, `extype.orderedmap.OrderedStringMap` is used
2. if `K` is an `Int`, `extype.orderedmap.OrderedIntMap` is used
3. if `K` is an `EnumValue`, `extype.orderedmap.OrderedEnumValueMap` is used
5. if `K` is any other class or structure, `extype.orderedmap.OrderedObjectMap` is used
6. if `K` is any other type, it causes a compile-time error

### Set
`Set<T>` is a set of values.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `T` is a `String`, `extype.set.StringSet` is used
2. if `T` is an `Int`, `extype.set.IntSet` is used
3. if `T` is an `EnumValue`, `extype.set.EnumValueSet` is used
5. if `T` is any other class or structure, `extype.set.ObjectSet` is used
6. if `T` is any other type, it causes a compile-time error

### OrderedSet
`OrderedSet<T>` is a set of values. You can iterate through the values in insertion order.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `T` is a `String`, `extype.orderedset.OrderedStringSet` is used
2. if `T` is an `Int`, `extype.orderedset.OrderedIntSet` is used
3. if `T` is an `EnumValue`, `extype.orderedset.OrderedEnumValueSet` is used
5. if `T` is any other class or structure, `extype.orderedset.OrderedObjectSet` is used
6. if `T` is any other type, it causes a compile-time error

### LinkedList
`LinkedList<T>` is doubly linked list implementation.

### ReadOnlyArray
`ReadOnlyDynamic<T>` is a read-only `Array<T>`, and it is an alias of `haxe.ds.ReadOnlyArray<T>`.

### ReadOnlyDynamic
`ReadOnlyDynamic<T>` is a read-only `Dynamic<T>`.

### ReadOnlySet
`ReadOnlySet<T>` is a read-only `Set<T>`.

### ReadOnlyMap
`ReadOnlyMap<K, V>` is a read-only `Map<K, V>`.

### Error
`Error` represents the application errors. In JavaScript, `Error` is the same as `js.Error`.

* `NoDataError`
* `NotImplementedError`

## extype.iterator
### TransformIterator
`TransformIterator` wraps another iterator and can iterate over elements these are applied transform function.

## extype.iterator.js
### IteratorAdapter and KeyValueIteratorAdapter
`IteratorAdapter` and `KeyValueIteratorAdapter` can wrap `js.lib.Iterator` as Haxe's iterator.

## extype.extern
### Mixed2 - Mixed10
`Mixed[2-10]` can have a value of several different types.
`Mixed2` is the same as `haxe.extern.EitherType`.

### ValueOrArray
`ValueOrArray<T>` is a type that likes as `haxe.extern.EitherType<T, Array<T>>`.

### ValueOrFunction
`ValueOrFunction<T>` is the same as `haxe.extern.EitherType<T, Void -> T>`.

### **{{ Experimental }}** Extern&lt;T&gt;
`Extern<T>` is a generic-build macro type that can use `@:native` metadata to the anonymous structure.

```haxe
extern function defineProperty(name: String, option: Extern<PropertyOption>): Void;

typedef PropertyOption = {
    @:native("default")
    var defaultValue;
}
```

### **{{ Experimental }}** Indexable&lt;TObject, TValue&gt;
`Indexable<TObject, TValue>` is a type that likes as `haxe.DynamicAccess<TValue>`. But `Indexable<TObject, TValue>` is different in that can access `TObject`'s field.
