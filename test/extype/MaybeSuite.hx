package extype;

import buddy.BuddySuite;
using buddy.Should;

class MaybeSuite extends BuddySuite {
    public function new() {
        describe("Maybe cast", {
            it("should be some", {
                var a: Maybe<Int> = 1;
                a.nonEmpty().should.be(true);
                a.get().should.be(1);
            });

            it("should be none", {
                var a: Maybe<Int> = null;
                a.isEmpty().should.be(true);
            });
        });

        describe("Maybe operator", {
            it("can compare", {
                var a: Maybe<String> = "test";
                var b: Maybe<String> = "test";
                var c: Maybe<String> = "hoge";

                (a == b).should.be(true);
                (a == c).should.be(false);
                (a == Maybe.empty()).should.be(false);
                (a == "test").should.be(true);
            });
        });

        describe("Maybe.of()", {
            it("can convert value", {
                var a = Maybe.of(1);
                a.get().should.be(1);
            });
            it("can not convert null", {
                function () { Maybe.of(null); }.should.throwAnything();
                #if js
                function () { Maybe.of(js.Lib.undefined); }.should.throwAnything();
                #end
            });
        });

        describe("Maybe.from()", {
            it("can convert value", {
                Maybe.from(1).get().should.be(1);
            });
            it("can convert null", {
                Maybe.from(null).isEmpty().should.be(true);
                #if js
                Maybe.from(js.Lib.undefined).isEmpty().should.be(true);
                #end
            });
        });

        describe("Maybe.empty()", {
            it("should be success", {
                Maybe.empty().isEmpty().should.be(true);
            });
        });

        describe("Maybe.get()", {
            it("should return value", {
                Maybe.of(1).get().should.be(1);
            });
            it("should return null", {
                (Maybe.empty(): Maybe<Int>).get().should.be(null);
            });
        });

        describe("Maybe.getOrElse()", {
            it("should return value", {
                Maybe.of(1).getOrElse(-5).should.be(1);
            });
            it("should return alt value", {
                Maybe.empty().getOrElse(-5).should.be(-5);
            });
        });

        describe("Maybe.getOrThrow()", {
            it("should be success", {
                Maybe.of(1).getOrThrow().should.be(1);
            });
            it("should be failure", {
                function () { Maybe.empty().getOrThrow(); }.should.throwAnything();
            });
        });

        describe("Maybe.isEmpty()", {
            it("should be true", {
                Maybe.empty().isEmpty().should.be(true);
            });
            it("should be false", {
                Maybe.of(1).isEmpty().should.be(false);
            });
        });

        describe("Maybe.nonEmpty()", {
            it("should be true", {
                Maybe.of(1).nonEmpty().should.be(true);
            });
            it("should be false", {
                Maybe.empty().nonEmpty().should.be(false);
            });
        });

        describe("Maybe.forEach()", {
            it("should call", {
                var count = 0;
                Maybe.of(1).forEach(function (x) {
                    x.should.be(1);
                    count++;
                });
                count.should.be(1);
            });
            it("should not call", {
                Maybe.empty().forEach(function (x) {
                    fail();
                });
            });
        });

        describe("Maybe.map()", {
            it("should call", {
                var count = 0;
                var ret = Maybe.of(1).map(function (x) {
                    x.should.be(1);
                    count++;
                    return x + 1;
                });
                ret.should.be(2);
                count.should.be(1);
            });
            it("should not call", {
                Maybe.empty().map(function (x) {
                    fail();
                    return x;
                });
            });
        });

        describe("Maybe.flatMap()", {
            it("should call", {
                var count = 0;
                var ret = Maybe.of(1).flatMap(function (x) {
                    x.should.be(1);
                    count++;
                    return Maybe.of(x + 1);
                });
                ret.should.be(2);
                count.should.be(1);
            });
            it("should call and be empty", {
                var ret = Maybe.of(1).flatMap(function (x) {
                    return Maybe.empty();
                });
                ret.isEmpty().should.be(true);
            });
            it("should not call", {
                Maybe.empty().flatMap(function (x) {
                    fail();
                    return x;
                });
            });
        });

        describe("Maybe.filter()", {
            it("should call and be some value", {
                var count = 0;
                var ret = Maybe.of(1).filter(function (x) {
                    x.should.be(1);
                    count++;
                    return true;
                });
                ret.should.be(1);
                count.should.be(1);
            });
            it("should call and be empty", {
                var ret = Maybe.of(1).filter(function (x) {
                    return false;
                });
                ret.isEmpty().should.be(true);
            });
            it("should not call", {
                Maybe.empty().filter(function (x) {
                    fail();
                    return x;
                });
            });
        });

        describe("Maybe.match()", {
            it("should match some pattern", {
                Maybe.of(1).match(
                    function (x) return x * 3,
                    function () return -1
                ).should.be(3);
            });
            it("should match empty pattern", {
                Maybe.empty().match(
                    function (x) return x * 3,
                    function () return -1
                ).should.be(-1);
            });
        });
    }
}