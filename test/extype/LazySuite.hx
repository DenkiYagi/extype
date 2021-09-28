package extype;

using buddy.Should;

class LazySuite extends BuddySuite {
    public function new() {
        describe("Lazy", {
            it("should not call a factory function when it isn't called `get()`", {
                final lazy = new Lazy(() -> {
                    fail();
                    10;
                });
                lazy.isInitialized.should.be(false);
            });

            it("should return a factory function result", {
                final lazy = new Lazy(() -> {
                    10;
                });
                lazy.isInitialized.should.be(false);
                lazy.get().should.be(10);
                lazy.isInitialized.should.be(true);
                lazy.get().should.be(10);
                lazy.isInitialized.should.be(true);
            });

            it("should call a factory function when it's called `get()`", done -> {
                final lazy = new Lazy(() -> {
                    done();
                    10;
                });
                lazy.isInitialized.should.be(false);
                lazy.get();
                lazy.isInitialized.should.be(true);
            });

            it("should call factory function one time when it's called `get()` multiple times", {
                var count = 0;
                final lazy = new Lazy(() -> {
                    count++;
                    10;
                });
                lazy.isInitialized.should.be(false);
                lazy.get();
                lazy.get();
                count.should.be(1);
                lazy.isInitialized.should.be(true);
            });
        });
    }
}