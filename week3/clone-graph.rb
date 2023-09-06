# https://leetcode.com/problems/clone-graph/
# [Medium]
#
# Uhh so here we have to do two(?) things - we need to make new nodes
# and we need to add those new nodes to the list. The first way to do
# this that I can think of is to just store all the nodes in a hash
# table with the val as the key and add their neighbours... the trick
# here is to not get lost in the nodes and end up infinitely bouncing
# between node lists bc that would be bad. There's a BFS and DFS soln
#
# Biggest tripup here was I kept writing "neighbours" with the "u" :/
#
# Definition for a Node.
# class Node
#     attr_accessor :val, :neighbors
#     def initialize(val = 0, neighbors = nil)
#		  @val = val
#		  neighbors = [] if neighbors.nil?
#         @neighbors = neighbors
#     end
# end
# @param {Node} node
# @return {Node}
def cloneGraph(node)
  # easy out
  return nil if node.nil?

  # keep track of the node by using its unique val as the key
  clones = {}

  clone_node(node, clones)

  # return the first node
  clones[1]
end

def clone_node(node, clones)
  return clones[node.val] if clones[node.val]

  clones[node.val] = Node.new(node.val)

  node.neighbors.each do |n|
    clones[node.val].neighbors << clone_node(n, clones)
  end

  clones[node.val]
end

# Aight for a list that looks like this
# 1: 2, 3                      (1) - (2)
# 2: 1, 3, 4                    |  /  |
# 3: 1, 2                      (3)   (4)
# 4: 2
#
# The clones go a little like
# 1: -> 1: ->  1:    -> 1:    -> 1:      -> 1:      -> 1:      -> 1:      -> 1:          -> 1: 2, 3
#       2:     2: 1,    2: 1,    2: 1,      2: 1, 3    2: 1, 3    2: 1, 3    2: 1, 3, 4     2: 1, 3, 4
#                       3:       3: 1, 2    3: 1, 2    3: 1, 2    3: 1, 2    3: 1, 2        3: 1, 2
#                                                      4:         4: 2       4: 2           4: 2
# (1)  (1)-(2) (1)=(2) (1)=(2)   (1)=(2)    (1)=(2)   (1)=(2)    (1)=(2)   (1)=(2)          (1)= (2)
#                                 | /       | //      | //       | //  |    | //||          || // ||
#                                (3)        (3)       (3) (4)    (3) (4)   (3) (4)          (3)  (4)
# (double lines show that both nodes have updated their neighb list)
# basically create the clone if it doesn't exist and then go into its
# neighbours list on the original node, using the original node to
# iterate. Only add a cloned neighbour node to its neighbours list if
# it already exists, otherwise run clone_node on that node (which
# creates the node and adds the neighbs recursively.
# I wanna say spacewise it's the same as the input so that's O(n)
# or O(V+E) since that's what we get, and the runtime.. for each node
# we check all its neighbours so that's what, O(V+E) again? This is
# technically a DFS but if we had a gazillion nodes then rip the
# recursion stack.

# We could also do this in a BFS way but I personally found it more
# annoying to think of bc of the way the adjacency list is structured
#
# @param {Node} node
# @return {Node}
def cloneGraph_2(node)
  # TODO: BFS solution
end
