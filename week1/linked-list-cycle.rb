# https://leetcode.com/problems/linked-list-cycle/
# [Easy]
#
# Hell yeah finally something I might actually remember doing
# If I remember correctly, the trick is to have two pointers but
# set them to traverse the array at different "speeds" so they
# intersect if there's a loop in the list.
# Otherwise, we just need to check that the faster moving pointer
# doesn't run into the end before incrementing - and if it runs into
# an end, then tada no loop!
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end
#
# @param {ListNode} head
# @return {Boolean}
def hasCycle(head)
  # easy outs - no cycle if 0 or 1 node
  # plus gotta check that next next so I can assign it lol
  return false if head.nil? || head.next.nil? || head.next.next.nil?

  p = head
  p2 = head.next.next

  while !p2.next.nil? && !p2.next.next.nil?
    return true if p == p2 || p.next == p2 || p2.next == p

    p2 = p2.next.next
    p = p.next
  end

  false
end
