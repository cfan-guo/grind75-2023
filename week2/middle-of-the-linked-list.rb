# https://leetcode.com/problems/middle-of-the-linked-list/
# [Easy]
#
# Oh I am FRESH from that stupid reverse linkedlist problem that
# I couldn't remember how to solve, that Ham suggested using a
# STACK for lmfao. I could do this in a nice way but let's start
# with shoving nodes into an array and finding the middle lel.
# Fuck it, O(n) space let's go!!!
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def middle_node(head)
  # easy out
  return head if head.next.nil?

  sad_stack = []
  node = head

  while !node.nil?
    sad_stack << node
    node = node.next
  end

  sad_stack[sad_stack.length / 2]
end

# ok the non-moron way to do this draws inspo from that "check
# if there's a loop" problem, which is to have a speedy pointer
# and a regular pointer. Speedy goes 2x speed, so when it reaches
# the end, the normal speed pointer has reached the middle.
# Space is O(1), time is O(n)
# @param {ListNode} head
# @return {ListNode}
def middle_node(head)
  # easy out
  return head if head.next.nil?

  single, double = head, head

  while !double.nil?
    double = double.next
    if !double.nil?
      double = double.next
      single = single.next
    end
  end

  single
end
