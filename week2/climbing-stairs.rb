# https://leetcode.com/problems/climbing-stairs/
# [Easy]
#
# Dynamic programming :')
# Alright so if we're doing this correctly, we want some
# MEMOIZATION of these subproblems. So ya think, alright, for
# each time I calculate one of these new ones I should just
# store the value, right?
#
# So for your first step, you can take either 1 or 2 steps.
# This leaves n-1 steps or n-2 steps. For n-1 or n-2 steps,
# you could start each of them with 1 or 2 steps... and so on.
# E.g. n = 2: (1,1) or (2)                  => 2 ways
#      n = 3: (1, n-1=2) => 2 ways or
#             (2, n-2=1) => 1 way           => 3 ways
#      n = 4: (1, n-1=3) => 3 ways or
#             (2, n-2=2) => 2 way           => 5 ways
# Looks like some fibofucci bullshit so dynamic programming is
# our friend QED
#
# @param {Integer} n
# @return {Integer}
def climb_stairs(n)
  # easy out
  return 1 if n < 2

  # init the memo store, since we know there's only 1 way to
  # take a single step and 2 ways two take 2 steps
  memo = {1=>1, 2=>2}

  step_count(n, memo)
end

def step_count(s, memo)
  return memo[s] if memo[s]

  if !memo[s-1]
    memo[s-1] = step_count(s-1, memo)
  end

  if !memo[s-2]
    memo[s-2] = step_count(s-2, memo)
  end

  memo[s] = memo[s-1] + memo[s-2]
end

# I feel like I didn't do this correctly but I'm too sleepy right now
# I'll look back into it tmrw...
