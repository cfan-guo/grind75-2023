# https://leetcode.com/problems/binary-tree-level-order-traversal/
# [Medium]
#
# uhhh BFS type of beat I guess? The only thing is that each level
# needs to be its own array so we can't just have a straightforward
# array for the visited queue.
#
# Space usage is O(n) since we only ever store the values of all the
# nodes, so even accounting for the visited queue, that's still O(n).
# Time should also be O(n) since we only visit each node once, even
# though we have that nested loop going on.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer[][]}
def level_order(root)
  # easy outs
  return [] if root.nil?
  return [[root.val]] if root.left.nil? && root.right.nil?

  levels, visited = [[]], [[root]]

  # usually we could end if the queue was empty, but since we nest it
  # with an additional queue for the level, we check both
  while !visited.empty? && !visited.last.empty?
    current_level = visited.shift

    # need to account for a new level to the visited queue
    visited << [] if visited.empty?

    while !current_level.empty?
      current_node = current_level.shift

      # we always append the current node to the last level
      # if this is the last node in the preceding level, we need to
      # add another level
      levels.last << current_node.val
      levels << [] if current_level.empty?

      # add this node's children to the visited list
      visited.last << current_node.left unless current_node.left.nil?
      visited.last << current_node.right unless current_node.right.nil?
    end
  end

  # we might have an extra level at the end of the array so remove it
  levels.pop if levels.last.empty?
  levels
end

# this could've been done recursively too but idk i'm too sleepy for
# that so we'll add this as a todo
#
# @param {TreeNode} root
# @return {Integer[][]}
def level_order_2(root)
  # TODO: recursive solution
end
