# https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/
# [Medium] - idk why Grind75 had it down as easy bc it's med on LC
#
# If it's a BST then smaller val will always be on the left and larger val
# will be on the right. Also since tree it's RECURSION TIME BAY BEEEE
#
# Starting from the root, we check the values of p and q against it
# if one >= than current root node and the other <=, then return that node
# Otherwise traverse down the tree in the direction that makes sense
#
# We can also do this iteratively since there's no backtracking involved,
# which makes it easier
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
def lowest_common_ancestor(root, p, q)
  # easy out (but also our base case)
  return root if (p.val <= root.val && q.val >= root.val) || (p.val >= root.val && q.val <= root.val)

  # we only need to compare one of either p or q since the above handles the
  # p > r > q or p < r < q case, so p and q will always be on the same side of r
  if (p.val < root.val)
    return root if root.left.nil?
    return lowest_common_ancestor(root.left, p, q)
  end

  if (p.val > root.val)
    return root if root.right.nil?
    return lowest_common_ancestor(root.right, p, q)
  end
end

# an iterative solution
def lowest_common_ancestor_2(root, p, q)
  # we don't really need the easy out now since it gets caught first round of loop

  node = root

  while !node.nil?
    if (p.val < node.val && q.val < node.val)
      node = node.left
    elsif (p.val > node.val && q.val > node.val)
      node = node.right
    else
      return node
    end
  end

end
