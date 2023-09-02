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
  return n if n < 3

  # init the memo, since we know there's only 1 way to
  # take a single step and 2 ways to take 2 steps
  memo = {1=>1, 2=>2}

  step_count(n, memo)
end

def step_count(n, memo)
  return memo[n] if memo[n]

  # to see the improved time efficiency of using a memo
  # compared to climb_stairs_2
  # puts n

  if !memo[n-1]
    memo[n-1] = step_count(n-1, memo)
  end

  if !memo[n-2]
    memo[n-2] = step_count(n-2, memo)
  end

  memo[n] = memo[n-1] + memo[n-2]
end

# I feel like I didn't do this correctly but I'm too sleepy right now
# I'll look back into it tmrw... i don't even wanna bother with the
# time and space complexity (space is O(n), time is uhhh)

# Alright I am BACk and have devised this genius way to check if the
# memo above actually worked as intended!! Strip out the memo stuff
# and add a "puts n" if it doesn't hit the base case i.e. it needs to
# do more calculations which means more recursion fun.
# Comparing the number of stdout to the original solution I wrote,
# you can see this one pretty much prints about as many (maybe minus 1)
# times as there are ways to take steps (i.e the solution - 1 stdouts),
# whereas the above solution does something like n-2 total stdouts
# (since we start with n=1,2 memoized)
#
# Also: this will exceed the time limit on leetcode.
# Tested it with n=45 (max value)
# @param {Integer} n
# @return {Integer}
def climb_stairs_2(n)
  return n if n < 3

  puts n

  climb_stairs_2(n - 1) + climb_stairs_2(n - 2)
end

# Anyways recursion is overkill so there's an even better way to do
# the first solution which basically just accepts that in order to
# hit that n-th step, we need to know the values of all the steps
# along the way anyways so might as well just start by iterating
# from the bottom (now we here) #Drake #The6ix
# @param {Integer} n
# @return {Integer}
def climb_stairs_3(n)
  return n if n < 3

  # don't wanna deal with annoying math for indexing since it's
  # easier to just search up by memo[n] and not memo[n-1] bc
  # arrays are zero-indexed
  memo = [0, 1, 2]

  (3..n).each do |i|
    memo[i] = memo[i - 1] + memo[i - 2]
  end

  memo.last
end

# smh leetcode bills this as the best solution (and let's be real,
# it is kind of snazzy not to have a helper function plus i decided
# to not be dumb and use a hash) YET my memory is about the same
# but runtime is worse. Maybe bc I ran it at 4:41pm on Sat and the
# other ones at 10pm on a Friday? Oh well, at least no recursion
# plus calculating time + space complexity is EZ - we store [n+1]
# (bc easier to read when array is zero-idx'd) so O(n), and time
# is linear baybeeeee
