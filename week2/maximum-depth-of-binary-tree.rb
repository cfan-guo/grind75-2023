# https://leetcode.com/problems/maximum-depth-of-binary-tree/
# [Easy]
#
# Aight so what I'm thinking is that we wanna check the current
# path length at each node and get the max and go upward... this
# feels like DFS but i can't remember how to do that stuff lol
#
# Worst case (unbalanced) the height is log(n) so the recursion
# stack space is O(n), but balanced would be like O(logn). Time
# is O(n) since every node gets one visit
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
# @return {Integer}
def max_depth(root)
  # easy outs
  return 0 if root.nil?
  return 1 if root.left.nil? && root.right.nil?

  depth(root)
end

def depth(node)
  return 0 if node.nil?

  [depth(node.left), depth(node.right)].max + 1
end

# if we get rid of the 2nd "easy out", we can yeet the helper fn
#
# @param {TreeNode} root
# @return {Integer}
def max_depth_2(root)
  # base case
  return 0 if root.nil?

  [max_depth_2(root.left), max_depth_2(root.right)].max + 1
end

# so apparently BFS was a valid solution for this as well but tbh
# sometimes these things have one soln that is ez and obvious and
# sometimes you gotta really get mentally creative for these additional
# solutions.. also this solution uses tail recursion for space
# optimization which may or may not even be relevant depending on the
# language being used... Ruby seems wishywashy based on old SO I've found
#
# @param {TreeNode} root
# @return {Integer}
def max_depth_3(root)
  # TODO: time O(n), space O(n) BFS implementation with queue
  # https://leetcode.com/problems/maximum-depth-of-binary-tree/editorial/
end
