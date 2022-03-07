# frozen_string_literal: true

require_relative './node'

# This class handles balanced binary trees.
class Tree
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

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left_node
  end
end
