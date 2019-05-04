# Enhanced standard types for Haxe

## Requirement
+ Haxe 4.0+

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

#### ReadOnlyDynamic
`ReadOnlyDynamic<T>` is a read-only Dynamic<T>.

#### Error
`Error` represents the application errors. In JavaScript, `Error` is the same as `js.Error`.

* `NotImplementedError`

### extype.extern
#### Mixed2 - Mixed10
`Mixed[2-10]` can have a value of several different types.
`Mixed2` is the same as `haxe.extern.EitherType`.

#### ValueOrArray
`ValueOrArray<T>` is a type that likes as `haxe.extern.EitherType<T, Array<T>>`.

#### ValueOrFunction
`ValueOrFunction<T>` is the same as `haxe.extern.EitherType<T, Void -> T>`.

#### Extern&lt;T&gt;
`Extern<T>` is a generic-build macro type that can use `@:native` metadata to the anonymous structure.

```haxe
extern function defineProperty(name: String, option: Extern<PropertyOption>): Void;

typedef PropertyOption = {
    @:native("default")
    var defaultValue;
}
```

#### Indexable&lt;TObject, TValue&gt;
`Indexable<TObject, TValue>` is a type that likes as `haxe.DynamicAccess<TValue>`. But `Indexable<TObject, TValue>` is different in that can access `TObject`'s field.
