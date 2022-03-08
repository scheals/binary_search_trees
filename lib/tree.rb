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

  def build_tree(array, front, back)
    return nil if front > back

    middle = (front + back) / 2
    node = create_node(array[middle])
    node.left_node = build_tree(array, front, middle - 1)
    node.right_node = build_tree(array, middle + 1, back)
    @root = node
  end

  def insert(value, current_node = root)
    return 'Duplicate value!' if find(value)

    node = create_node(value)
    insert_sorter(node, current_node)
  end

  def insert_sorter(node, current_node)
    return insert_left(node, current_node) if node < current_node
    return insert_right(node, current_node) if node > current_node
  end

  def insert_left(node, current_node)
    return current_node.left_node = node if current_node.left_node.nil?

    insert_sorter(node, current_node.left_node)
  end

  def insert_right(node, current_node)
    return current_node.right_node = node if current_node.right_node.nil?

    insert_sorter(node, current_node.right_node)
  end

  def create_node(value)
    Node.new(value)
  end

  def delete(value, next_node = root)
    node = create_node(value)
    return nil if seeker(node).nil?

  end

  def find(value)
    node = create_node(value)
    seeker(node)
  end

  def seeker(node, current_node = root)
    return current_node if node == current_node
    return seek_left(node, current_node.left_node) if node < current_node
    return seek_right(node, current_node.right_node) if node > current_node
  end

  def seek_left(node, current_node)
    return current_node if current_node == node
    return nil if current_node.leaf?

    seeker(node, current_node)
  end

  def seek_right(node, current_node)
    return current_node if current_node == node
    return nil if current_node.leaf?

    seeker(node, current_node)
  end
end
