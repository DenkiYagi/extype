package extype;

import buddy.BuddySuite;
import utest.Assert;
import haxe.ds.Option;
import extype.set.StringSet;
import extype.set.IntSet;
import extype.set.EnumValueSet;
import extype.set.ObjectSet;
using buddy.Should;

class SetSuite extends BuddySuite {
    public function new() {
        inline function test<T>(create:() -> Set<T>, is:Set<T>->Bool, a:T, b:T, c:T, invalid:T) {
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
                [for (x in set) x].should.containAll([a, b]);
                set.array().should.containAll([a, b]);
                Assert.equals(2, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.isTrue(set.copy().exists(b));
                final string = set.toString();
                string.should.contain(Std.string(a));
                string.should.contain(Std.string(b));
                #if !neko
                string.split(",").length.should.be(2);
                #end
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
                [for (x in set) x].should.containAll([a, b, c]);
                set.array().should.containAll([a, b, c]);
                Assert.equals(3, set.copy().length);
                Assert.isTrue(set.copy().exists(a));
                Assert.isTrue(set.copy().exists(b));
                Assert.isTrue(set.copy().exists(c));

                final string = set.toString();
                string.should.contain(Std.string(a));
                string.should.contain(Std.string(b));
                string.should.contain(Std.string(c));
                #if !neko
                string.split(",").length.should.be(3);
                #end
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

        describe("Set", {
            describe("Set<String>", test(
                () -> new Set<String>(),
                Std.is.bind(_, StringSet),
                "abc",
                "def",
                "ghi",
                "X"
            ));

            describe("Set<Int>", test(
                () -> new Set<Int>(),
                Std.is.bind(_, IntSet),
                1,
                2,
                3,
                -1
            ));

            describe("Set<EnumValue>", test(
                () -> new Set<Option<Int>>(),
                Std.is.bind(_, EnumValueSet),
                Some(1),
                Some(2),
                Some(3),
                None
            ));

            // describe("Set<{ function hashCode():Int; }>", test(
            //     () -> new Set<{function hashCode():Int;}>(),
            //     Std.is.bind(_, HashSet),
            //     {hashCode: () -> 1},
            //     {hashCode: () -> 2},
            //     {hashCode: () -> 3},
            //     {hashCode: () -> -1}
            // ));

            describe("Set<{}>", test(
                () -> new Set<{value:Int}>(),
                Std.is.bind(_, ObjectSet),
                {value:1},
                {value:2},
                {value:3},
                {value:-1}
            ));
        });
    }
}
