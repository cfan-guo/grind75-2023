# https://leetcode.com/problems/invert-binary-tree/
# [Easy]
#
# No offense but no trees are easy!! Hate anything with nodes!!
# I don't remember jack shit about binary trees but I guess inverting one
# just means keep swapping left and right
#
# So this is a good time to use some recursion: pitfalls are to check for
# child node existence before checking for grandchild node existence
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
# @return {TreeNode}
def invert_tree(root)
  # easy outs
  return root if root.nil?
  return root if root.left.nil? && root.right.nil?

  swap_nodes(root, root.left, root.right)

  root
end

def swap_nodes(parent, left, right)
  if left && (!left.left.nil? || !left.right.nil?)
    swap_nodes(left, left.left, left.right)
  end

  if right && (!right.left.nil? || !right.right.nil?)
    swap_nodes(right, right.left, right.right)
  end

  parent.left, parent.right = parent.right, parent.left
end
