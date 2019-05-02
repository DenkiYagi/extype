package extype;

import haxe.ds.Option;
import buddy.BuddySuite;
using buddy.Should;

class MaybeSuite extends BuddySuite {
    public function new() {
        describe("Maybe cast", {
            it("should be any value", {
                final a: Maybe<Int> = 1;
                a.nonEmpty().should.be(true);
                a.get().should.be(1);
            });

            it("should be empty value", {
                final a: Maybe<Int> = null;
                a.isEmpty().should.be(true);
            });
        });

        describe("Maybe operator", {
            it("should pass", {
                final a: Maybe<String> = "test";
                final b: Maybe<String> = "test";
                final c: Maybe<String> = "hoge";

                (a == b).should.be(true);
                (a == c).should.be(false);
                (a == Maybe.empty()).should.be(false);
                (a == "test").should.be(true);
            });
        });

        describe("Maybe from", {
            it("should convert to value", {
                (1: Maybe<Int>).get().should.be(1);
            });
            it("should convert to null", {
                (null: Maybe<Int>).isEmpty().should.be(true);
                #if js
                (js.Lib.undefined: Maybe<Int>).isEmpty().should.be(true);
                #end
            });
        });

        describe("Maybe.of()", {
            it("should convert from value", {
                final a = Maybe.of(1);
                a.get().should.be(1);
            });
            it("should not convert from null", {
                (() -> Maybe.of(null)).should.throwAnything();
                #if js
                (() -> Maybe.of(js.Lib.undefined)).should.throwAnything();
                #end
            });
        });

        describe("Maybe.ofNullable()", {
            it("can convert value", {
                Maybe.ofNullable(1).get().should.be(1);
            });
            it("can convert null", {
                Maybe.ofNullable(null).isEmpty().should.be(true);
                #if js
                Maybe.ofNullable(js.Lib.undefined).isEmpty().should.be(true);
                #end
            });
        });

        describe("Maybe.empty()", {
            it("should be success", {
                Maybe.empty().isEmpty().should.be(true);
            });
        });

        describe("Maybe#get()", {
            it("should return value", {
                Maybe.of(1).get().should.be(1);
            });
            it("should return null", {
                final x = (Maybe.empty(): Maybe<Int>).get();
                (x == null).should.be(true);
            });
        });

        describe("Maybe#getUnsafe()", {
            it("should return value", {
                Maybe.of(1).getUnsafe().should.be(1);
            });
            it("should return null", {
                #if (flash || cpp || java || cs)
                (Maybe.empty(): Maybe<Int>).getUnsafe().should.be(0);
                #else
                (Maybe.empty(): Maybe<Int>).getUnsafe().should.be(null);
                #end
            });
        });

        describe("Maybe#getOrElse()", {
            it("should return value", {
                Maybe.of(1).getOrElse(-5).should.be(1);
            });
            it("should return alt value", {
                Maybe.empty().getOrElse(-5).should.be(-5);
            });
        });

        describe("Maybe#getOrThrow()", {
            it("should be success", {
                Maybe.of(1).getOrThrow().should.be(1);
            });
            it("should be failure", {
                (() -> Maybe.empty().getOrThrow()).should.throwAnything();
            });
        });

        describe("Maybe#isEmpty()", {
            it("should be true", {
                Maybe.empty().isEmpty().should.be(true);
            });
            it("should be false", {
                Maybe.of(1).isEmpty().should.be(false);
            });
        });

        describe("Maybe#nonEmpty()", {
            it("should be true", {
                Maybe.of(1).nonEmpty().should.be(true);
            });
            it("should be false", {
                Maybe.empty().nonEmpty().should.be(false);
            });
        });

        describe("Maybe#forEach()", {
            it("should call", {
                var count = 0;
                Maybe.of(1).forEach(x -> {
                    x.should.be(1);
                    count++;
                });
                count.should.be(1);
            });
            it("should not call", {
                Maybe.empty().forEach(x -> {
                    fail();
                });
            });
        });

        describe("Maybe#map()", {
            it("should call", {
                var count = 0;
                final ret = Maybe.of(1).map(x -> {
                    x.should.be(1);
                    count++;
                    x + 1;
                });
                ret.should.be(2);
                count.should.be(1);
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
                    x.should.be(1);
                    count++;
                    Maybe.of(x + 1);
                });
                ret.should.be(2);
                count.should.be(1);
            });
            it("should call and be empty", {
                final ret = Maybe.of(1).flatMap(x -> Maybe.empty());
                ret.isEmpty().should.be(true);
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
                    x.should.be(1);
                    count++;
                    true;
                });
                ret.should.be(1);
                count.should.be(1);
            });
            it("should call and be empty", {
                final ret = Maybe.of(1).filter(x -> false);
                ret.isEmpty().should.be(true);
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
                Maybe.empty().fold(
                    () -> -1,
                    x -> x * 3
                ).should.be(-1);
            });
            it("should call fn", {
                Maybe.of(1).fold(
                    () -> -1,
                    x -> x * 3
                ).should.be(3);
            });
        });

        describe("Maybe#toOption()", {
            it("should be Some(v)", {
                Maybe.of(1).toOption().should.equal(Some(1));
                (Maybe.of(1): Option<Int>).should.equal(Some(1));
            });
            it("should be None", {
                Maybe.empty().toOption().should.equal(None);
                (Maybe.empty(): Option<Int>).should.equal(None);
            });
        });

        describe("Maybe.fromOption()", {
            it("should be Maybe.of(v)", {
                Maybe.fromOption(Some(1)).should.be(Maybe.of(1));
            });
            it("should be Maybe.empty()", {
                Maybe.fromOption(None).should.be(Maybe.empty());
            });
        });
    }
}