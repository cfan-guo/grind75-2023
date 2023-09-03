# https://leetcode.com/problems/k-closest-points-to-origin/
# [Medium]
#
# There's probably a more efficient way to do this, but we're lazy :)
# Initial thought is to sort the distances for the points, but also
# keep track of which points are associated with each distance (since)
# we could have multiple points with the same distance. Rather than
# keep track of the closest k values as we iterate through the points
# array, I opted to just... use a hashmap with the distances as the
# keys, then at the end of iterating we turn those keys into an array
# and sort + slice to get our k closest distances. Since the closest
# k distances might have multiple points, we then push those points
# and return the first k of them.
#
# This makes time comp O(nlogn) since sort probably takes that long
# (i'd have to check for Ruby's specific sort TC), and space is O(n)
#
# @param {Integer[][]} points
# @param {Integer} k
# @return {Integer[][]}
def k_closest(points, k)
  # easy out
  return points if k == points.length

  distances = {}

  points.each do |p|
    dist = p.first**2 + p.last**2
    if distances[dist]
      distances[dist] << p
    else
      distances[dist] = [p]
    end
  end

  # take closest k distances
  closest_distances = distances.
    map {|k,v| k}.
    sort.
    slice(0, k)

  # since each distance might have multiples, we take first k points
  closest_points = closest_distances.
    map {|c| distances[c]}.
    flatten(1).
    slice(0, k)
end

# the solution editorial does a divide and conquer with quickselect
# to partially sort the subarray or something.. also idk people in
# the comments are talking about approach 3 and approach 4 BUT the
# current editorial only has 2 approaches, one of which is basically
# what i did. Looking at the code it looks like we're just
# implementing quicksort... why
#
# @param {Integer[][]} points
# @param {Integer} k
# @return {Integer[][]}
def k_closest_2(points, k)
  # TODO: divide and conquer
  # https://leetcode.com/problems/k-closest-points-to-origin/editorial/
end
