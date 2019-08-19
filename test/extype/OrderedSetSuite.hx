package extype;

import buddy.BuddySuite;
import utest.Assert;
import haxe.ds.Option;

class OrderedSetSuite extends BuddySuite {
    public function new() {
        function test<T>(create:() -> OrderedSet<T>, is:OrderedSet<T>->Bool, a:T, b:T, c:T, invalid:T) {
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
        }

        describe("OrderedSet", {
            describe("OrderedSet<String>", test(
                () -> new OrderedSet<String>(),
                Std.is.bind(_, StringSet),
                "abc",
                "def",
                "ghi",
                "X"
            ));

            describe("OrderedSet<Int>", test(
                () -> new OrderedSet<Int>(),
                Std.is.bind(_, IntSet),
                1,
                2,
                3,
                -1
            ));

            describe("OrderedSet<EnumValue>", test(
                () -> new OrderedSet<Option<Int>>(),
                Std.is.bind(_, EnumValueSet),
                Some(1),
                Some(2),
                Some(3),
                None
            ));

            describe("OrderedSet<{ function hashCode():Int; }>", test(
                () -> new OrderedSet<{function hashCode():Int;}>(),
                Std.is.bind(_, HashSet),
                {hashCode: () -> 1},
                {hashCode: () -> 2},
                {hashCode: () -> 3},
                {hashCode: () -> -1}
            ));

            describe("OrderedSet<{}>", test(
                () -> new OrderedSet<{value:Int}>(),
                Std.is.bind(_, ObjectSet),
                {value:1},
                {value:2},
                {value:3},
                {value:-1}
            ));
        });
    }
}
