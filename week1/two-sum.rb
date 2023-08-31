# https://leetcode.com/problems/two-sum/
# [Easy]
#
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  indices = {}
  nums.each_with_index do |num, idx|
    return [idx, indices[num]] if indices[num]
    indices[target-num] = idx
  end
end
