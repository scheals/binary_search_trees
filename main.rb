# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

def test
  array = (Array.new(15) { rand(1..100) })
  tree = Tree.new
  tree.build_tree(array)
  tree.pretty_print
  p tree.balanced?
  p tree.level_order { |node| node.value * 2 }
  p tree.preorder { |node| node.value * 2 }
  p tree.inorder { |node| node.value * 2 }
  p tree.postorder { |node| node.value * 2 }
  10.times do
    tree.insert(rand(101..200))
  end
  tree.pretty_print
  p tree.balanced?
  tree.rebalance
  tree.pretty_print
  p tree.balanced?
  p tree.level_order
  p tree.preorder
  p tree.inorder
  p tree.postorder
  puts 'Test finished!'
end
test
def delete_test
  array = [1, 11, 8, 23, 34, 56, 88, 10, 4, 18, 55, 56]
  tree = Tree.new
  tree.build_tree(array)
  tree.pretty_print
  p tree.balanced?
  p tree.delete(11)
  tree.pretty_print
  p tree.balanced?
  p tree.delete(56)
  tree.pretty_print
  p tree.balanced?
  p tree.delete(10)
  tree.pretty_print
  p tree.balanced?
  p tree.delete(18)
  tree.pretty_print
  p tree.delete(55)
  tree.pretty_print
  p tree.height(tree.find(4))
  p tree.depth(tree.find(4))
  p tree.height(tree.find(23))
  p tree.depth(tree.find(23))
  p tree.height(tree.find(88))
  p tree.depth(tree.find(88))
  p tree.balanced?
  tree.rebalance
  tree.pretty_print
end
delete_test
