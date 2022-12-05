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
  attr_accessor :root
 
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    if arr.empty?
      return
    elsif arr.length <= 1
      Node.new(arr[0])
    else
      arr_filtered = arr.sort.uniq
      mid_index = arr_filtered.length / 2
      root = arr_filtered[mid_index]
      node = Node.new(root)
      node.left_children = build_tree(arr_filtered[0...mid_index])
      node.right_children = build_tree(arr_filtered[mid_index + 1..-1])
      node
    end
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_children
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_children
  end

  def insert(value, node = root)
    if node.data == value
      puts 'This value already exists in the tree.'
      return
    elsif value < node.data
      if node.left_children.nil?
        node.left_children = Node.new(value)
      else
        node = node.left_children
        insert(value, node)
      end
    else
      if node.right_children.nil?
        node.right_children = Node.new(value)
      else
        node = node.right_children 
        insert(value, node)
      end
    end
  end
  
  def find(value, node = root)
    if node.nil?
      nil
    elsif node.data == value
      puts 'Node exists. Node is provided below:'
      node
    elsif value < node.data
      find(value, node.left_children)
    else
      find(value, node.right_children)
    end
  end

  def delete(value, node = root)
    #find parentnode. if number does not exist in tree, state error, return. Else continue. 
    #find if children exist. If .left_children && .right_children are nil, then delete the leaf node. 
    # if !left_children.nil? || !right_children.nil? then take parent node of to delete node.
    #   make parent node = delete node's left or right children. 
    # if both children exist. Take parent node. Traverse right. Then recurse left till lowest value found. 
    #  save the lowest node value, and equal it to the to be deleted node. i.e. replace it. 

  end
end

test_tree = Tree.new([1,2,3,4])
