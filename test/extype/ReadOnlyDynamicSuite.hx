package extype;

import buddy.BuddySuite;
import utest.Assert;

class ReadOnlyDynamicSuite extends BuddySuite {
    public function new() {
        describe("ReadOnlyDynamic from", {
            it("should cast from Dynamic<T>", {
                final src = ({}: Dynamic<Int>);
                src.age = 1;
                
                final d: ReadOnlyDynamic<Int> = src;
                Assert.equals(1, d.age);
            });

            it("should cast from anonymous structure", {
                final src = { age: 2 };
                
                final d: ReadOnlyDynamic<Int> = src;
                Assert.equals(2, d.age);
            });
        });

        describe("ReadOnlyDynamic @:op(a.b)", {
            it("should pass", {
                final d: ReadOnlyDynamic<Int> = { age: 11 };
                Assert.equals(11, d.age);
                Assert.equals(null, d.unknown);
            });
        });

        describe("ReadOnlyDynamic @:arrayAccess", {
            it("should pass", {
                final d: ReadOnlyDynamic<Int> = { age: 12 };
                Assert.equals(12, d.age);
                Assert.equals(null, d.unknown);
            });
        });
    }
}