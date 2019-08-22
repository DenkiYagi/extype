package extype;

import buddy.BuddySuite;
import buddy.CompilationShould;
import utest.Assert;
using buddy.Should;

class ReadOnlyMapSuite extends BuddySuite {
    public function new() {
        describe("ReadOnlyMap", {
            it("should cast from Map", {
                final src = new Map();
                src.set(10, "ABC");
                src.set(15, "XYZ");

                final dist: ReadOnlyMap<Int, String> = src;
                Assert.equals(src, dist);
                Assert.equals(2, dist.length);
                Assert.isTrue(dist.exists(10));
                Assert.equals(dist.get(10), "ABC");
                [ for(k => v in dist) k ].should.containAll([10, 15]);
                [ for(k => v in dist) v ].should.containAll(["ABC", "XYZ"]);

                CompilationShould.failFor({
                    final set = (new OrderedSet<Int>() : ReadOnlySet<Int>);
                    set.add(10);
                });
            });

            it("should cast from OrderedMap", {
                final src = new OrderedMap();
                src.set(10, "ABC");
                src.set(15, "XYZ");

                final dist: ReadOnlyMap<Int, String> = src;
                Assert.equals(src, dist);
                Assert.equals(2, dist.length);
                Assert.isTrue(dist.exists(10));
                Assert.equals(dist.get(10), "ABC");
                [ for(k => v in dist) k ].should.containAll([10, 15]);
                [ for(k => v in dist) v ].should.containAll(["ABC", "XYZ"]);

                CompilationShould.failFor({
                    final set = (new OrderedSet<Int>() : ReadOnlySet<Int>);
                    set.add(10);
                });
            });
        });
    }
}