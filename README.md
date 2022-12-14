# Binary Search Tree Showcase
-----------
-----------
This is a project showcasing my understanding of binary search trees as part of learning about common data structures and algorithms.

**Key Functions:**
-----------------

* **#build_tree** - Takes an array of data, sorts array, and turns it into a balanced binary tree (object).

* **#insert** - Inserts given value into the tree.

* **#find** - Returns the node with the given value (if it exists, else nil).

* **#delete** - Deletes given argument (if it exists, else nil). 

* **#level_order** - Prints all the values in level order.

* **#inorder** - Prints all the values in inorder (block arg may also be used).

* **#preorder** - Prints all the values in preorder (block arg may also be used).

* **#postorder** - Prints all the values in postorder (block arg may also be used).

* **#height** - Returns height of a given node value. (If no argument given, then returns height of tree object.)

* **#depth** - Returns depth of a given node value. (If no argument given, then returns depth of tree object.)

* **#balanced?** - Returns true or false based on if the given tree object is balanced. 

* **#rebalance** -  Rebalances existing tree object. 


### **main.rb is a test script with following functions:**

1. Creates a binary search tree from an array of random numbers (Array.new(23) { rand(1..100) }).

2. Confirms that the tree is balanced by calling **#balanced?**.

3. Prints out all elements *in level, pre, post, and in order*.

4. Unbalances the tree by adding several numbers > 100.

5. Confirms that the tree is unbalanced by calling **#balanced?**.

6. Balances the tree by calling **#rebalance**.

7. Confirms that the tree is balanced by calling **#balanced?**.

8. Prints out all elements *in level, pre, post, and in order*. 

