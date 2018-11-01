package extype;

abstract Tuple2<T1, T2>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;

    public inline function new(v1: T1, v2: T2) {
        this = [v1, v2];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }
}

abstract Tuple3<T1, T2, T3>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;

    public inline function new(v1: T1, v2: T2, v3: T3) {
        this = [v1, v2, v3];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }
}

abstract Tuple4<T1, T2, T3, T4>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4) {
        this = [v1, v2, v3, v4];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }
}

abstract Tuple5<T1, T2, T3, T4, T5>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5) {
        this = [v1, v2, v3, v4, v5];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }
}

abstract Tuple6<T1, T2, T3, T4, T5, T6>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;
    public var value6(get, never): T6;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5, v6: T6) {
        this = [v1, v2, v3, v4, v5, v6];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }

    inline function get_value6(): T6 {
        return this[5];
    }
}

abstract Tuple7<T1, T2, T3, T4, T5, T6, T7>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;
    public var value6(get, never): T6;
    public var value7(get, never): T7;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5, v6: T6, v7: T7) {
        this = [v1, v2, v3, v4, v5, v6, v7];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }

    inline function get_value6(): T6 {
        return this[5];
    }

    inline function get_value7(): T7 {
        return this[6];
    }
}

abstract Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;
    public var value6(get, never): T6;
    public var value7(get, never): T7;
    public var value8(get, never): T8;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5, v6: T6, v7: T7, v8: T8) {
        this = [v1, v2, v3, v4, v5, v6, v7, v8];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }

    inline function get_value6(): T6 {
        return this[5];
    }

    inline function get_value7(): T7 {
        return this[6];
    }

    inline function get_value8(): T8 {
        return this[7];
    }
}

abstract Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;
    public var value6(get, never): T6;
    public var value7(get, never): T7;
    public var value8(get, never): T8;
    public var value9(get, never): T9;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5, v6: T6, v7: T7, v8: T8, v9: T9) {
        this = [v1, v2, v3, v4, v5, v6, v7, v8, v9];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }

    inline function get_value6(): T6 {
        return this[5];
    }

    inline function get_value7(): T7 {
        return this[6];
    }

    inline function get_value8(): T8 {
        return this[7];
    }

    inline function get_value9(): T9 {
        return this[9];
    }
}

abstract Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(Array<Dynamic>) {
    public var value1(get, never): T1;
    public var value2(get, never): T2;
    public var value3(get, never): T3;
    public var value4(get, never): T4;
    public var value5(get, never): T5;
    public var value6(get, never): T6;
    public var value7(get, never): T7;
    public var value8(get, never): T8;
    public var value9(get, never): T9;
    public var value10(get, never): T10;

    public inline function new(v1: T1, v2: T2, v3: T3, v4: T4, v5: T5, v6: T6, v7: T7, v8: T8, v9: T9, v10: T10) {
        this = [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10];
    }

    inline function get_value1(): T1 {
        return this[0];
    }

    inline function get_value2(): T2 {
        return this[1];
    }

    inline function get_value3(): T3 {
        return this[2];
    }

    inline function get_value4(): T4 {
        return this[3];
    }

    inline function get_value5(): T5 {
        return this[4];
    }

    inline function get_value6(): T6 {
        return this[5];
    }

    inline function get_value7(): T7 {
        return this[6];
    }

    inline function get_value8(): T8 {
        return this[7];
    }

    inline function get_value9(): T9 {
        return this[9];
    }

    inline function get_value10(): T10 {
        return this[10];
    }
}