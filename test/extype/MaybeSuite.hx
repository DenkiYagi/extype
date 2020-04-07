package extype;

import haxe.ds.Option;
import buddy.BuddySuite;
import utest.Assert;

class MaybeSuite extends BuddySuite {
    public function new() {
        describe("Maybe cast", {
            it("should be any value", {
                final a: Maybe<Int> = 1;
                Assert.isTrue(a.nonEmpty());
                Assert.equals(1, a.get());
            });

            it("should be empty value", {
                final a: Maybe<Int> = null;
                Assert.isTrue(a.isEmpty());
            });
        });

        describe("Maybe operator", {
            it("should pass", {
                final a: Maybe<String> = "test";
                final b: Maybe<String> = "test";
                final c: Maybe<String> = "hoge";

                Assert.isTrue(a == b);
                Assert.isFalse(a == c);
                Assert.isFalse(a == Maybe.empty());
                Assert.isTrue(a == "test");
            });
        });

        describe("Maybe from", {
            it("should convert to value", {
                Assert.equals(1, (1: Maybe<Int>).get());
            });
            it("should convert to null", {
                Assert.isTrue((null: Maybe<Int>).isEmpty());
                #if js
                Assert.isTrue((js.Lib.undefined: Maybe<Int>).isEmpty());
                #end
            });
        });

        describe("Maybe.of()", {
            it("can convert value", {
                Assert.equals(1, Maybe.of(1).get());
            });
            it("can convert null", {
                Assert.isTrue(Maybe.of(null).isEmpty());
                #if js
                Assert.isTrue(Maybe.of(js.Lib.undefined).isEmpty());
                #end
            });
        });

        describe("Maybe.empty()", {
            it("should be success", {
                Assert.isTrue(Maybe.empty().isEmpty());
            });
        });

        describe("Maybe#get()", {
            it("should return value", {
                Assert.equals(1, Maybe.of(1).get());
            });
            it("should return null", {
                final x = (Maybe.empty(): Maybe<Int>).get();
                Assert.isTrue(x == null);
            });
        });

        describe("Maybe#getUnsafe()", {
            it("should return value", {
                Assert.equals(1, Maybe.of(1).getUnsafe());
            });
            it("should return null", {
                Assert.equals(null, (Maybe.empty(): Maybe<Int>).getUnsafe());
            });
        });

        describe("Maybe#getOrThrow()", {
            it("should be success", {
                Assert.equals(1, Maybe.of(1).getOrThrow());
                Assert.equals(2, Maybe.of(2).getOrThrow(() -> new MyError()));
            });
            it("should be failure", {
                Assert.raises(() -> {
                    Maybe.empty().getOrThrow();
                    return;
                }, NoDataError);
                Assert.raises(() -> {
                    Maybe.empty().getOrThrow(() -> new MyError());
                    return;
                }, MyError);
            });
        });

        describe("Maybe#getOrElse()", {
            it("should return value", {
                Assert.equals(1, Maybe.of(1).getOrElse(-5));
            });
            it("should return alt value", {
                Assert.equals(-5, Maybe.empty().getOrElse(-5));
            });
        });

        describe("Maybe#orElse()", {
            it("should return value", {
                Assert.equals(1, Maybe.of(1).orElse(Maybe.of(-5)));
            });
            it("should return alt value", {
                Assert.equals(-5, Maybe.empty().orElse(Maybe.of(-5)));
            });
        });

        describe("Maybe#isEmpty()", {
            it("should be true", {
                Assert.isTrue(Maybe.empty().isEmpty());
            });
            it("should be false", {
                Assert.isFalse(Maybe.of(1).isEmpty());
            });
        });

        describe("Maybe#nonEmpty()", {
            it("should be true", {
                Assert.isTrue(Maybe.of(1).nonEmpty());
            });
            it("should be false", {
                Assert.isFalse(Maybe.empty().nonEmpty());
            });
        });

        describe("Maybe#iter()", {
            it("should call", {
                var count = 0;
                Maybe.of(1).iter(x -> {
                    Assert.equals(1, x);
                    count++;
                });
                Assert.equals(1, count);
            });
            it("should not call", {
                Maybe.empty().iter(x -> {
                    fail();
                });
            });
        });

        describe("Maybe#foreach()", {
            it("should pass when function returns false", {
                var count = 0;
                Maybe.of(1).foreach(x -> {
                    Assert.equals(1, x);
                    count++;
                    return false;
                });
                Assert.equals(1, count);
            });
            it("should pass when function returns true", {
                var count = 0;
                Maybe.of(1).foreach(x -> {
                    Assert.equals(1, x);
                    count++;
                    return true;
                });
                Assert.equals(1, count);
            });
            it("should not call", {
                Maybe.empty().foreach(x -> {
                    fail();
                    return false;
                });
            });
        });

        describe("Maybe#map()", {
            it("should call", {
                var count = 0;
                final ret = Maybe.of(1).map(x -> {
                    Assert.equals(1, x);
                    count++;
                    x + 1;
                });
                Assert.equals(2, ret);
                Assert.equals(1, count);
            });
            it("should not call", {
                Maybe.empty().map(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Maybe#flatMap()", {
            it("should call", {
                var count = 0;
                final ret = Maybe.of(1).flatMap(x -> {
                    Assert.equals(1, x);
                    count++;
                    Maybe.of(x + 1);
                });
                Assert.equals(2, ret);
                Assert.equals(1, count);
            });
            it("should call and be empty", {
                final ret = Maybe.of(1).flatMap(x -> Maybe.empty());
                Assert.isTrue(ret.isEmpty());
            });
            it("should not call", {
                Maybe.empty().flatMap(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Maybe#filter()", {
            it("should call and be some value", {
                var count = 0;
                final ret = Maybe.of(1).filter(x -> {
                    Assert.equals(1, x);
                    count++;
                    true;
                });
                Assert.equals(1, ret);
                Assert.equals(1, count);
            });
            it("should call and be empty", {
                final ret = Maybe.of(1).filter(x -> false);
                Assert.isTrue(ret.isEmpty());
            });
            it("should not call", {
                Maybe.empty().filter(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Maybe#fold()", {
            it("should call ifEmpty", {
                final ret = Maybe.empty().fold(
                    () -> -1,
                    x -> x * 3
                );
                Assert.equals(-1, ret);
            });
            it("should call fn", {
                final ret = Maybe.of(1).fold(
                    () -> -1,
                    x -> x * 3
                );
                Assert.equals(3, ret);
            });
        });

        describe("Maybe#toOption()", {
            it("should be Some(v)", {
                Assert.same(Some(1), Maybe.of(1).toOption());
                Assert.same(Some(1), (Maybe.of(1): Option<Int>));
            });
            it("should be None", {
                Assert.same(None, Maybe.empty().toOption());
                Assert.same(None, (Maybe.empty(): Option<Int>));
            });
        });

        describe("Maybe.fromOption()", {
            it("should be Maybe.of(v)", {
                Assert.equals(1, Maybe.fromOption(Some(1)));
            });
            it("should be Maybe.empty()", {
                Assert.equals(Maybe.empty(), Maybe.fromOption(None));
            });
        });
    }
}

private class MyError extends Error {
    public function new() {
        super();
    }
}