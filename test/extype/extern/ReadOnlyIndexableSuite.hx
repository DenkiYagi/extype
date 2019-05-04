package extype.extern;

import buddy.BuddySuite;
import utest.Assert;

class ReadOnlyIndexableSuite extends BuddySuite {
    public function new() {
        describe("ReadOnlyIndexable original field", {
            it("should pass", {
                final x: ReadOnlyIndexable<Foo, Int> = { message: "hello" };
                Assert.equals("hello", x.message);

                x.message = "foo";
                Assert.equals("foo", x.message);
            });
        });

        describe("ReadOnlyIndexable @:op(a.b)", {
            it("should pass", {
                final org: Foo = { message: "hello" };
                Reflect.setField(org, "extra", 10);
                final x: ReadOnlyIndexable<Foo, Int> = org;
                Assert.isTrue(x.field1.isEmpty());
                Assert.equals(10, x.extra.getUnsafe());
            });
        });

        describe("ReadOnlyIndexable @:arrayAccess get", {
            it("should pass", {
                final org: Foo = { message: "hello" };
                Reflect.setField(org, "extra", 10);
                final x: ReadOnlyIndexable<Foo, Int> = org;
                Assert.isTrue(x["field1"].isEmpty());
                Assert.equals(10, x["extra"].getUnsafe());
            });
        });
    }
}

private typedef Foo = {
    var message: String;
}