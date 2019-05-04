package extype.extern;

import buddy.BuddySuite;
import utest.Assert;

class IndexableSuite extends BuddySuite {
    public function new() {
        describe("Indexable original field", {
            it("should pass", {
                final x: Indexable<Foo, Int> = { message: "hello" };
                Assert.equals("hello", x.message);

                x.message = "foo";
                Assert.equals("foo", x.message);
            });
        });

        describe("Indexable @:op(a.b)", {
            it("should pass", {
                final x: Indexable<Foo, Int> = { message: "hello" };
                Assert.isTrue(x.field1.isEmpty());

                x.field1 = 100;
                Assert.isTrue(x.field1.nonEmpty());
                Assert.equals(100, x.field1.getUnsafe());
            });
        });

        describe("Indexable @:arrayAccess get", {
            it("should pass", {
                final x: Indexable<Foo, Int> = { message: "hello" };
                Assert.isTrue(x["field1"].isEmpty());

                x["field1"] = 100;
                Assert.isTrue(x["field1"].nonEmpty());
                Assert.equals(100, x["field1"].getUnsafe());
            });
        });
    }
}

private typedef Foo = {
    var message: String;
}