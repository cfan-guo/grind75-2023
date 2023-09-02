# https://leetcode.com/problems/reverse-linked-list/
# [Easy]
#
# This one took forever bc I couldn't remember how to keep
# track of the nodes and it got really ugly really quickly.
# 2021 me seems to have solved this pretty quickly, alas!
# I think the TLDR of this could go something like
#       h
# nil  (1) -> (2) -> (3) -> nil
#  p    c
#  p <- c      f                   # following set to curr.next
#       p  <-  c      f            # curr points to prev
# ...                              # it keeps moving towards the end
#
# Basically we keep track of 3 points and slowly move down
# the original list direction
#
# Notes from 2021 me:
#
# So this one's pretty basic, just don't screw up the order and try to visit a null
# node and you're set. The gist of it is that we need to traverse the linked list and
# what was once previous, is now next. To do that, we track the current node we're
# updating the links for, as well as its original previous and next nodes. Once our
# "current" node hits the original end of the list, then we can stop because our list
# has been fully reversed.
#
# I prefer the iterative approach because I don't run the same risks of a stack
# overflow, and also because this question is one where it was easier for me to think
# up an iterative solution rather than a recursive one.
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
def reverse_list(head)
  # easy outs
  return head if head.nil? || head.next.nil?

  curr = head
  prev = nil

  while curr != nil
    # set up the next node to jump to once we reverse
    following = curr.next

    # this links our current node to the prev node, doing the reversing
    curr.next = prev

    # everyone shimmies down a node: prev moves to where curr is now
    # curr moves to its previously next node i.e. following
    prev = curr
    curr = following
  end

  prev
end

# Here we have the recursive version which is kinda annoying to think about,
# which 2021 me agrees with. This is what I wrote then:
#
# Alternatively, we can do this recursively using a helper method
# Same logic applies with using one to track the original next and previous nodes,
# except now we have our "base case" to stop rather than having it as the condition
# of our while loop
#
# While all recursive approaches mean push stuff onto a call stack, this particular
# one uses tail recursion i.e. the recursive call is the last line of the recursive
# function. This is better bc apparently modern compilers can optimize for this.

# 2023 me again... where tf did I learn about tail recursion...

# @param {ListNode} head
# @return {ListNode}
def reverse_list_2(head)
  # easy outs
  return head if head.nil? || head.next.nil?

  curr = head
  prev = nil

  swap(curr, prev, nil)
end

def swap(curr, prev, following)
  # base case: end of the list
  return prev if curr.nil?

  # same as the iterative stuff
  following = curr.next
  curr.next = prev
  prev = curr
  curr = following

  swap(curr, prev, following)
end

# Another way to do this that is less space efficient is to add these
# nodes to a stack and pop them off lol. This is a space-waster but I mean
# is recursion really that efficient either? I think not!! Space is O(n) for
# obvious reasons, but at least the time complexity is technically still linear
# This idea is courtesy of Ham, who supports me in the worst ways
# @param {ListNode} head
# @return {ListNode}
def reverse_list_3(head)
  # easy outs
  return head if head.nil? || head.next.nil?

  sad_stack, new_head = [], nil
  node = head

  # iterate thru the list and push the nodes into a stack
  while !node.next.nil?
    sad_stack.push(node)
    node = node.next
  end

  # set the new head as the last node (i.e. pointing to nil)
  new_head = node

  # pop off the nodes and attach them
  while !sad_stack.empty?
    node.next = sad_stack.pop
    node = node.next
  end

  # IMPORTANT: set this to nil or your list is now a bracelet
  node.next = nil

  new_head
end
