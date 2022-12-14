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
  
  # pretty_print method copied from Odin forum, helps visualise tree. 
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
      node
    elsif value < node.data
      find(value, node.left_children)
    else
      find(value, node.right_children)
    end
  end

  def find_parent(value, node = root)
    return nil if find(value).nil?

    if root.data == value
      nil
    elsif node.left_children.data == value || node.right_children.data == value
      node
    elsif value < node.data
      find_parent(value, node.left_children)
    else
      find_parent(value, node.right_children)
    end
  end

  def next_largest_node(node)
    node.left_children.nil? ? node : next_largest_node(node.left_children)
  end

  def delete(value, node = root)
    return nil if find(value).nil?

    parent_node = find_parent(value, node)
    target_node = find(value, node)

    # case 1: leaf node?
    if target_node.left_children.nil? && target_node.right_children.nil?
      parent_node.left_children == target_node ? parent_node.left_children = nil : parent_node.right_children = nil

    # case 2: one l or r child node?
    elsif target_node.right_children.nil?
      target_node.data < parent_node.data ? parent_node.left_children = target_node.left_children : parent_node.right_children = target_node.left_children
    elsif target_node.left_children.nil?
      target_node.data < parent_node.data ? parent_node.left_children = target_node.right_children : parent_node.right_children = target_node.right_children

    # case 3: both l and r child nodes?
    elsif !target_node.left_children.nil? && !target_node.right_children.nil?
      new_node = next_largest_node(target_node.right_children)
      delete(new_node.data)
      target_node.data = new_node.data
    end
  end

  def level_order
    return nil if root.nil?

    q = []
    result = []
    q.push(root)
    until q.empty?
      
      node = q.shift
      result.push(block_given? ? yield(node) : node.data)
      q.push(node.left_children) unless node.left_children.nil?
      q.push(node.right_children) unless node.right_children.nil?
    end
    result
  end

  def pre_order(result = [], node = root)
    # root => left => right
    return if node.nil?
    
    result.push(block_given? ? yield(node) : node.data)
    pre_order(result, node.left_children)
    pre_order(result, node.right_children)
    result
  end

  def in_order(result = [], node = root)
    #left => root => right
    return if node.nil?

    pre_order(result, node.left_children)
    result.push(block_given? ? yield(node) : node.data)
    pre_order(result, node.right_children)
    result
  end

  def post_order(result = [], node = root)
    # left => right => root
    return if node.nil?

    pre_order(result, node.left_children)
    pre_order(result, node.right_children)
    result.push(block_given? ? yield(node) : node.data)
    result
  end

  def height(value = nil, node = root, node_path = [], count = [])
    return if node.nil?
    
    #first time in recursion when value of queried node in tree given:
    if !value.nil? && node == root
      node = self.find(value)
      return if node.nil?
    end

    node_path.push(node.data)
    # p node_path
    if node.left_children.nil? && node.right_children.nil?
      count.push(node_path.length)
    end
    height(value, node.left_children, node_path, count)
    height(value, node.right_children, node_path, count)
    node_path.pop
    count.max - 1
  end
  
  # This method below will not work for any unbalanced tree. 
  # def depth(value = nil) 
  #   # if default arg, depth of tree == height of tree
  #   
  #   tree_height = self.height
  #   if value.nil?
  #     tree_height
  #   else
  #     node_height = self.height(value)
  #     node_height.nil? ? nil : tree_height - node_height
  #   end
  # end

  def depth(value = nil, node = root, count = 0)
    return if node.nil?
    if value == node.data
      count
    elsif value < node.data
      count += 1
      depth(value, node.left_children, count)
    elsif value > node.data
      count += 1
      depth(value, node.right_children, count)
    end
  end

  def balanced?
    node = root
    result = true
    # right tree check
    until node.right_children.nil?
      left_height = self.height(node.left_children.data)
      right_height = self.height(node.right_children.data)
      if left_height != right_height
        result = false
        break
      else
        node = node.left_children
      end
    end
    # left tree check
    if result == true
      until node.right_children.nil?
        left_height = self.height(node.left_children.data)
        right_height = self.height(node.right_children.data)
        if left_height != right_height
          result = false
          break
        else
          node = node.right_children
        end
      end
    end
    result
  end

  def rebalance()
    balanced_arr = self.in_order
    @root = build_tree(balanced_arr)
  end
end