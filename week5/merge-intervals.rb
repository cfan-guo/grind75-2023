# https://leetcode.com/problems/merge-intervals/
# [Medium]
#
# Grind75 has "57. Insert Interval" in week 3, but for those of us
# who need to get into that mental space, doing an easier related
# version helps. Note that the input array is not sorted, so one of
# the approaches and the first one we take here is to just sort the
# input array so things are in order for us to merge. O(nlogn) time
# (sorting, mostly) and then O(n) space to store the merged array
#
# @param {Integer[][]} intervals
# @return {Integer[][]}
def merge(intervals)
  # easy out
  return intervals if intervals.length < 2

  # the question doesn't explicitly state if the intervals are
  # presorted so we need to sort them... sad + O(nlogn) time
  intervals.sort_by! {|i| i.first}

  merged = []

  intervals.each do |i|
    # directly add first one if available
    if merged.empty?
      merged << i
    # now we need to compare the last interval we added to the merged
    # array with the interval we're currently looking at here
    else
      prev = merged.last
      if i.first <= prev.last
        prev[1] = [i.last, prev.last].max
      else
        merged << i
      end
    end
  end

  merged
end

# according to the editorial, there's another approach which looks at
# turning things into vertices and edges, lol. But it's apparently
# the "brute force" solution, not that I would've been smart enough
# to think about it that way... TC is O(n^2) to build a graph, then
# to traverse and merge is O(n) each. SC is O(n^2) worst case all of
# the intervals are mutually overlapping - an edge btwn every pair.
# Sounds complicated but it's literally just comparing every interval
# to every other interval to check if it overlaps. We need to connect
# these bc some intervals which might not overlap by themselves would
# actually overlap once we start merging the overlapping intervals
#
# e.g. in [[1,5], [6,10], [4,7], [16,20], [15,17]], [1,5] and [6,10]
# don't directly overlap, but they both overlap with [4,7] and this
# throuple overlaps once we start merging. We also need to store
# visited nodes so we don't end up infinitely stuck somewhere when
# determining which nodes to merge together.
#
# connections = {
#   [1,5]: [[6,10], [4,7]],
#   [6,10]: [[1,5], [4,7]],
#   [4,7]: [[1,5], [6,10]],
#   [16,20]: [15,17],
#   [15,17]: [16,20]
# }
#
# for this approach, checking overlap is more annoying bc for each
# interval A and B, you have to check if A[0] and B[1] as well as
# B[0] and B[1].
#
# @param {Integer[][]} intervals
# @return {Integer[][]}
def merge_2(intervals)
  # TODO: add brute force solution
end
