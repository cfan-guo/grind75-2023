# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/
# [Medium]
#
# Not sure why this would be medium compared to regular 2sum (week 1)
# maybe other than the fact that this array is 1-indexed, gross.
#
# Doing this bc I'm procrastinating on 3sum but yeah if the array is
# sorted and we only have 1 possible solution, we do a left pointer
# right pointer type of deal, and then kill it if they cross (which
# they WON'T bc there's exactly ONE solution). If big num and small
# num add up to the target then yay, if > then move down the big boy
# and if < then move up the smol boy.
#
# @param {Integer[]} numbers
# @param {Integer} target
# @return {Integer[]}
def two_sum(numbers, target)
  left, right = 0, numbers.length - 1

  while left < right
    sum = numbers[left] + numbers[right]
    if sum > target
      right -= 1
    elsif sum < target
      left += 1
    else
      return [left + 1, right + 1]
    end
  end
end
