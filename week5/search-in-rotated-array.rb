# https://leetcode.com/problems/search-in-rotated-sorted-array/
# [Medium]
#
# fml i opened this question and it says i've solved it before.
# if i recall correctly, use binary search to find the pivot point
# and then from there, use binary search on whatever the pivot was
#
# lmao tricky bitches, the array only *might* be rotated
#
# in this approach, i have a binary search helper and a pivot helper
# which basically uses the binary search way, except we compare with
# the first element to decided where we move the left/ right pointer.
# The pivot helper returns the index of the biggest number, as long
# as the array is actually rotated. If the midpoint is bigger than
# the first element, we know we haven't yet found the pivot point so
# we can move the left pointer up. Otherwise, we've passed it so we
# move the right pointer down.
#
#       0  1  2  3  4  5  6  7
# e.g. [4, 5, 6, 7, 8, 0, 1, 2]
#       L        M           R  M+1 !< M and M !< M-1. M > L, regroup
#                   L  M     R  M-1 > M, we have found pivot point
#
# I'm pretty sure that if you wanted to nest a bunch of if statements
# together, you can do this with one binary search but ehhh i'll pass
# too many annoying cases to keep track of and indices and stuff
#
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  # easy out
  return nums.first == target ? 0 : -1 if nums.one?

  # no rotation
  return bin_search(nums, target, 0, nums.length - 1) if nums.first < nums.last

  # find pivot and then binary search the relevant side
  biggest = find_pivot(nums)
  if target <= nums[biggest] && target >= nums.first
    bin_search(nums, target, 0, biggest)
  else
    bin_search(nums, target, biggest + 1, nums.length - 1)
  end
end

def find_pivot(nums)
  left = 0
  right = nums.length - 1

  while left <= right
    mid = left + (right - left) / 2
    return mid if nums[mid + 1] < nums[mid]
    return mid - 1 if nums[mid] < nums[mid - 1]

    if nums[mid] > nums.first
      left = mid + 1
    else
      right = mid - 1
    end
  end
end

def bin_search(nums, target, left, right)
  while left <= right
    mid = left + (right - left) / 2

    return mid if nums[mid] == target

    if nums[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  -1
end
