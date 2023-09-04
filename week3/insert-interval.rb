# https://leetcode.com/problems/insert-interval/
# [Medium]
#
# Initial thoughts - to find a good place to insert, maybe adapt some
# sort of binary search (since the array of existing intervals is
# already sorted). Moving this to approach 2 tho since I just did
# "56. Merge Intervals" and it's easier to just adapt that and start
# with a linear search, where I hopefully don't eff up my indices and
# go out of bounds like I would with b search. TC: O(n), SC: O(n).
#
# @param {Integer[][]} intervals
# @param {Integer[]} new_interval
# @return {Integer[][]}
def insert(intervals, new_interval)
  # easy out
  return [new_interval] if intervals.length.zero?

  merged = []
  inserted = false

  # iterate thru the existing intervals - for each of these, we want
  # to compare it against the new interval to decide who to insert
  # first. Once we've inserted then we no longer need to check each
  # time (but we might need to merge)
  intervals.each do |i|
    if inserted
      merge_and_insert_interval(merged, i)
    else
      if new_interval.first < i.first
        merge_and_insert_interval(merged, new_interval)
        inserted = true
      end
      merge_and_insert_interval(merged, i)
    end
  end

  # if we made it thru the list but the new interval hasn't been
  # added, then we add it here
  if !inserted
    merge_and_insert_interval(merged, new_interval)
  end

  merged
end

def merge_and_insert_interval(merged, interval)
  return merged << interval if merged.empty?

  prev = merged.last
  if interval.first <= prev.last
    prev[1] = [interval.last, prev.last].max
  else
    merged << interval
  end
end

# The runtime and memory on the above is apparently ATROCIOUS, so we
# need to actually implement the nonlinear strat (i.e. binary search)
# For this, the searching should be O(logn) runtime or something, but
# then it's still O(n) to merge if needed.
#
# I originally thought maybe I could use bi search again to find the
# last interval to merge by comparing end range of the new interval
# with the end ranges of the existing intervals, and then similarly
# to the insert, check if I needed to merge, but it was kind of not
# working so either I logic'd wrong or wrote it wrong, sigh
#
# This approach is similar to what LC has on approach 2, and reuses
# the merge and insert helper above
#
# @param {Integer[][]} intervals
# @param {Integer[]} new_interval
# @return {Integer[][]}
def insert_2(intervals, new_interval)
  return [new_interval] if intervals.length.zero?

  # find the place to add the new interval
  insertion_idx = find_insertion_point(0,
    intervals.length - 1,
    intervals,
    new_interval.first
  )

  before = intervals.slice(0, insertion_idx)
  after = intervals.slice(insertion_idx, intervals.length - insertion_idx)

  merge_and_insert_interval(before, new_interval)
  after.each do |a|
    merge_and_insert_interval(before, a)
  end

  before
end

# target is the start value for the new interval
def find_insertion_point(lower, upper, intervals, target)
  while lower <= upper
    middle = (upper - lower) / 2 + lower
    if intervals[middle].first == target
      return middle
    elsif intervals[middle].first > target
      upper = middle - 1
    else
      lower = middle + 1
    end
  end

  lower
end

# I didn't really use this, but this is a method to find if two
# intervals overlap (do they share any numbers in between)
def overlap(a, b)
  [a.last, b.last].min - [a.first, b.first].max >= 0
end
