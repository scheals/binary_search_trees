# frozen_string_literal: true

require_relative './node'
require_relative './printable'

# This class handles balanced binary trees.
class Tree
  include Printable
  attr_reader :root

  def initialize(node = nil)
    @root = node
  end

  def build_tree(array)
    return if array.empty?

    prepared_array = array.uniq.sort
    middle = prepared_array.length / 2
    return create_node(prepared_array[0]) if prepared_array.length <= 1

    node = create_node(prepared_array[middle])
    node.left_node = build_tree(prepared_array[0...middle])
    node.right_node = build_tree(prepared_array[(middle + 1)..-1])
    @root = node
  end

  def insert(value)
    return 'Duplicate value!' if find_parent(value)

    node = create_node(value)
    insert_sort(node)
  end

  def delete(value)
    return 'No value found!' if find(value).nil?

    node_to_delete = find(value)
    return delete_root if node_to_delete == root

    parent_node = seek_parent(node_to_delete)
    if node_to_delete.leaf?
      delete_leaf(node_to_delete, parent_node)
    elsif node_to_delete.one_child?
      delete_singleton(node_to_delete, parent_node)
    else
      delete_branch(node_to_delete, parent_node)
    end
    node_to_delete
  end

  def level_order
    queue = [root]
    result = []
    until queue.empty?
      node = queue.shift
      result << (block_given? ? yield(node) : node.value)
      queue.push(node.left_node) if node.left_node
      queue.push(node.right_node) if node.right_node
    end
    result
  end

  def preorder(node = root, result = [], &block)
    return result if node.nil?

    result << (block_given? ? yield(node) : node.value)
    preorder(node.left_node, result, &block)
    preorder(node.right_node, result, &block)
    result
  end

  def inorder(node = root, result = [], &block)
    return result if node.nil?

    inorder(node.left_node, result, &block)
    result << (block_given? ? yield(node) : node.value)
    inorder(node.right_node, result, &block)
    result
  end

  def postorder(node = root, result = [], &block)
    return result if node.nil?

    postorder(node.left_node, result, &block)
    postorder(node.right_node, result, &block)
    result << (block_given? ? yield(node) : node.value)
    result
  end

  def find(value)
    node = create_node(value)
    seek(node)
  end

  def find_parent(value)
    node = create_node(value)
    seek_parent(node)
  end

  def depth(node)
    return "The depth of #{node} is: 0" if node == root

    counter = count_distance(node, root)
    "The depth of #{node} is: #{counter}"
  end

  def height(node)
    return "The height of #{node} is: 0" if node.leaf?

    leaves = preorder(node) { |candidate| candidate if candidate.leaf? }.compact
    distances = []
    leaves.each { |leaf| distances << count_distance(leaf, node) }
    "The height of #{node} is: #{distances.max}"
  end

  def balanced?
    return false if check_balance.include?(false)

    true
  end

  def rebalance
    return 'The tree is already balanced!' if balanced?

    build_tree(inorder)
  end

  private

  def create_node(value)
    Node.new(value)
  end

  def seek(node, current_node = root)
    return nil if current_node.nil?
    return current_node if node == current_node

    if node < current_node
      seek(node, current_node.left_node)
    else
      seek(node, current_node.right_node)
    end
  end

  def seek_parent(node, current_node = root)
    return nil if current_node.nil?
    return current_node if current_node.parent?(node)

    if node < current_node
      seek_parent(node, current_node.left_node)
    else
      seek_parent(node, current_node.right_node)
    end
  end

  def insert_sort(node, current_node = root)
    return insert_left(node, current_node) if node < current_node
    return insert_right(node, current_node) if node > current_node
  end

  def insert_left(node, current_node)
    current_node.left_node ? insert_sort(node, current_node.left_node) : current_node.left_node = node
  end

  def insert_right(node, current_node)
    current_node.right_node ? insert_sort(node, current_node.right_node) : current_node.right_node = node
  end

  def delete_leaf(node, parent)
    if parent.left_node == node
      parent.left_node = nil
    else
      parent.right_node = nil
    end
  end

  def delete_singleton(node, parent)
    if parent.left_node == node
      parent.left_node = node.left_node || node.right_node
    else
      parent.right_node = node.right_node || node.left_node
    end
  end

  def delete_branch(node, parent)
    successor = node.successor
    if node.right_node == successor
      if parent.left_node == node
        parent.left_node = successor
      else
        parent.right_node = successor
      end
      successor.left_node = node.left_node
    else
      successor_parent = seek_parent(successor)
      if parent.left_node == node
        parent.left_node = successor
      else
        parent.right_node = successor
      end
      successor_parent.left_node = successor.right_node
      successor.right_node = node.right_node
      successor.left_node = node.left_node
    end
  end

  def delete_root
    puts "#{root.value} is the value of root node of the tree. Deleting it will rebuild the tree without it."
    puts 'Are you sure you want to delete it? [Y/n]'
    choice = gets.chomp.to_s.downcase
    case choice
    when 'y'
      build_tree(preorder[1..-1])
    when 'n'
      puts 'Root node has not been deleted.'
    else
      delete_root
    end
  end

  def count_distance(start_node, end_node)
    counter = 0
    until start_node == end_node
      start_node = seek_parent(start_node)
      counter += 1
    end
    counter
  end

  def check_balance
    level_order do |node|
      left_height = node.left_node ? height(node.left_node).slice(-1).to_i : -1
      right_height = node.right_node ? height(node.right_node).slice(-1).to_i : -1
      left_height - right_height >= -1 && left_height - right_height <= 1
    end
  end
end
