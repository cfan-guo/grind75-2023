# https://leetcode.com/problems/merge-two-sorted-lists/
# [Easy]
#
# When I hear "merge sorted lists", I think recursion. Which is exactly why I
# decided to go with a loop, lol.
# There's a few things to keep track of here - the head of the merged list, the
# current position in the merged list, and the head of the other list.
# The idea is that you start by comparing the values of the first nodes, and as
# long as the next node in that same list is smaller than the current head of
# the other list, you keep going down the same list and checking. Switch over
# when that's no longer the case, and continue until there are no nodes left.
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} list1
# @param {ListNode} list2
# @return {ListNode}
def merge_two_lists(list1, list2)
  # easy outs
  return nil if list1.nil? && list2.nil?
  return list1 if list2.nil?
  return list2 if list1.nil?

  # pointers to the head, the comparer, and the head of the nonmerged list
  head = list1.val <= list2.val ? list1 : list2
  p_check = head
  p_save = list1.val > list2.val ? list1 : list2

  # while the list with the currently smaller nodes has more nodes
  # we will compare the next node in the list (A) with the head of the nonmerged (B)
  # as soon as B < A, we will switch who's who
  while !p_check.next.nil? do
    if p_check.next.val <= p_save.val
      p_check = p_check.next
    else
      p_check.next, p_save = p_save, p_check.next
    end
  end

  # if there's anything left over in the nonmerged list
  # then append it to the merged list
  if !p_save.nil?
    p_check.next = p_save
  end

  head
end
