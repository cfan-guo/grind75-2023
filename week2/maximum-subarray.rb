# https://leetcode.com/problems/maximum-subarray/
# [Medium]
#
# Ok so my initial thought here is to keep track of the
# current max and the sum of the current subarray, which
# could go up OR down. We don't want to completely discard
# the subarray if it goes down a lil bc we could strike it
# rich later in the same subarray.
# BUT if adding the current number results in 0 or less,
# we're done with this subarray and should reset the
# current subarray to zero and skip adding any numbers unless
# they're positive.
#
# Only things to consider is that we could have an all-neg
# array so we can't initialize the max to 0. Also, here
# the order of things in the conditional-block is kinda
# important lest we overwrite the current sum incorrectly
#
# Time is O(n), space is O(1) since we only track two things
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
  # easy out
  return nums.first if nums.one?

  # initialize with smallest possible value in constraint
  # can't use 0 bc we could have an all-negative integer input
  # and the answer would then be the smallest negative number
  current_sum = -10**4
  max = current_sum

  nums.each do |n|
    # it's set to zero if we either have a bunch of negatives and
    # a zero OR we finished with the last subarray and don't have
    # a new worthy subarray, so we can skip negative numbers since
    # they're not useful in either case
    next if current_sum.zero? && n < 1

    # if the current_sum value is negative, then we only
    # want to update the sum if n > the current sum
    if current_sum < 0
      current_sum = n if n > current_sum

    # if n completely wipes the value of our current subarray (i.e
    # adding it changes the sum <= 0), then this subarray is finito
    elsif current_sum + n < 1
      current_sum = 0

    # otherwise, keep adding in hopes we make it big
    else
      current_sum += n
    end

    # update max as needed
    max = current_sum if current_sum > max
  end

  max
end

# Later me notes: yeah the comments for each attempt are strictly
# only applicable to how I wrote each method, especially above in the
# whole "check if current_sum is 0" nonsense

# I'm pretty sure I overthought this bc WHY does my 2020 JS solution
# only have like 10 lines... smh getting dumber
#
# Ok yeah I overthought it, this gets rid of the conditionals and
# whatever tomfoolery I was doing with the current sum. Need to
# remember that some of these ifs need to be just replaced with .max
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array_2(nums)
  return nums.first if nums.one?
  max, current_sum = -10**4, 0

  nums.each do |n|
    current_sum = [0, current_sum].max
    current_sum += n
    max = [current_sum, max].max
  end

  max
end

# The above gets rid of the current_sum == 0 check by just resetting
# current_sum to 0 each time, and adding the number. If it's negative
# it's still fine bc the max won't be affected if it's more negative
#
# Also Leetcode answer says this is Kadane's Algorithm and actually
# Dynamic Programming! Wow maybe I'm not hopeless

# CLRS has this in like chapter 3 Divide and Conquer but my eyes have
# always glazed over at the math bc it felt like overkill... like ok
# this segment is either in the first half of the array, the second
# half OR it straddles the middle like alright thanks it's IN THE
# ARRAY no shit... anyways I will add a TODO for this
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array_3(nums)
end

# time complexity for this is O(nlogn)
# space complexity is O(logn) which is more about the recursion stack
