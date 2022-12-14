require_relative 'binary-search-tree.rb'

puts 'Personal test script to check and test binary search tree project.'

# test 1
puts '1. Create a binary search tree from an array of random numbers '
puts tree = Tree.new((Array.new(23) { rand(1..100) }))
puts tree.pretty_print

# test 2
puts '2. Confirm tree is balanced?'
puts tree.balanced?

# test 3
puts '3. print all elements in level order, and pre, post and in-order:'
puts 'level order'
puts tree.level_order
puts 'pre-order'
puts tree.pre_order
puts 'in order'
puts tree.in_order
puts 'post_order'
puts tree.post_order

# test 4
puts '4. Add several numbers greater than 100 to the tree, check if balanced.'
arr = []
5.times {arr.push(rand(100..1000))}
arr.each {|num| tree.insert(num) }
puts tree.pretty_print

# test 5
puts tree.balanced?

# test 6
puts '5. rebalance the tree:'
puts tree.rebalance
puts tree.pretty_print

# test 7
puts tree.balanced?

# test 8
puts '6. print out all the nodes againas per step 3.'
puts 'level order'
puts tree.level_order
puts 'pre-order'
puts tree.pre_order
puts 'in order'
puts tree.in_order
puts 'post_order'
puts tree.post_order

puts 'Test finished.'