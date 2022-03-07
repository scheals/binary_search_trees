# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].uniq.sort
back = test_array.length - 1
tree = Tree.new
p tree.build_tree(test_array, 0, back)
tree.pretty_print
tree.insert(10)
tree.pretty_print
tree.insert(2)
tree.pretty_print
tree.insert(6)
tree.pretty_print
p tree.insert(22)
tree.pretty_print
