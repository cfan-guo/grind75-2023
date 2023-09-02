# https://leetcode.com/problems/contains-duplicate/
# [Easy]
#
# Ooo all sorts of ideas for this one - we can do .uniq and compare
# the length of that to the length of the original array, we can
# do a tally and see if there's any where tally > 1, we can manually
# iterate with a hash and the second we have a matching key we
# return, we can iterate and do a count on each value and return the
# second we get a value that's >1 (probs O(n) runtime tho)
# @param {Integer[]} nums
# @return {Boolean}
def contains_duplicate(nums)
  # easy out
  return false if nums.length < 2

  nums.length > nums.uniq.length
end

# even though we're not storing uniq, the result takes up space
# somewhere plus I assume it's like O(n) to go thru the array to
# get those uniq attrs. So space/ time are probs both O(n)

# you'd think this might run a bit faster bc we'd exit earlier
# and not go thru the entire array if there are dupes, but nope
# @param {Integer[]} nums
# @return {Boolean}
def contains_duplicate_2(nums)
  return false if nums.length < 2

  count = {}
  nums.each do |n|
    return true if count[n]
    count[n] = 1
  end

  false
end

# this does a tally and then iterates on that which is also slow
# @param {Integer[]} nums
# @return {Boolean}
def contains_duplicate_3(nums)
  return false if nums.length < 2

  !nums.tally.filter {|k, v| v > 1}.empty?
end

# ok ya the solutions are like "linear search for dummies O(n^2) FAIL",
# "sort and check consecutive O(nlogn) sort, O(n) sweep" and the hash
# stuff we did
