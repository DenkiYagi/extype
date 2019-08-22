package extype;

import buddy.BuddySuite;
import utest.Assert;
import haxe.ds.Option;
import extype.orderedmap.OrderedStringMap;
import extype.orderedmap.OrderedIntMap;
import extype.orderedmap.OrderedEnumValueMap;
import extype.orderedmap.OrderedObjectMap;

class OrderedMapSuite extends BuddySuite {
    public function new() {
        inline function test<K, V>(create: () -> OrderedMap<K, V>, is: OrderedMap<K, V> -> Bool, a:Pair<K, V>, b:Pair<K, V>, c:Pair<K, V>, invalid:Pair<K, V>) {
            it("should pass : new", {
                final map = create();

                Assert.isTrue(is(map));

                Assert.equals(0, map.length);
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([], [for (x in map.keys()) x]);
                Assert.same([], [for (x in map) x]);
                Assert.same([], [for (k => v in map) k]);
                Assert.same([], [for (k => v in map) v]);
                Assert.equals(0, map.copy().length);
                Assert.equals("[]", map.copy().toString());
            });

            it("should pass : new -> set(A)", {
                final map = create();
                map.set(a.value1, a.value2);

                Assert.equals(1, map.length);
                Assert.isTrue(map.exists(a.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([a.value1], [for (x in map.keys()) x]);
                Assert.same([a.value2], [for (x in map) x]);
                Assert.same([a.value1], [for (k => v in map) k]);
                Assert.same([a.value2], [for (k => v in map) v]);
                Assert.equals(1, map.copy().length);
                Assert.isTrue(map.copy().exists(a.value1));
                Assert.equals('[${a.value1}=>${a.value2}]', map.toString());
            });

            it("should pass : new -> remove(A)", {
                final map = create();
                map.remove(a.value1);

                Assert.equals(0, map.length);
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([], [for (x in map.keys()) x]);
                Assert.same([], [for (x in map) x]);
                Assert.same([], [for (k => v in map) k]);
                Assert.same([], [for (k => v in map) v]);
                Assert.equals(0, map.copy().length);
                Assert.equals("[]", map.toString());
            });

            it("should pass : new -> set(A) -> set(A)", {
                final map = create();
                map.set(a.value1, invalid.value2);
                map.set(a.value1, a.value2);

                Assert.equals(1, map.length);
                Assert.isTrue(map.exists(a.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([a.value1], [for (x in map.keys()) x]);
                Assert.same([a.value2], [for (x in map) x]);
                Assert.same([a.value1], [for (k => v in map) k]);
                Assert.same([a.value2], [for (k => v in map) v]);
                Assert.equals(1, map.copy().length);
                Assert.isTrue(map.copy().exists(a.value1));
                Assert.equals('[${a.value1}=>${a.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> set(B)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.set(b.value1, b.value2);

                Assert.equals(2, map.length);
                Assert.isTrue(map.exists(a.value1));
                Assert.isTrue(map.exists(b.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([a.value1, b.value1], [for (x in map.keys()) x]);
                Assert.same([a.value2, b.value2], [for (x in map) x]);
                Assert.same([a.value1, b.value1], [for (k => v in map) k]);
                Assert.same([a.value2, b.value2], [for (k => v in map) v]);
                Assert.equals(2, map.copy().length);
                Assert.isTrue(map.copy().exists(a.value1));
                Assert.isTrue(map.copy().exists(b.value1));
                Assert.equals('[${a.value1}=>${a.value2},${b.value1}=>${b.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> remove(A)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.remove(a.value1);

                Assert.equals(0, map.length);
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([], [for (x in map.keys()) x]);
                Assert.same([], [for (x in map) x]);
                Assert.same([], [for (k => v in map) k]);
                Assert.same([], [for (k => v in map) v]);
                Assert.equals(0, map.copy().length);
                Assert.equals("[]", map.toString());
            });

            it("should pass : new -> set(A) -> remove(B)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.remove(b.value1);

                Assert.equals(1, map.length);
                Assert.isTrue(map.exists(a.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([a.value1], [for (x in map.keys()) x]);
                Assert.same([a.value2], [for (x in map) x]);
                Assert.same([a.value1], [for (k => v in map) k]);
                Assert.same([a.value2], [for (k => v in map) v]);
                Assert.equals(1, map.copy().length);
                Assert.isTrue(map.copy().exists(a.value1));
                Assert.equals('[${a.value1}=>${a.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> set(B) -> set(C)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.set(b.value1, b.value2);
                map.set(c.value1, c.value2);

                Assert.equals(3, map.length);
                Assert.isTrue(map.exists(a.value1));
                Assert.isTrue(map.exists(b.value1));
                Assert.isTrue(map.exists(c.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([a.value1, b.value1, c.value1], [for (x in map.keys()) x]);
                Assert.same([a.value2, b.value2, c.value2], [for (x in map) x]);
                Assert.same([a.value1, b.value1, c.value1], [for (k => v in map) k]);
                Assert.same([a.value2, b.value2, c.value2], [for (k => v in map) v]);
                Assert.equals(3, map.copy().length);
                Assert.isTrue(map.copy().exists(a.value1));
                Assert.isTrue(map.copy().exists(b.value1));
                Assert.isTrue(map.copy().exists(c.value1));
                Assert.equals('[${a.value1}=>${a.value2},${b.value1}=>${b.value2},${c.value1}=>${c.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> remove(A) -> set(B)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.remove(a.value1);
                map.set(b.value1, b.value2);

                Assert.equals(1, map.length);
                Assert.isFalse(map.exists(a.value1));
                Assert.isTrue(map.exists(b.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([b.value1], [for (x in map.keys()) x]);
                Assert.same([b.value2], [for (x in map) x]);
                Assert.same([b.value1], [for (k => v in map) k]);
                Assert.same([b.value2], [for (k => v in map) v]);
                Assert.equals(1, map.copy().length);
                Assert.isTrue(map.copy().exists(b.value1));
                Assert.equals('[${b.value1}=>${b.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> set(B) -> set(C) -> remove(A) -> remove(B)", {
                final map = create();
                map.set(a.value1, a.value2);
                map.set(b.value1, b.value2);
                map.set(c.value1, c.value2);
                map.remove(a.value1);
                map.remove(b.value1);

                Assert.equals(1, map.length);
                Assert.isFalse(map.exists(a.value1));
                Assert.isFalse(map.exists(b.value1));
                Assert.isTrue(map.exists(c.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([c.value1], [for (x in map.keys()) x]);
                Assert.same([c.value2], [for (x in map) x]);
                Assert.same([c.value1], [for (k => v in map) k]);
                Assert.same([c.value2], [for (k => v in map) v]);
                Assert.equals(1, map.copy().length);
                Assert.isFalse(map.copy().exists(a.value1));
                Assert.isFalse(map.copy().exists(b.value1));
                Assert.isTrue(map.copy().exists(c.value1));
                Assert.equals('[${c.value1}=>${c.value2}]', map.toString());
            });

            it("should pass : new -> set(A) -> remove(A) -> remove(A)", {
                final map = create();
                map.set(a.value1, a.value2);
                final ret1 = map.remove(a.value1);
                final ret2 = map.remove(a.value1);

                Assert.equals(0, map.length);
                Assert.isFalse(map.exists(a.value1));
                Assert.isFalse(map.exists(invalid.value1));
                Assert.same([], [for (x in map.keys()) x]);
                Assert.same([], [for (x in map) x]);
                Assert.same([], [for (k => v in map) k]);
                Assert.same([], [for (k => v in map) v]);
                Assert.equals(0, map.copy().length);
                Assert.isFalse(map.copy().exists(a.value1));
                Assert.equals('[]', map.toString());

                Assert.isTrue(ret1);
                Assert.isFalse(ret2);
            });
        }

        describe("OrderedMap", {
            describe("OrderedMap<String, V>", test(
                () -> new OrderedMap<String, String>(),
                map -> Std.is(map, OrderedStringMap),
                new Pair("key1", "AAA"),
                new Pair("key2", "BBB"),
                new Pair("key3", "CCC"),
                new Pair("あいう", "invalid")
            ));

            describe("OrderedMap<Int, V>", test(
                () -> new OrderedMap<Int, String>(),
                map -> Std.is(map, OrderedIntMap),
                new Pair(10, "AAA"),
                new Pair(20, "BBB"),
                new Pair(30, "CCC"),
                new Pair(-1, "invalid")
            ));

            describe("OrderedMap<EnumValue, V>", test(
                () -> new OrderedMap<Option<Int>, String>(),
                map -> Std.is(map, OrderedEnumValueMap),
                new Pair(Some(10), "AAA"),
                new Pair(Some(20), "BBB"),
                new Pair(Some(30), "CCC"),
                new Pair(Some(-1), "invalid")
            ));

            describe("OrderedMap<{}, V>", test(
                () -> new OrderedMap<{value:Int}, String>(),
                map -> Std.is(map, OrderedObjectMap),
                new Pair({value:1}, "AAA"),
                new Pair({value:2}, "BBB"),
                new Pair({value:3}, "CCC"),
                new Pair({value:-1}, "invalid")
            ));

            describe("OrderedMap.of()", {
                it("should create OrderedIntMap", {
                    final map = OrderedMap.of([1 => "abc", 2 => "xyz"]);
                    Assert.is(map, OrderedIntMap);
                    Assert.equals(2, map.length);
                    Assert.isTrue(map.exists(1));
                    Assert.equals("abc", map.get(1));
                    Assert.isTrue(map.exists(2));
                    Assert.equals("xyz", map.get(2));
                    Assert.same([1, 2], [for (k in map.keys()) k]);
                });

                it("should create OrderedStringMap", {
                    final map = OrderedMap.of(["key1" => "abc", "key2" => "xyz"]);
                    Assert.is(map, OrderedStringMap);
                    Assert.equals(2, map.length);
                    Assert.isTrue(map.exists("key1"));
                    Assert.equals("abc", map.get("key1"));
                    Assert.isTrue(map.exists("key1"));
                    Assert.equals("xyz", map.get("key2"));
                    Assert.same(["key1", "key2"], [for (k in map.keys()) k]);
                });

                it("should create OrderedEnumValueMap", {
                    final map = OrderedMap.of([Some(1) => "abc", Some(2) => "xyz"]);
                    Assert.is(map, OrderedEnumValueMap);
                    Assert.equals(2, map.length);
                    Assert.isTrue(map.exists(Some(1)));
                    Assert.equals("abc", map.get(Some(1)));
                    Assert.isTrue(map.exists(Some(2)));
                    Assert.equals("xyz", map.get(Some(2)));
                    Assert.same([Some(1), Some(2)], [for (k in map.keys()) k]);
                });

                it("should create OrderedObjectMap", {
                    final key1 = {key: 1};
                    final key2 = {key: 2};
                    final map = OrderedMap.of([key1 => "abc", key2 => "xyz"]);
                    Assert.is(map, OrderedObjectMap);
                    Assert.equals(2, map.length);
                    Assert.isTrue(map.exists(key1));
                    Assert.equals("abc", map.get(key1));
                    Assert.isTrue(map.exists(key2));
                    Assert.equals("xyz", map.get(key2));
                    Assert.same([key1, key2], [for (k in map.keys()) k]);
                });
            });
        });
    }
}