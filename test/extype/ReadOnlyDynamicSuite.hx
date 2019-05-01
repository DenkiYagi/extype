package extype;

import buddy.BuddySuite;
using buddy.Should;

class ReadOnlyDynamicSuite extends BuddySuite {
    public function new() {
        describe("ReadOnlyDynamic from", {
            it("should cast from Dynamic<T>", {
                final src = ({}: Dynamic<Int>);
                src.age = 1;
                
                final d: ReadOnlyDynamic<Int> = src;
                d.age.should.be(1);
            });

            it("should cast from anonymous structure", {
                final src = { age: 10 };
                
                final d: ReadOnlyDynamic<Int> = src;
                d.age.should.be(10);
            });
        });

        describe("ReadOnlyDynamic @:op(a.b)", {
            it("should pass", {
                final d: ReadOnlyDynamic<Int> = { age: 11 };
                d.age.should.be(11);
            });
        });

        describe("ReadOnlyDynamic @:arrayAccess", {
            it("should pass", {
                final d: ReadOnlyDynamic<Int> = { age: 12 };
                d["age"].should.be(12);
            });
        });
    }
}