# Enhanced standard types for Haxe

## Requirement
+ Haxe 4.0.0-rc.3+

## Tested platforms
* JavaScript
* Eval
* NekoVM
* CPP

## Install
```
haxelib install extype
```

## API
### extype
#### Unit
`Unit` is a type that indicates no value.

#### Maybe
`Maybe<T>` is a wrapper type that can either have a value or null.

#### Result
`Result<T>` is a wrapper type that can either have a value or error.

#### Tuple2 - Tuple10
`Tuple[2-10]` can hold any values of several different types.

#### Pair
`Pair<T1, T2>` is alias of `Tuple2<T1, T2>`.

#### Set
`Set<T>` is a set of values. You can iterate through the values in insertion order.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `T` is a `String`, `extype.StringSet` is used
2. if `T` is an `Int`, `extype.IntSet` is used
3. if `T` is an `EnumValue`, `extype.EnumValueSet` is used
4. if `T` is an `{function hashCode():Int;}`, `extype.HashSet` is used
5. if `T` is any other class or structure, `extype.ObjectSet` is used
6. if `T` is any other type, it causes a compile-time error

#### Map
`Map<K, V>` is a collection of key/value pairs. You can iterate through the keys in insertion order.
This is a multi-type abstract, it is instantiated as one of its specialization types depending on its type parameters.

1. if `K` is a `String`, `extype.StringMap` is used
2. if `K` is an `Int`, `extype.IntMap` is used
3. if `K` is an `EnumValue`, `extype.EnumValueMap` is used
4. if `K` is an `{function hashCode():Int;}`, `extype.HashMap` is used
5. if `K` is any other class or structure, `extype.ObjectMap` is used
6. if `K` is any other type, it causes a compile-time error

#### LinkedNodeList
TODO

#### ReadOnlyArray
`ReadOnlyDynamic<T>` is a read-only `Array<T>`, and it is alias of `haxe.ds.ReadOnlyArray<T>`.

#### ReadOnlyDynamic
`ReadOnlyDynamic<T>` is a read-only `Dynamic<T>`.

#### ReadOnlySet
`ReadOnlySet<T>` is a read-only `Set<T>`.

#### ReadOnlyMap
`ReadOnlyMap<K, V>` is a read-only `Map<K, V>`.

#### Error
`Error` represents the application errors. In JavaScript, `Error` is the same as `js.Error`.

* `NotImplementedError`

### extype.util
#### TransformIterator
TODO

### extype.js
#### IteratorAdapter
TODO

#### KeyValueIteratorAdapter
TODO

### extype.extern
#### Mixed2 - Mixed10
`Mixed[2-10]` can have a value of several different types.
`Mixed2` is the same as `haxe.extern.EitherType`.

#### ValueOrArray
`ValueOrArray<T>` is a type that likes as `haxe.extern.EitherType<T, Array<T>>`.

#### ValueOrFunction
`ValueOrFunction<T>` is the same as `haxe.extern.EitherType<T, Void -> T>`.

#### **{{ Experimental }}** Extern&lt;T&gt;
`Extern<T>` is a generic-build macro type that can use `@:native` metadata to the anonymous structure.

```haxe
extern function defineProperty(name: String, option: Extern<PropertyOption>): Void;

typedef PropertyOption = {
    @:native("default")
    var defaultValue;
}
```

#### **{{ Experimental }}** Indexable&lt;TObject, TValue&gt;
`Indexable<TObject, TValue>` is a type that likes as `haxe.DynamicAccess<TValue>`. But `Indexable<TObject, TValue>` is different in that can access `TObject`'s field.
