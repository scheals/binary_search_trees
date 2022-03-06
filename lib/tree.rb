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
    node = Node.new(array[middle])
    node.left_node = build_tree(array, front, middle - 1)
    node.right_node = build_tree(array, middle + 1, back)
    @root = node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.left_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end
