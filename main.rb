# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

def test
  array = (Array.new(15) { rand(1..100) }).uniq.sort
  back = array.length - 1
  tree = Tree.new
  tree.build_tree(array, 0, back)
  tree.pretty_print
  p tree.balanced?
  p tree.level_order
  p tree.preorder
  p tree.inorder
  p tree.postorder
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
