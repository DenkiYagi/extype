package extype.extern;

import buddy.BuddySuite;
import utest.Assert;

class ExternSuite extends BuddySuite {
    public function new() {
        describe("Extern", {
            it("should transform {}", {
                final x: Extern<{}> = {};
                Assert.same({}, x);

                final y: Extern<{}> = {message: "hello"};
                Assert.same({message: "hello"}, y);
            });

            it("should transform {message: String}", {
                final x: Extern<{message: String}> = {message: "Hoge"};
                Assert.same({message: "Hoge"}, x);
            });

            it("should transform @:native", {
                final x: Extern<{
                    @:native("default")
                    var defaultValue: Int;
                }> = {defaultValue: 10};
                Assert.same({"default": 10}, x);
            });

            it("should transform nested type", {
                final x: Extern<{
                    var child: {
                        @:native("default")
                        var defaultValue: Int;
                    }
                }> = {child: {defaultValue: 10}};
                Assert.same({child: {"default": 10}}, x);
            });

            it("should transform nested @:native", {
                final x: Extern<{
                    @:native("try")
                    var try_: {
                        @:native("default")
                        var defaultValue: Int;
                    }
                }> = {try_: {defaultValue: 10}};
                Assert.same({"try": {"default": 10}}, x);
            });

            it("should transform typedef", {
                final x: Extern<Type1> = {defaultValue: 10};
                Assert.same({"default": 10}, x);
            });

            it("should transform alias-type", {
                final x: Extern<Alias1> = {defaultValue: 10};
                Assert.same({"default": 10}, x);
            });

            it("should transform alias-alias-type", {
                final x: Extern<Alias2> = {defaultValue: 10};
                Assert.same({"default": 10}, x);
            });

            it("should transform complex type", {
                final x: Extern<{
                    var message: String;
                    
                    @:native("final")
                    var final_: String;

                    @:native("try")
                    var try_: Alias3;
                }> = {
                    message: "hello",
                    final_: "final-val",
                    try_: {
                        defaultValue: 100
                    }
                };
                Assert.same({
                    message: "hello",
                    "final": "final-val",
                    "try": {
                        "default": 100
                    }
                }, x);
            });

        });
    }
}

private typedef Type1 = {
    @:native("default")
    var defaultValue: Int;
}

private typedef Alias1 = Type1;
private typedef Alias2 = Alias1;
typedef Alias3 = Alias2;