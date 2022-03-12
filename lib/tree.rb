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

  def insert(value)
    return 'Duplicate value!' if find(value)

    node = create_node(value)
    insert_sort(node)
  end

  def delete(value)
    return 'No value found!' if find(value).nil?

    node_to_delete = find(value)
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

  def find(value)
    node = create_node(value)
    seek(node)
  end

  def find_parent(value)
    node = create_node(value)
    seek_parent(node)
  end

  private

  def create_node(value)
    Node.new(value)
  end

  def seek(node, current_node = root)
    return current_node if node == current_node
    return seek_left(node, current_node.left_node) if node < current_node
    return seek_right(node, current_node.right_node) if node > current_node
  end

  def seek_left(node, current_node)
    return current_node if current_node == node
    return nil if current_node.leaf?

    seek(node, current_node)
  end

  def seek_right(node, current_node)
    return current_node if current_node == node
    return nil if current_node.leaf?

    seek(node, current_node)
  end

  def seek_parent(node, current_node = root)
    return current_node if current_node.parent?(node)
    return seek_parent_left(node, current_node.left_node) if node < current_node
    return seek_parent_right(node, current_node.right_node) if node > current_node
  end

  def seek_parent_left(node, current_node)
    return current_node if current_node.parent?(node)
    return nil if current_node.leaf?

    seek_parent(node, current_node)
  end

  def seek_parent_right(node, current_node)
    return current_node if current_node.parent?(node)
    return nil if current_node.leaf?

    seek_parent(node, current_node)
  end

  def insert_sort(node, current_node = root)
    return insert_left(node, current_node) if node < current_node
    return insert_right(node, current_node) if node > current_node
  end

  def insert_left(node, current_node)
    return current_node.left_node = node if current_node.left_node.nil?

    insert_sort(node, current_node.left_node)
  end

  def insert_right(node, current_node)
    return current_node.right_node = node if current_node.right_node.nil?

    insert_sort(node, current_node.right_node)
  end
end
