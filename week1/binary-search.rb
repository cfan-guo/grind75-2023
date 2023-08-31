# https://leetcode.com/problems/binary-search/
# [Easy]
#
# For some reason this took FOREVER but the issue seemed to be
# because I didn't put returns in the if statements in the helper
# function bc i forgot they were still in the damn middle of the
# the method...
#
# honestly this was probably written better in 2021, better check
# the other folder (algorithm-study-plan)
#
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  # easy outs
  return -1 if nums.empty? || nums.first > target || nums.last < target

  left = 0
  right = nums.length - 1

  return halfish(left, right, nums, target)
end

def halfish(lower, upper, nums, target)
  middle = (upper - lower) / 2 + lower

  return middle if nums[middle] == target
  return -1 if lower > upper || lower < 0 || upper >= nums.length

  if nums[middle] > target
    return halfish(lower, middle - 1, nums, target)
  end

  if nums[middle] < target
    return halfish(middle + 1, upper, nums, target)
  end
end
