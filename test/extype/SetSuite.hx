package extype;

import haxe.ds.Option;
import buddy.BuddySuite;
import utest.Assert;
import haxe.ds.Option;

class SetSuite extends BuddySuite {
    public function new() {
        function test<T>(create:() -> Set<T>, is:Set<T>->Bool, a:T, b:T, invalid:T) {
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
        }

        describe("Set", {
            describe("Set<String>", test(
                () -> new Set<String>(),
                Std.is.bind(_, StringSet),
                "abc",
                "def",
                "X"
            ));

            describe("Set<Int>", test(
                () -> new Set<Int>(),
                Std.is.bind(_, IntSet),
                1,
                2,
                -1
            ));

            describe("Set<EnumValue>", test(
                () -> new Set<Option<Int>>(),
                Std.is.bind(_, EnumValueSet),
                Some(1),
                Some(2),
                None
            ));

            describe("Set<{ function hashCode():Int; }>", test(
                () -> new Set<{function hashCode():Int;}>(),
                Std.is.bind(_, HashSet),
                {hashCode: () -> 1},
                {hashCode: () -> 2},
                {hashCode: () -> -1}
            ));

            describe("Set<{}>", test(
                () -> new Set<{value:Int}>(),
                Std.is.bind(_, ObjectSet),
                {value:1},
                {value:2},
                {value:-1}
            ));
        });
    }
}
