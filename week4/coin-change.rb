# https://leetcode.com/problems/coin-change/
# [Medium]
#
# Dynamic programming again :(
# I think taking the bottom-up approach is similar to that stairs one
# where you calculate and ✨ memoize ✨ the smallest number of coins
# for each value starting from 1 or something, since each amount is
# just the min of one of your coins + the min of what came before,
# e.g. with [2, 3, 5], making 8 would be 5 + 3 (5 coin with min for 3
# which is 1) or 3 + 5 (3 coin with min for 5, which is 1) or 2 + 6
# (2 coin with min for 6, which is 2), and then MIN the combos. Note
# that some combos would not work e.g. "4" or "6" would not have an
# option with the 5 coin and "4" would not have an option with the 3
# coin either, since 5 > 4, 6 = 5 + 1 and 4 = 3 + 1 and we have no 1s
#
# Also note that a greedy approach will not work i.e. always using the
# biggest coin e.g. 40 with [20, 25, 5] should be 2 (20, 20) but
# if we went greedy it would have been 4 (25, 5, 5, 5)
#
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
  # easy outs - zero amount or single coin
  return amount if amount.zero?
  return ((amount % coins.first).zero? ? amount / coins.first : -1) if coins.one?

  memoized = {}

  (1..amount).each do |i|
    combos = []
    coins.each do |c|
      if c > i
        next
      elsif c == i
        memoized[i] = 1
        break
      else
        difference = i - c

        combos << memoized[difference] + 1 if memoized[difference]
      end
    end

    memoized[i] = combos.min unless combos.empty? || memoized[i]
  end

  memoized[amount] || -1
end

# Well the runtime is garbage (only beats 39% of other ruby subs) but
# at least the memory is ok... we're above 87.64% of other subs...
# With this approach we memoize up to the "amount" number of values,
# with up to "coins.length" number of values we use to find the min
# at each step for something like O(a + c). As for time complexity,
# we have an outer loop of "a" with an inner loop of "c" for a fun
# O(a + c).

# Rip I tried removing the combos array (for finding the min at each
# amount up to the actual amount we wanted) and instead setting the
# initial value for each memo to the amount + 1 (since our smallest
# coin >= 1, so the most the answer could ever be is amount itself),
# and then at each loop of the coin just getting the min for that
# level with each coin. The runtime and memory are somehow worse
# (29.21% and 7.86% beat respectively, lmfao). Also by init-ing the
# memoized with {0 => 0} allows us to save a conditional branch but
# it also deprives us of the ability to break early
#
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change_2(coins, amount)
  # easy outs - zero amount or single coin
  return amount if amount.zero?
  return ((amount % coins.first).zero? ? amount / coins.first : -1) if coins.one?

  memoized = {0 => 0}

  (1..amount).each do |i|
    memoized[i] = amount + 1
    coins.each do |c|
      if c > i
        next
      else
        memoized[i] = [memoized[i - c] + 1, memoized[i]].min
      end
    end
  end

  memoized[amount] > amount ? -1 : memoized[amount]
end

# Lastly, we can try the top-down approach for this lol... it's the
# same idea with the caching but now we want to do it recursively. I
# ran this and the runtime/ memory was garbo (29.21% and 71.91% fml)
# This one is slightly different bc we check for -1 in the helper but
# we don't need to check in the main function since we will always
# assign the memo'd value as -1 if we can't make that change
#
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change_3(coins, amount)
  # easy outs - zero amount or single coin
  return amount if amount.zero?
  return ((amount % coins.first).zero? ? amount / coins.first : -1) if coins.one?

  memoized = {}

  coin_change_helper(coins, amount, memoized)
end

def coin_change_helper(coins, amount, memo)
  return -1 if amount < 0
  return 0 if amount.zero?

  combos = []

  coins.each do |c|
    difference = amount - c

    # if it doesn't exist, then we need to calculate and memo it
    if !memo[difference]
      memo[difference] = coin_change_helper(coins, difference, memo)
    end

    combos << memo[difference] + 1 unless memo[difference] == -1
  end

  combos.empty? ? -1 : combos.min
end
