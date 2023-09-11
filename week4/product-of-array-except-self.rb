# https://leetcode.com/problems/product-of-array-except-self/
# [Medium]
#
# So this needs to be O(n) and done without the division operator so
# multiplying everything in one pass and then dividing by the number
# at each index bc it's O(n) but division not allowed. Long division
# would add complexity and also make it not really O(n) anymore. And
# obviously re-multiplying everything for every element of the array
# wouldn't work bc that's O(n^2). I feel like it should be done with
# something akin to those 2-pointer problems but idk how to make that
# O(n)... so I'm missing something here.
#
# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)
  left, right = [], []
  length = nums.length

  nums.each_with_index do |_n, i|
    if i.zero?
      left[i] = 1
      right[length - 1 - i] = 1
    else
      left << left[i - 1] * nums[i - 1]
      right[length - 1 - i] = right[length - i] * nums[length - i]
    end
  end

  (0..length - 1).map {|i| left[i] * right[i]}
end

# Nvm i got it, so you can use two loops for each of the left and
# rightmost product arrays, and then another loop to get the products
# and that's still O(n) space and time. But here I just shoved it in
# one loop to populate both arrays, but the indices get annoying
#
# This stuff is cracked bc the runtime varies each time I submit it,
# like same solution going from 115ms to 160ms goes from beating 90%
# to beating 50% or something so take it with a grain of salt. Ditto
# for memory going from 219.1 to 219.37 on the same submission goes
# from beating 90% to 30%, lmfao.

# I did it slightly differently in my JS solution from 2020 lol so
# here we can have it for posterity, and translated to Ruby. Also
# the space used here is constant (not including output array).
# Same idea, except now instead of having an L and R array, we have
# a single product array that does the same as our left array in the
# first loop, and then multiplies it with the right_multiplier in the
# second loop. The right_multiplier itself keeps itself updated with
# the values on the right of our current index. Both this and the
# prev solution are O(n) runtime with only two loops. but this one
# also happens to be constant O(1) space as suggested as the question
# followup. Memory 218.57MB beats 96.28% lol but the runtime is still
# garbo depending on which submission I'm looking at.
#
# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self_2(nums)
  length = nums.length
  products = [1]
  right_multiplier = 1

  (1..length - 1).each do |i|
    products[i] = products[i - 1] * nums[i - 1]
  end

  (length - 1).downto 0 do |i|
    products[i] *= right_multiplier
    right_multiplier *= nums[i]
  end

  products
end

# Also big lol, clearly 2020 me was much smarter because I spent two
# days procrastinating on this question bc I couldn't figure out how
# to run my two arrays (L&R) properly for it to be O(n) and there I
# was in 2020 doing it also in constant space. ggggggg


# LMAO this is so cheeky hahahaha look at this comment
# > You just need to remember the identity:
# > a/b = a*(b^-1)
# This is the idea that you can just multiply everything together and
# then divide by that element... however the second there's a zero,
# 1. your product for everything is a ZERO and 2. good luck dividing
# by zero!
