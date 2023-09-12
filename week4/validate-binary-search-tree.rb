# https://leetcode.com/problems/validate-binary-search-tree/
# [Medium]
#
# Couple of things to check: left side has to be smaller and right
# side has to be bigger, gotta check if they exist before comparing
# else OOPS comparing to nil. However, we must compare against more
# than just the immediate node... the node on the left must be
# smaller than each node we passed thru, same story for the right.
#
# The way to go is with an inorder traversal and compare each node
# we hit with the last node we saw. The most annoying part of it was
# tracking that last node - unlike some of the other languages on LC,
# ruby starter code doesn't have the soln as a class so I had to get
# creative with something I could use almost like a class variable.
# To achieve this, I could use a map or array declared in the initial
# method and then just keep passing that around, since for those the
# values get updated unlike a "primitive" like an integer or string.
# That's why "prev" is initialized as an empty array and I adapted
# the logic around empty array/ first element of array. If I hated
# having good space complexity I could also have just stored the
# entire inorder traversal tree in the array and compared prev.last.
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
def is_valid_bst(root)
  # easy out, only root node
  return true if root.left.nil? && root.right.nil?

  # "hack" to have a global variable to update in the helper method
  prev = []

  inorder(root, prev)
end

# do the inorder traversal, only things that are different from the
# the usual inorder "print out the numbers" are the whole returning
# values thing for each of the conditionals, and the updating of the
# "prev" value with the current node so it can be compared as we
# traverse. O(n) time since each node gets visited once, and up to
# O(n) space for the recursion stack
def inorder(node, prev)
  return true if node.nil?

  return false unless inorder(node.left, prev)

  return false if !prev.empty? && node.val <= prev.first

  prev[0] = node.val
  inorder(node.right, prev)
end

# this can also be done iteratively with a stack we set ourselves of
# the values, so it's also O(n) space. It's a little bit different to
# think about going down a tree interatively imo - basically for each
# node, we go as left as possible, pushing everything we encounter on
# the stack, and once we're done pushing, we're in the outer loop and
# can start popping and comparing, moving right as needed.
#
# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst_2(root)
  # easy out, only root node
  return true if root.left.nil? && root.right.nil?

  stack = []
  prev = nil
  node = root

  while !stack.empty? || !node.nil?
    while !node.nil?
      stack << node
      node = node.left
      p node.val
    end

    p stack
    node = stack.pop

    return false if !prev.nil? && node.val <= prev

    prev = node.val
    node = node.right
  end

  true
end

# another way to do this, given that we have to ensure that the node
# being compared has to be within a range, is to literally set that
# range ourselves lmao. Once again, it can also be done iteratively
# but I'm not gonna bother doing both.
#
# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst_3(root)
  validate(root)
end

def validate(node, low = nil, high = nil)
  return true if node.nil?

  return false if (!low.nil? && node.val <= low) ||
                  (!high.nil? && node.val >= high)

  validate(node.right, node.val, high) && validate(node.left, low, node.val)
end
