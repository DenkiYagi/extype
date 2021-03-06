package extype;

import haxe.ds.Option;
import extype.orderedset.OrderedStringSet;
import extype.orderedset.OrderedIntSet;
import extype.orderedset.OrderedEnumValueSet;
import extype.orderedset.OrderedObjectSet;

class OrderedSetSuite extends BuddySuite {
    public function new() {
        inline function test<T>(create:() -> OrderedSet<T>, is:OrderedSet<T>->Bool, a:T, b:T, c:T, invalid:T) {
            it("should pass : new", {
                final set = create();

                Assert.isTrue(is(set));

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.same([], set.array());
                Assert.equals(0, set.copy().length);
                Assert.equals("{}", set.copy().toString());
            });

            it("should pass : new -> add(A)", {
                final set = create();
                set.add(a);

                Assert.equals(1, set.length);
                Assert.isTrue(set.exists(a));
                Assert.isFalse(set.exists(invalid));
                Assert.same([a], [for (x in set) x]);
                Assert.same([a], set.array());
                Assert.equals(1, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.equals('{$a}', set.toString());
            });

            it("should pass : new -> remove(A)", {
                final set = create();
                set.remove(a);

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.same([], set.array());
                Assert.equals(0, set.copy().length);
                Assert.equals("{}", set.toString());
            });

            it("should pass : new -> add(A) -> add(A)", {
                final set = create();
                set.add(a);
                set.add(a);

                Assert.equals(1, set.length);
                Assert.isTrue(set.exists(a));
                Assert.isFalse(set.exists(invalid));
                Assert.same([a], [for (x in set) x]);
                Assert.same([a], set.array());
                Assert.equals(1, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.equals('{$a}', set.toString());
            });

            it("should pass : new -> add(A) -> add(B)", {
                final set = create();
                set.add(a);
                set.add(b);

                Assert.equals(2, set.length);
                Assert.isTrue(set.exists(a));
                Assert.isTrue(set.exists(b));
                Assert.isFalse(set.exists(invalid));
                Assert.same([a, b], [for (x in set) x]);
                Assert.same([a, b], set.array());
                Assert.equals(2, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.isTrue(set.copy().exists(b));
                Assert.equals('{$a,$b}', set.toString());
            });

            it("should pass : new -> add(A) -> remove(A)", {
                final set = create();
                set.add(a);
                set.remove(a);

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.same([], set.array());
                Assert.equals(0, set.copy().length);
                Assert.equals("{}", set.toString());
            });

            it("should pass : new -> add(A) -> remove(B)", {
                final set = create();
                set.add(a);
                set.remove(b);

                Assert.equals(1, set.length);
                Assert.isTrue(set.exists(a));
                Assert.isFalse(set.exists(invalid));
                Assert.same([a], [for (x in set) x]);
                Assert.same([a], set.array());
                Assert.equals(1, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.equals('{$a}', set.toString());
            });

            it("should pass : new -> add(A) -> add(B) -> add(C)", {
                final set = create();
                set.add(a);
                set.add(b);
                set.add(c);

                Assert.equals(3, set.length);
                Assert.isTrue(set.exists(a));
                Assert.isTrue(set.exists(b));
                Assert.isTrue(set.exists(c));
                Assert.isFalse(set.exists(invalid));
                Assert.same([a, b, c], [for (x in set) x]);
                Assert.same([a, b, c], set.array());
                Assert.equals(3, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.isTrue(set.copy().exists(b));
                Assert.isTrue(set.copy().exists(c));
                Assert.equals('{$a,$b,$c}', set.toString());
            });

            it("should pass : new -> add(A) -> remove(A) -> add(B)", {
                final set = create();
                set.add(a);
                set.remove(a);
                set.add(b);

                Assert.equals(1, set.length);
                Assert.isFalse(set.exists(a));
                Assert.isTrue(set.exists(b));
                Assert.isFalse(set.exists(invalid));
                Assert.same([b], [for (x in set) x]);
                Assert.same([b], set.array());
                Assert.equals(1, set.copy().length);
                Assert.isFalse(set.copy().exists(a));
                Assert.isTrue(set.copy().exists(b));
                Assert.equals('{$b}', set.toString());
            });

            it("should pass : new -> add(A) -> add(B) -> add(C) -> remove(A) -> remove(B)", {
                final set = create();
                set.add(a);
                set.add(b);
                set.add(c);
                set.remove(a);
                set.remove(b);

                Assert.equals(1, set.length);
                Assert.isFalse(set.exists(a));
                Assert.isFalse(set.exists(b));
                Assert.isTrue(set.exists(c));
                Assert.isFalse(set.exists(invalid));
                Assert.same([c], [for (x in set) x]);
                Assert.same([c], set.array());
                Assert.equals(1, set.copy().length);
                Assert.isFalse(set.copy().exists(a));
                Assert.isFalse(set.copy().exists(b));
                Assert.isTrue(set.copy().exists(c));
                Assert.equals('{$c}', set.toString());
            });

            it("should pass : new -> add(A) -> remove(A) -> remove(A)", {
                final set = create();
                set.add(a);
                final ret1 = set.remove(a);
                final ret2 = set.remove(a);

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(a));
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.same([], set.array());
                Assert.equals(0, set.copy().length);
                Assert.isFalse(set.copy().exists(a));
                Assert.equals('{}', set.toString());

                Assert.isTrue(ret1);
                Assert.isFalse(ret2);
            });

            it("should pass : new -> clear()", {
                final set = create();
                set.clear();

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.equals(0, set.copy().length);
                Assert.equals("{}", set.toString());
            });

            it("should pass : new -> set(A) -> clear()", {
                final set = create();
                set.add(a);
                set.clear();

                Assert.equals(0, set.length);
                Assert.isFalse(set.exists(invalid));
                Assert.same([], [for (x in set) x]);
                Assert.equals(0, set.copy().length);
                Assert.equals("{}", set.toString());
            });

            it("should pass : new -> set(A) -> clear() -> set(B)", {
                final set = create();
                set.add(a);
                set.clear();
                set.add(b);

                Assert.equals(1, set.length);
                Assert.isFalse(set.exists(a));
                Assert.isTrue(set.exists(b));
                Assert.isFalse(set.exists(invalid));
                [for (x in set) x].should.containAll([b]);
                Assert.equals(1, set.copy().length);
                Assert.isTrue(set.copy().exists(b));
                Assert.equals('{${b}}', set.toString());
            });
        }

        describe("OrderedSet", {
            describe("OrderedSet<String>", test(
                () -> new OrderedSet<String>(),
                Std.isOfType.bind(_, OrderedStringSet),
                "abc",
                "def",
                "ghi",
                "X"
            ));

            describe("OrderedSet<Int>", test(
                () -> new OrderedSet<Int>(),
                Std.isOfType.bind(_, OrderedIntSet),
                1,
                2,
                3,
                -1
            ));

            describe("OrderedSet<EnumValue>", test(
                () -> new OrderedSet<Option<Int>>(),
                Std.isOfType.bind(_, OrderedEnumValueSet),
                Some(1),
                Some(2),
                Some(3),
                None
            ));

            describe("OrderedSet<{}>", test(
                () -> new OrderedSet<{value:Int}>(),
                Std.isOfType.bind(_, OrderedObjectSet),
                {value:1},
                {value:2},
                {value:3},
                {value:-1}
            ));

            describe("OrderedSet.of()", {
                it("should create OrderedIntSet", {
                    final set = OrderedSet.of([1, 2]);
                    Assert.isOfType(set, OrderedIntSet);
                    Assert.equals(2, set.length);
                    Assert.isTrue(set.exists(1));
                    Assert.isTrue(set.exists(2));
                    Assert.same([1, 2], [for (k in set) k]);
                });

                it("should create OrderedStringSet", {
                    final set = OrderedSet.of(["key1", "key2"]);
                    Assert.isOfType(set, OrderedStringSet);
                    Assert.equals(2, set.length);
                    Assert.isTrue(set.exists("key1"));
                    Assert.isTrue(set.exists("key1"));
                    Assert.same(["key1", "key2"], [for (k in set) k]);
                });

                it("should create OrderedEnumValueSet", {
                    final set = OrderedSet.of([Some(1), Some(2)]);
                    Assert.isOfType(set, OrderedEnumValueSet);
                    Assert.equals(2, set.length);
                    Assert.isTrue(set.exists(Some(1)));
                    Assert.isTrue(set.exists(Some(2)));
                    Assert.same([Some(1), Some(2)], [for (k in set) k]);
                });

                it("should create OrderedObjectSet", {
                    final key1 = {key: 1};
                    final key2 = {key: 2};
                    final set = OrderedSet.of([key1, key2]);
                    Assert.isOfType(set, OrderedObjectSet);
                    Assert.equals(2, set.length);
                    Assert.isTrue(set.exists(key1));
                    Assert.isTrue(set.exists(key2));
                    Assert.same([key1, key2], [for (k in set) k]);
                });
            });
        });
    }
}
