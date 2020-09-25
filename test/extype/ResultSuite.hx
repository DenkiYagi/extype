package extype;

import extype.Result;

class ResultSuite extends BuddySuite {
    public function new() {
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
