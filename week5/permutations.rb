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
      # run heaps algo
      heaps_algo(k - 1, arr, permutations)

      # it does this swapping based on even/ odd value of k
      idx = k.even? ? i : 0
      arr[idx], arr[k - 1] = arr[k - 1], arr[idx]
    end
  end
end

# aha so there's also the backtracking way where you can visualize
# the choices like nodes in a tree, e.g. for [1, 2, 3], zero-indexed
#                     (root)
# 0th pos      1        2        3
# 1st pos    2   3    1   3    1   2
# 2nd pos    3   2    3   1    2   1
# -> [1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]
#
# and here for [1, 2, 3, 4]
#                       (root)
# 0th pos                 1               ...   2   ...   3   ...  4
# 1st pos      2          3          4
# 2nd pos    3   4      2   4      2   3
# 3rd pos    4   3      4   2      3   2
#
# but how do we get those nodes? Well for each level down, we "fix"
# the numbers we already have in the array we're building up, and add
# the numbers we haven't already added. And then we pop off the last
# added number and do it with the next one, in a recursive way
# e.g. for [1,2,3]: fix 1 [1] -> fix 2 [1,2] -> fix 3 [1,2,3], add
#                             -> pop off 2, fix 3 [1,3] -> fix 2 [1,3,2], add
#                -> pop off 1, fix 2 [2] ... repeat process
#
# @param {Integer[]} nums
# @return {Integer[][]}
def permute_2(nums)
  # easy out
  return [nums] if nums.one?

  permutations = []
  backtrack([], permutations, nums.clone)

  permutations
end

def backtrack(curr, permutations, nums)
  if curr.length == nums.length
    permutations << curr.clone
  else
    nums.each do |n|
      if !curr.include? n
        # add the value if not already there
        curr << n

        # recurse
        backtrack(curr, permutations, nums)

        # backtrack
        curr.pop
      end
    end
  end
end

# time complexity for this is approximately (n * n!) since there are
# n! permutations, and we end up iterating thru n each time to build
# each perm. According to the LC editorial there's more math involved
# but i was not keen enough to commit that to memory. Space is O(n)
# since we use that to track each time + the stack

# last solution i'll bother with is kind of a mix of the two, since I
# probs didn't understand the Heap's algo correctly lol. Instead of
# pushing and popping, we swap as we go along
# e.g. for [1, 2, 3], with () indicating "fixed"
#                                             123
# swap each with 0th        (1)23            (2)13            (3)21
# swap each with 1st    (12)3   (13)2    (21)3   (23)1    (32)1   (31)2
# at this point, the nums are set
#
# @param {Integer[]} nums
# @return {Integer[][]}
def permute_3(nums)
  # easy out
  return [nums] if nums.one?

  permutations = []
  swapperoo(nums.clone, permutations, 0, nums.length - 1)

  permutations
end

def swapperoo(curr, permutations, l, r)
  if l == r
    permutations << curr.clone
  else
    (l..r).each do |i|
      # swap
      curr[l], curr[i] = curr[i], curr[l]

      # recurse
      swapperoo(curr, permutations, l+1, r)

      # backtrack
      curr[l], curr[i] = curr[i], curr[l]
    end
  end
end
