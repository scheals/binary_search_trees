# frozen_string_literal: true

require_relative './comparable'
# This class handles nodes.
class Node
  include Comparable
  attr_accessor :left_node, :right_node
  attr_reader :value

  def initialize(value, left_node = nil, right_node = nil)
    @value = value
    @left_node = left_node
    @right_node = right_node
  end

  def leaf?
    return false if left_node || right_node

    true
  end

  def parent?(node)
    return true if left_node == node || right_node == node

    false
  end

  def one_child?
    return true if left_child? && !right_child?
    return true if right_child? && !left_child?

    false
  end

  def left_child?
    return true if left_node

    false
  end

  def right_child?
    return true if right_node

    false
  end

  def min_child
    current_node = self
    current_node = current_node.left_node while current_node.left_node
    current_node
  end

  def max_child
    current_node = self
    current_node = current_node.right_node while current_node.right_node
    current_node
  end

  def successor
    right_node.min_child
  end

  def predecessor
    left_node.max_child
  end
end
