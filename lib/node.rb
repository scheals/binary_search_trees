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
end
