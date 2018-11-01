package extype.extern;

import haxe.extern.EitherType;

typedef Mixed2<T1, T2> = EitherType<T1, T2>;
typedef Mixed3<T1, T2, T3> = Mixed2<T1, Mixed2<T2, T3>>;
typedef Mixed4<T1, T2, T3, T4> = Mixed3<T1, T2, Mixed2<T3, T4>>;
typedef Mixed5<T1, T2, T3, T4, T5> = Mixed4<T1, T2, T3, Mixed2<T4, T5>>;
typedef Mixed6<T1, T2, T3, T4, T5, T6> = Mixed5<T1, T2, T3, T4, Mixed2<T5, T6>>;
typedef Mixed7<T1, T2, T3, T4, T5, T6, T7> = Mixed6<T1, T2, T3, T4, T5, Mixed2<T6, T7>>;
typedef Mixed8<T1, T2, T3, T4, T5, T6, T7, T8> = Mixed7<T1, T2, T3, T4, T5, T6, Mixed2<T7, T8>>;
typedef Mixed9<T1, T2, T3, T4, T5, T6, T7, T8, T9> = Mixed8<T1, T2, T3, T4, T5, T6, T7, Mixed2<T8, T9>>;
typedef Mixed10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> = Mixed9<T1, T2, T3, T4, T5, T6, T7, T8, Mixed2<T9, T10>>;
