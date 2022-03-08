# frozen_string_literal: true

#This module handles objects that can be printed as binary trees.
module Printable
  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left_node
  end
end
