class Node
  attr_accessor :data, :left_children, :right_children

  def initialize(data)
    @data = data
    @left_children = nil
    @right_children = nil
  end
end

module Comparable

end

class Tree
  def initialize(arr)
    tree = []
    @root = build_tree(arr, 0, (arr.length - 1))
    tree.push(@root)
    tree
  end

  def build_tree(arr, start_arr_index, end_arr_index)
    if start_arr_index > end_arr_index
      return nil
    else
      mid_arr_index = (start_arr_index + end_arr_index) / 2
      root = arr[mid_arr_index]
      p root

      node = Node.new(root)
      
      node.left_children = build_tree(arr, 0, mid_arr_index - 1)
      node.right_children = build_tree(arr, mid_arr_index + 1, (arr.length - 1))
      root
    end
  end
end

Tree.new([1,2,3,4])