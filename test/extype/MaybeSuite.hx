package extype;

import haxe.ds.Option;
import haxe.Exception;
import extype.Maybe;

class MaybeSuite extends BuddySuite {
    public function new() {
        timeoutMs = 50;

        describe("Maybe.toNullable()", {
            it("should return value", {
                final x = Some(1).toNullable();
                x.nonEmpty().should.be(true);
                x.getOrThrow().should.be(1);
            });
            it("should return empty", {
                final x = None.toNullable();
                x.isEmpty().should.be(true);
            });
        });

        describe("Maybe.toOption()", {
            it("should convert `Maybe.Some -> Option.Some`", {
                Some(1).toOption().should.equal(Option.Some(1));
            });
            it("should convert `Maybe.None -> Option.None`", {
                None.toOption().should.equal(Option.None);
            });
        });

        describe("Maybe.isEmpty()", {
            it("should be false", {
                Some(1).isEmpty().should.be(false);
            });

            it("should be true", {
                None.isEmpty().should.be(true);
            });
        });

        describe("Maybe.nonEmpty()", {
            it("should be true", {
                Some(1).nonEmpty().should.be(true);
            });

            it("should be false", {
                None.nonEmpty().should.be(false);
            });
        });

        describe("Maybe.get()", {
            it("should return value", {
                Some(1).get().should.be(1);
            });
            it("should return null", {
                final x:Null<Any> = None.get();
                x.should.be(null);
            });
        });

        #if !target.static
        describe("Maybe.getUnsafe()", {
            it("should return value", {
                Some(1).getUnsafe().should.be(1);
            });
            it("should return null", {
                final x:Null<Any> = None.getUnsafe();
                x.should.be(null);
            });
        });
        #end

        describe("Maybe.getOrThrow()", {
            it("should be success", {
                Some(1).getOrThrow().should.be(1);
                Some(2).getOrThrow(() -> new MyError()).should.be(2);
            });
            it("should be failure", {
                try {
                    None.getOrThrow();
                    fail();
                } catch (e) {
                }

                try {
                    None.getOrThrow(() -> new MyError());
                    fail();
                } catch (e) {
                }
            });
        });

        describe("Maybe.getOrElse()", {
            it("should return value", {
                Some(1).getOrElse(-5).should.be(1);
            });
            it("should return alt value", {
                None.getOrElse(-5).should.be(-5);
            });
        });

        describe("Maybe.orElse()", {
            it("should return value", {
                Some(1).orElse(Some(-5)).should.equal(Some(1));
            });
            it("should return alt value", {
                None.orElse(Some(-5)).should.equal(Some(-5));
            });
        });

        describe("Maybe.map()", {
            it("should call fn", {
                Some(1).map(x -> x * 2).should.equal(Some(2));
            });

            it("should not call fn", {
                None.map(x -> {
                    fail();
                    x * 2;
                }).should.equal(None);
            });
        });

        describe("Maybe.flatMap()", {
            it("should call fn", {
                Some(1).flatMap(x -> Some(x * 2)).should.equal(Some(2));

                Some(1).flatMap(x -> None).should.equal(None);
            });

            it("should not call fn", {
                var ret = None.map(x -> {
                    fail();
                    x * 2;
                });
                ret.should.equal(None);
            });
        });

        describe("Maybe.flatten()", {
            it("should flatten", {
                Some(Some(1)).flatten().should.equal(Some(1));
            });

            it("should be None", {
                Some(None).flatten().should.equal(None);
                None.flatten().should.equal(None);
            });
        });

        describe("Maybe.exists()", {
            it("should be true", {
                Some(1).exists(1).should.be(true);
            });

            it("should be false", {
                Some(1).exists(0).should.be(false);
                None.exists(1).should.be(false);
            });
        });

        describe("Maybe.notExists()", {
            it("should be false", {
                Some(1).notExists(1).should.be(false);
            });

            it("should be true", {
                Some(1).notExists(0).should.be(true);
                None.notExists(1).should.be(true);
            });
        });

        describe("Maybe.find()", {
            it("should be true", {
                Some(1).find(x -> x == 1).should.be(true);
            });

            it("should be false", {
                Some(1).find(x -> false).should.be(false);
                None.find(x -> true).should.be(false);
                None.find(x -> false).should.be(false);
            });
        });

        describe("Maybe.filter()", {
            it("should be Some", {
                Some(1).filter(x -> true).should.equal(Some(1));
            });

            it("should be None", {
                Some(1).filter(x -> false).should.equal(None);
                None.filter(x -> true).should.equal(None);
                None.filter(x -> false).should.equal(None);
            });
        });

        describe("Maybe.fold()", {
            it("should pass", {
                Some(1).fold(() -> { fail(); -1; }, x -> x + 100).should.be(101);
                None.fold(() -> 10, x -> { fail(); -1; }).should.be(10);
            });
        });

        describe("Maybe.iter()", {
            it("should call fn", done -> {
                Some(1).iter(x -> {
                    x.should.be(1);
                    done();
                });
            });

            it("should not call fn", {
                None.iter(x -> {
                    fail();
                });
            });
        });

        describe("Maybe.match()", {
            it("should pass", done -> {
                Some(1).match(
                    x -> {
                        x.should.be(1);
                        done();
                    },
                    () -> fail()
                );
                None.match(
                    x -> fail(),
                    () -> done()
                );
            });
        });
    }
}

private class MyError extends extype.Exception {
    public function new() {
        super("myerror");
    }
}
