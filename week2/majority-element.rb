# https://leetcode.com/problems/majority-element/
# [Easy]
#
# I'm just gonna hack together something that works first
# since Leetcode has a followup for "linear time and constant space"
# The worst thing I can think of is doing a nums.uniq and then iterate
# thru that and then do a count on the original array and compare it
# to the n/2 value...
#
# Oo I could do an O(n^2) time, O(1) space by nesting some loops lol
# but that's more effort so i won't even bother
#
# @param {Integer[]} nums
# @return {Integer}
def majority_element(nums)
  # easy out
  # if there are only 2 elements then they both have to be the same
  # number in order to satisfy the condition that
  # majority element count > (n/2).floor
  return nums.first if nums.length < 3

  midpoint = nums.length / 2
  unique = nums.uniq

  unique.each do |u|
    return u if nums.count(u) > midpoint
  end
end

# above solution is like... O(n) on the uniq (amortized, uses Hash internally)
# and then to iterate thru the unique'd list is like O(k) where k < n, so
# overall O(n) + O(k) = O(n). Space is O(k), k is # of unique elements and < n

# omg ruby has a tally and maxing method, all hail ruby
# this ran a bit faster than the first solution probably due to language
# optimizations
def majority_element_2(nums)
  return nums.first if nums.length < 3

  nums.tally.max_by{|k,v| v}.first
end

# I can probably save a small amount of space if I did it manually instead of
# using '.uniq' or 'tally', since we don't need to track any numbers that aren't
# in the first half of the list, and also some time if the best case solution
# frontloads the majority element.
# Or I can take things into my own hands and sort it and take the midpoint for
# O(nlogn) time, O(1) space (if sorting in place)
def majority_element_3(nums)
  return nums.first if nums.length < 3

  nums.sort![nums.length / 2]
end

# ran the above on leetcode and the runtime is expectedly worse but the memory
# is too... fuck that LMFAO

# the fancy implementation that leetcode has that's O(n)/O(1) uses bits...
# yeah i wasn't gonna get that ever, literally have no touched bits since 2014
def majority_element_4(nums)
  # do some bit shit
end

# i'm just gonna copy this from leetcode and deal with it later

# If an element majority_element occurs more than ⌊n/2⌋ times, then there are at
# least ⌊n/2⌋ elements of identical values with num at each bit. That is, we can
# reconstruct the exact value of num by combining the most frequent value
# (0 or 1) at each bit.

# Starting from the least significant bit, we enumerate each bit to determine
# which value is the majority at this bit, 0 or 1, and put this value to the
# corresponding bit of the result. Finally, we end up with the most least
# significant bit of all elements and return the result.

# Implementation
# Because all numbers are in the range [−10^9,10^9] which can be represented
# in 32-bit, we only need to enumerate 32 bits.

# For Python solution, notice that the sign of an integer is not represented
# in its bits. To check if the majority element is positive or negative, we
# need to figure out the majority sign additionally.

# Time complexity: O(nlog⁡C) where C is the max absolute value in nums, i.e.,
# 10^5 in this problem. We enumerate all log⁡C bits for each number in nums

# Space complexity: O(1) since we count the majority of each bit in O(1)
# space as it only has the two potential values, 0 and 1. After that, we
# only need to put the majority values to their corresponding bit
# in the returned result, and no extra space is used.
