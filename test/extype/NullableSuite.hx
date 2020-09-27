package extype;

import haxe.ds.Option;

class NullableSuite extends BuddySuite {
    public function new() {
        describe("Nullable cast", {
            it("should cast from a value", {
                final a:Nullable<Int> = 1;
                Assert.isTrue(a.nonEmpty());
                Assert.equals(1, a.get());
            });

            it("should cast from null", {
                final a:Nullable<Int> = null;
                Assert.isTrue(a.isEmpty());
            });
        });

        describe("Nullable operator", {
            it("should pass", {
                final a:Nullable<String> = "test";
                final b:Nullable<String> = "test";
                final c:Nullable<String> = "hoge";

                Assert.isTrue(a == b);
                Assert.isFalse(a == c);
                Assert.isFalse(a == Nullable.empty());
                Assert.isTrue(a == "test");
            });
        });

        describe("Nullable.of()", {
            it("can convert value", {
                Assert.equals(1, Nullable.of(1).get());
            });
            it("can convert null", {
                Assert.isTrue(Nullable.of(null).isEmpty());
                #if js
                Assert.isTrue(Nullable.of(js.Lib.undefined).isEmpty());
                #end
            });
        });

        describe("Nullable.empty()", {
            it("should be success", {
                Assert.isTrue(Nullable.empty().isEmpty());
            });
        });

        describe("Nullable#toMaybe()", {
            it("should be Some(v)", {
                Assert.same(Maybe.Some(1), Nullable.of(1).toMaybe());
                Assert.same(Maybe.Some(1), (Nullable.of(1): Maybe<Int>));
            });
            it("should be None", {
                Assert.same(Maybe.None, Nullable.empty().toMaybe());
                Assert.same(Maybe.None, (Nullable.empty(): Maybe<Int>));
            });
        });

        describe("Nullable.fromMaybe()", {
            it("should be Nullable.of(v)", {
                Assert.equals(1, Nullable.fromMaybe(Maybe.Some(1)));
            });
            it("should be Nullable.empty()", {
                Assert.equals(Nullable.empty(), Nullable.fromMaybe(Maybe.None));
            });
        });

        describe("Nullable#toOption()", {
            it("should be Some(v)", {
                Assert.same(Option.Some(1), Nullable.of(1).toOption());
                Assert.same(Option.Some(1), (Nullable.of(1): Option<Int>));
            });
            it("should be None", {
                Assert.same(Option.None, Nullable.empty().toOption());
                Assert.same(Option.None, (Nullable.empty(): Option<Int>));
            });
        });

        describe("Nullable.fromOption()", {
            it("should be Nullable.of(v)", {
                Assert.equals(1, Nullable.fromOption(Option.Some(1)));
            });
            it("should be Nullable.empty()", {
                Assert.equals(Nullable.empty(), Nullable.fromOption(Option.None));
            });
        });

        describe("Nullable#get()", {
            it("should return value", {
                Assert.equals(1, Nullable.of(1).get());
            });
            it("should return null", {
                final x = (Nullable.empty(): Nullable<Int>).get();
                Assert.isTrue(x == null);
            });
        });

        describe("Nullable#getUnsafe()", {
            it("should return value", {
                Assert.equals(1, Nullable.of(1).getUnsafe());
            });
            it("should return null", {
                Assert.equals(null, (Nullable.empty(): Nullable<String>).getUnsafe());
            });
        });

        describe("Nullable#getOrThrow()", {
            it("should be success", {
                Assert.equals(1, Nullable.of(1).getOrThrow());
                Assert.equals(2, Nullable.of(2).getOrThrow(() -> new MyException()));
            });
            it("should be failure", {
                Assert.raises(() -> {
                    Nullable.empty().getOrThrow();
                    return;
                }, NoDataException);
                Assert.raises(() -> {
                    Nullable.empty().getOrThrow(() -> new MyException());
                    return;
                }, MyException);
            });
        });

        describe("Nullable#getOrElse()", {
            it("should return value", {
                Assert.equals(1, Nullable.of(1).getOrElse(-5));
            });
            it("should return alt value", {
                Assert.equals(-5, Nullable.empty().getOrElse(-5));
            });
        });

        describe("Nullable#orElse()", {
            it("should return value", {
                Assert.equals(1, Nullable.of(1).orElse(Nullable.of(-5)));
            });
            it("should return alt value", {
                Assert.equals(-5, Nullable.empty().orElse(Nullable.of(-5)));
            });
        });

        describe("Nullable#isEmpty()", {
            it("should be true", {
                Assert.isTrue(Nullable.empty().isEmpty());
            });
            it("should be false", {
                Assert.isFalse(Nullable.of(1).isEmpty());
            });
        });

        describe("Nullable#nonEmpty()", {
            it("should be true", {
                Assert.isTrue(Nullable.of(1).nonEmpty());
            });
            it("should be false", {
                Assert.isFalse(Nullable.empty().nonEmpty());
            });
        });

        describe("Nullable#iter()", {
            it("should call", {
                var count = 0;
                Nullable.of(1).iter(x -> {
                    Assert.equals(1, x);
                    count++;
                });
                Assert.equals(1, count);
            });
            it("should not call", {
                Nullable.empty().iter(x -> {
                    fail();
                });
            });
        });

        describe("Nullable#foreach()", {
            it("should pass when function returns false", {
                var count = 0;
                Nullable.of(1).foreach(x -> {
                    Assert.equals(1, x);
                    count++;
                    return false;
                });
                Assert.equals(1, count);
            });
            it("should pass when function returns true", {
                var count = 0;
                Nullable.of(1).foreach(x -> {
                    Assert.equals(1, x);
                    count++;
                    return true;
                });
                Assert.equals(1, count);
            });
            it("should not call", {
                Nullable.empty().foreach(x -> {
                    fail();
                    return false;
                });
            });
        });

        describe("Nullable#map()", {
            it("should call", {
                var count = 0;
                final ret = Nullable.of(1).map(x -> {
                    Assert.equals(1, x);
                    count++;
                    x + 1;
                });
                Assert.equals(2, ret);
                Assert.equals(1, count);
            });
            it("should not call", {
                Nullable.empty().map(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Nullable#flatMap()", {
            it("should call", {
                var count = 0;
                final ret = Nullable.of(1).flatMap(x -> {
                    Assert.equals(1, x);
                    count++;
                    Nullable.of(x + 1);
                });
                Assert.equals(2, ret);
                Assert.equals(1, count);
            });
            it("should call and be empty", {
                final ret = Nullable.of(1).flatMap(x -> Nullable.empty());
                Assert.isTrue(ret.isEmpty());
            });
            it("should not call", {
                Nullable.empty().flatMap(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Nullable#has()", {
            it("should pass", {
                Nullable.of(1).has(1).should.be(true);
                Nullable.of(1).has(2).should.be(false);
                Nullable.empty().has(1).should.be(false);
            });
        });

        describe("Nullable#exists()", {
            it("should pass", {
                Nullable.of(1).exists(x -> x == 1).should.be(true);
                Nullable.of(1).exists(x -> x == 2).should.be(false);
                Nullable.empty().exists(x -> true).should.be(false);
                Nullable.empty().exists(x -> false).should.be(false);
            });
        });

        describe("Nullable#find()", {
            it("should pass", {
                Nullable.of(1).find(x -> x == 1).should.be(1);
                Nullable.of(1).find(x -> x == 2).should.be(null);
                (Nullable.empty().find(x -> true) : Null<Any>).should.be(null);
                (Nullable.empty().find(x -> false) : Null<Any>).should.be(null);
            });
        });

        describe("Nullable#filter()", {
            it("should call and be some value", {
                var count = 0;
                final ret = Nullable.of(1).filter(x -> {
                    Assert.equals(1, x);
                    count++;
                    true;
                });
                Assert.equals(1, ret);
                Assert.equals(1, count);
            });
            it("should call and be empty", {
                final ret = Nullable.of(1).filter(x -> false);
                Assert.isTrue(ret.isEmpty());
            });
            it("should not call", {
                Nullable.empty().filter(x -> {
                    fail();
                    x;
                });
            });
        });

        describe("Nullable#fold()", {
            it("should call ifEmpty", {
                final ret = Nullable.empty().fold(
                    () -> -1,
                    x -> x * 3
                );
                Assert.equals(-1, ret);
            });
            it("should call fn", {
                final ret = Nullable.of(1).fold(
                    () -> -1,
                    x -> x * 3
                );
                Assert.equals(3, ret);
            });
        });

        describe("Nullable#match()", {
            it("should call fn", done ->{
                Nullable.of(10).match(
                    x -> {
                        Assert.equals(10, x);
                        done();
                    },
                    () -> fail()
                );
            });
            it("should call ifEmpty", done -> {
                Nullable.empty().match(
                    x -> fail(),
                    () -> done()
                );
            });
        });
    }
}

private class MyException extends Exception {
    public function new() {
        super("myerror");
    }
}