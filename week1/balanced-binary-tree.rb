# https://leetcode.com/problems/balanced-binary-tree/
# [Easy]
#
# Easy MY A** lmao if I have to google what "height balanced" means then
# how is this easy smhhhhh
# > A height-balanced binary tree is a binary tree in which the depth of the
# > two subtrees of every node never differs by more than one.
# Balanced condition: left_h == right_h || left_h == right_h + 1 || left_h == right_h - 1
# which can be shortened to (left_height - right_height).abs < 2
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
# @return {Boolean}
def is_balanced(root)
  # easy out - zero nodes
  return true if root.nil?

  # compare the height of the left and right subtree of current node
  return false if (check_height(root.left) - check_height(root.right)).abs > 1

  # otherwise recurse thru each node from the top
  # and compare subtrees
  is_balanced(root.left) && is_balanced(root.right)
end

def check_height(node)
  # assuming height is 1-indexed, i.e. single node has height = 1
  # so no node is height = 0
  return 0 if (node.nil?)

  # the new height is one more the longest path in the subtree
  1 + [check_height(node.left), check_height(node.right)].max
end

# the above solution works but it kind of sucks because you
# end up recalculating the heights from the top to bottom so it's
# incredibly inefficient - I think like O(nlogn) or something since each
# node has to calculate its subtree and that's garbo bc the nodes in
# the subtree calculate the height of its subtree and the nodes in the...

# there has to be another solution and idk how to do it but basically you
# would do this bottoms-up and somehow memoize the heights or backtrack??

# @param {TreeNode} root
# @return {Boolean}
def is_balanced_2(root)
  # easy out - zero or no child nodes
  return true if root.nil? || (root.left.nil? && root.right.nil?)

  balanced, height = balance_checker(root)
end

def balance_checker(node)
  if node.nil?
    return true, 0
  end

  left_balanced, l_height = balance_checker(node.left)
  return false, 0 if !left_balanced

  right_balanced, r_height = balance_checker(node.right)
  return false, 0 if !right_balanced

  return (l_height - r_height).abs < 2, [l_height, r_height].max + 1
end

# this took forever since I couldn't figure out how to save the height
# for each side for the longest time, but saved me maybe 20ms max in runtime.
# sadness
# honestly i think the thing that took me longest to remember to do was the
# current height is the max of left/ right... i was doing some whack shit earlier
# time complexity is better (O(n), no need to compare recursively get subtrees) but
# space complexity is the same (O(n))
