# https://leetcode.com/problems/permutations/
# [Medium]
#
# Ughhhhhh ok this question this great bc there are a couple of algos
# to actually get all the permutations that you can memorize, or you
# can struggle to figure out a way to get every number, every single
# position. An array of length N has N! (N factorial, baby!) perms so
# a max of 6 numbers in the array means a max of 720 combos. There's
# Heap's algo which at least has pseudocode on wikipedia, as well as
# a "Steinhaus–Johnson–Trotter" algo which seemed more complicated bc
# wiki didn't have pseudocode, lol
#
# alternatively there's some backtracking thing you could do i guess
#
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
  # easy out
  return [nums] if nums.one?

  permutations = []
  heaps_algo(nums.length, nums.clone, permutations)
  permutations
end

def heaps_algo(k, arr, permutations)
  if k == 1
    permutations << arr.clone
  else
    (0..k - 1).each do |i|
      heaps_algo(k - 1, arr, permutations)
      idx = k.even? ? i : 0
      arr[idx], arr[k - 1] = arr[k - 1], arr[idx]
    end
  end
end
