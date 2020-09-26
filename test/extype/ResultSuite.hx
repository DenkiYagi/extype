package extype;

import extype.Result;
import haxe.ds.Either;

class ResultSuite extends BuddySuite {
    public function new() {
        describe("Result.toEither()", {
            it("should convert `Success -> Right`", {
                Success(1).toEither().should.equal(Right(1));
            });
            it("should convert `Failure -> Left`", {
                Failure("error").toEither().should.equal(Left("error"));
            });
        });

        describe("Result.isSuccess()", {
            it("should be false", {
                Failure(1).isSuccess().should.be(false);
            });

            it("should be true", {
                Success(1).isSuccess().should.be(true);
            });
        });

        describe("Result.isFailure()", {
            it("should be true", {
                Failure(1).isFailure().should.be(true);
            });

            it("should be false", {
                Success(1).isFailure().should.be(false);
            });
        });

        describe("Result.get()", {
            it("should return value", {
                Success(1).get().should.be(1);
            });
            it("should return null", {
                final x:Null<Any> = Failure("error").get();
                x.should.be(null);
            });
        });

        #if !target.static
        describe("Result.getUnsafe()", {
            it("should return value", {
                Success(1).getUnsafe().should.be(1);
            });
            it("should return null", {
                final x:Null<Any> = Failure("error").getUnsafe();
                x.should.be(null);
            });
        });
        #end

        describe("Result.getOrThrow()", {
            it("should be success", {
                Success(1).getOrThrow().should.be(1);
                Success(2).getOrThrow(() -> "myerror").should.be(2);
            });
            it("should be failure", {
                try {
                    Failure("error").getOrThrow();
                    fail();
                } catch (e) {
                    e.message.should.be("error");
                }

                try {
                    Failure("error").getOrThrow(() -> "myerror");
                    fail();
                } catch (e) {
                    e.message.should.be("myerror");
                }
            });
        });

        describe("Result.getOrElse()", {
            it("should return value", {
                Success(1).getOrElse(-5).should.be(1);
            });
            it("should return alt value", {
                Failure("error").getOrElse(-5).should.be(-5);
            });
        });

        describe("Result.orElse()", {
            it("should return value", {
                Success(1).orElse(Success(-5)).should.equal(Success(1));
            });
            it("should return alt value", {
                Failure("error").orElse(Success(-5)).should.equal(Success(-5));
            });
        });

        describe("Result.map()", {
            it("should call fn", {
                Success(1).map(x -> x * 2).should.equal(Success(2));
            });

            it("should not call fn", {
                Failure(1).map(x -> {
                    fail();
                    x * 2;
                }).should.equal(Failure(1));
            });
        });

        describe("Result.flatMap()", {
            it("should call fn", {
                Success(1).flatMap(x -> Success(x * 2)).should.equal(Success(2));
                Success(1).flatMap(x -> Failure(x * 2)).should.equal(Failure(2));
            });

            it("should not call fn", {
                Failure(1).flatMap(x -> {
                    fail();
                    Success(x * 2);
                }).should.equal(Failure(1));
            });
        });

        describe("Result.mapFailure()", {
            it("should call fn", {
                Failure(1).mapFailure(x -> x * 2).should.equal(Failure(2));
            });

            it("should not call fn", {
                Success(1).mapFailure(x -> {
                    fail();
                    x * 2;
                }).should.equal(Success(1));
            });
        });

        describe("Result.flatMapFailure()", {
            it("should call fn", {
                Failure(1).flatMapFailure(x -> Failure(x * 2)).should.equal(Failure(2));
                Failure(1).flatMapFailure(x -> Success(x * 2)).should.equal(Success(2));
            });

            it("should not call fn", {
                Success(1).flatMapFailure(x -> {
                    fail();
                    Failure(x * 2);
                }).should.equal(Success(1));
            });
        });

        describe("Result.flatten()", {
            it("should pass", {
                Success(Success(1)).flatten().should.equal(Success(1));
                Success(Failure("error")).flatten().should.equal(Failure("error"));
                Failure("error").flatten().should.equal(Failure("error"));
            });
        });

        describe("Result.exists()", {
            it("should pass", {
                Success(1).exists(1).should.be(true);
                Success(1).exists(2).should.be(false);
                Failure("error").exists(1).should.be(false);
            });
        });

        describe("Result.notExists()", {
            it("should pass", {
                Success(1).notExists(1).should.be(false);
                Success(1).notExists(2).should.be(true);
                Failure("error").notExists(1).should.be(true);
            });
        });

        describe("Result.find()", {
            it("should pass", {
                Success(1).find(x -> x == 1).should.be(true);
                Success(1).find(x -> x == 2).should.be(false);
                Failure("error").find(x -> x == 1).should.be(false);
            });
        });

        describe("Result.filterOrElse()", {
            it("should pass", {
                Success(1).filterOrElse(x -> x == 1, "notfound").should.equal(Success(1));
                Success(1).filterOrElse(x -> x == 2, "notfound").should.equal(Failure("notfound"));
                Failure("error").filterOrElse(x -> x == 1, "notfound").should.equal(Failure("error"));
            });
        });

        describe("Result.fold()", {
            it("should pass", {
                Success(1).fold(x -> x + 100, x -> x + 200).should.be(101);
                Failure(1).fold(x -> x + 100, x -> x + 200).should.be(201);
            });
        });

        describe("Result.iter()", {
            it("should pass", done -> {
                Success(1).iter(x -> {
                    x.should.be(1);
                    done();
                });
                Failure(1).iter(x -> fail());
            });
        });

        describe("Result.match()", {
            it("should pass", done -> {
                Success(1).match(
                    x -> {
                        x.should.be(1);
                        done();
                    },
                    x -> fail()
                );
                Failure(1).match(
                    x -> fail(),
                    x -> {
                        x.should.be(1);
                        done();
                    }
                );
            });
        });
    }
}
