package extype;

import haxe.ds.Option;
import buddy.BuddySuite;
import utest.Assert;

class LinkedListSuite extends BuddySuite {
    public function new() {
        describe("LinkedList", {
            it("should pass : new", {
                final list = new LinkedList();

                Assert.equals(0, list.length);
                Assert.same([], [for (x in list.iterator()) x]);
                list.iter(_ -> Assert.fail());
            });

            it("should pass: new(iterable)", {
                final list = new LinkedList([3, 2, 1]);

                Assert.equals(3, list.length);
                Assert.same([3, 2, 1], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([3, 2, 1], array);
            });

            it("should pass : new -> add(A)", {
                final list = new LinkedList();
                final nodeA = list.add(10);

                Assert.equals(1, list.length);
                Assert.same([10], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next.isEmpty());
                Assert.isTrue(list.exists(nodeA));
            });

            it("should pass : new -> add(A) -> remove(A)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                list.remove(nodeA);

                Assert.equals(0, list.length);
                Assert.same([], [for (x in list.iterator()) x]);
                list.iter(_ -> Assert.fail());

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next.isEmpty());
                Assert.isFalse(list.exists(nodeA));
            });

            it("should pass : new -> add(A) -> add(B)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);

                Assert.equals(2, list.length);
                Assert.same([10, 15], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10, 15], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next == nodeB);
                Assert.isTrue(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev == nodeA);
                Assert.isTrue(nodeB.next.isEmpty());
                Assert.isTrue(list.exists(nodeB));
            });

            it("should pass : new -> add(A) -> add(B) -> remove(A)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                list.remove(nodeA);

                Assert.equals(1, list.length);
                Assert.same([15], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([15], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next.isEmpty());
                Assert.isFalse(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev.isEmpty());
                Assert.isTrue(nodeB.next.isEmpty());
                Assert.isTrue(list.exists(nodeB));
            });

            it("should pass : new -> add(A) -> add(B) -> remove(B)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                list.remove(nodeB);

                Assert.equals(1, list.length);
                Assert.same([10], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next.isEmpty());
                Assert.isTrue(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev.isEmpty());
                Assert.isTrue(nodeB.next.isEmpty());
                Assert.isFalse(list.exists(nodeB));
            });

            it("should pass : new -> add(A) -> add(B) -> add(C)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                final nodeC = list.add(20);

                Assert.equals(3, list.length);
                Assert.same([10, 15, 20], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10, 15, 20], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next == nodeB);
                Assert.isTrue(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev == nodeA);
                Assert.isTrue(nodeB.next == nodeC);
                Assert.isTrue(list.exists(nodeB));

                Assert.equals(20, nodeC.value);
                Assert.isTrue(nodeC.prev == nodeB);
                Assert.isTrue(nodeC.next.isEmpty());
                Assert.isTrue(list.exists(nodeC));
            });

            it("should pass : new -> add(A) -> add(B) -> add(C) -> remove(A)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                final nodeC = list.add(20);
                list.remove(nodeA);

                Assert.equals(2, list.length);
                Assert.same([15, 20], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([15, 20], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next.isEmpty());
                Assert.isFalse(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev.isEmpty());
                Assert.isTrue(nodeB.next == nodeC);
                Assert.isTrue(list.exists(nodeB));

                Assert.equals(20, nodeC.value);
                Assert.isTrue(nodeC.prev == nodeB);
                Assert.isTrue(nodeC.next.isEmpty());
                Assert.isTrue(list.exists(nodeC));
            });

            it("should pass : new -> add(A) -> add(B) -> add(C) -> remove(B)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                final nodeC = list.add(20);
                list.remove(nodeB);

                Assert.equals(2, list.length);
                Assert.same([10, 20], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10, 20], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next == nodeC);
                Assert.isTrue(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev.isEmpty());
                Assert.isTrue(nodeB.next.isEmpty());
                Assert.isFalse(list.exists(nodeB));

                Assert.equals(20, nodeC.value);
                Assert.isTrue(nodeC.prev == nodeA);
                Assert.isTrue(nodeC.next.isEmpty());
                Assert.isTrue(list.exists(nodeC));
            });

            it("should pass : new -> add(A) -> add(B) -> add(C) -> remove(C)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final nodeB = list.add(15);
                final nodeC = list.add(20);
                list.remove(nodeC);

                Assert.equals(2, list.length);
                Assert.same([10, 15], [for (x in list.iterator()) x]);
                final array = [];
                list.iter(array.push);
                Assert.same([10, 15], array);

                Assert.equals(10, nodeA.value);
                Assert.isTrue(nodeA.prev.isEmpty());
                Assert.isTrue(nodeA.next == nodeB);
                Assert.isTrue(list.exists(nodeA));

                Assert.equals(15, nodeB.value);
                Assert.isTrue(nodeB.prev == nodeA);
                Assert.isTrue(nodeB.next.isEmpty());
                Assert.isTrue(list.exists(nodeB));

                Assert.equals(20, nodeC.value);
                Assert.isTrue(nodeC.prev.isEmpty());
                Assert.isTrue(nodeC.next.isEmpty());
                Assert.isFalse(list.exists(nodeC));
            });

            it("should pass : new -> add(A) -> remove(A) -> remove(A)", {
                final list = new LinkedList();
                final nodeA = list.add(10);
                final ret1 = list.remove(nodeA);
                final ret2 = list.remove(nodeA);

                Assert.isTrue(ret1);
                Assert.isFalse(ret2);
                Assert.equals(0, list.length);
            });

            it("should not remove other list's node", {
                final list1 = new LinkedList();
                final node1 = list1.add(10);

                final list2 = new LinkedList();
                final node2 = list2.add(10);

                final ret = list1.remove(node2);

                Assert.isFalse(ret);
                Assert.isTrue(list1.exists(node1));
                Assert.isTrue(list2.exists(node2));
            });
        });
    }
}