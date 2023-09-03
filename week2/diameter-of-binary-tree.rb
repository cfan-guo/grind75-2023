# https://leetcode.com/problems/diameter-of-binary-tree/
# [Easy]
#
# I HATE TREES 🚫🌳🚫🌲🚫
# Thought process for this: for each node, the longest path possible
# thru that node is the longest path on the left and the longest path
# on the right. So when we visit each node we need to do two things -
# calculate the longest path that includes it and compare it to the
# cur_max and set it to the cur_max if bigger, and then pass on the
# longer of its left and right paths for the node above it (recursion
# baybeeeeee)
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
def diameter_of_binary_tree(root)
  # easy out
  return 0 if root.left.nil? && root.right.nil?

  longest_path, max = counter(root, 0)
  max
end

def counter(node, diameter)
  return [0, diameter] if node.nil?

  # recurse down the left and right sides, getting the longest of each
  # child node's children's paths, as well as any updates to the max if
  # it happens in the children side
  left_len, diameter = counter(node.left, diameter)
  right_len, diameter = counter(node.right, diameter)

  # add 1 to the length of each non-nil child to get the updated length
  # at the current node
  right_len += 1 if !node.right.nil?
  left_len += 1 if !node.left.nil?
  path_len = right_len + left_len

  # return the longest of right/left path and the current diameter
  [[right_len, left_len].max, [diameter, path_len].max]
end

# haha this wasn't tooo bad (i got the algorithm but got stuck on coding
# something that made sense since I needed to pass in the diameter and
# the current longest so that makes it annoying with the returns) but the
# keeners on leetcode comments are all complaining this should be medium
# anyways O(n) time bc we visit each node once and O(n) worst case space
# bc of the DFS tree traversing stack recursing thingamabob. O(logn) for
# balanced or something like that
