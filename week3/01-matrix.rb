# https://leetcode.com/problems/01-matrix/
# [Medium]
#
# Initial thoughts: we can initialize a new matrix with the distances
# using the input matrix, since the values will only ever be 1/0, and
# the distance of a 0 cell to the nearest 0 is 0 so that work is done
#
# For the 1s, we can just set them as null or some number that's much
# larger than the size of the input dimensions m*n so when we compare
# distances, we know that it's not actually set yet.
#
# Anyway after attempting what turned out to be the DP approach (and
# failing miserably bc it stack overflowed bc I tried BFS and didn't
# save my visited cells anywhere, lmao) I'm gonna move that to v2 and
# use good ol' "find all the zeros and then BFS from there", which
# should have an O(mn) time since we visit each node exactly once, we
# initialize the visited list + the distances array at the same time
# by iterating over the entire array, and assume queue ops takes O(1)
# Space is O(mn) to store the distances and at most O(mn) for visited
#
# @param {Integer[][]} mat
# @return {Integer[][]}
def update_matrix(mat)
  # easy out - single cell
  return mat if mat.one? && mat[0].one?

  rows = mat.length
  cols = mat[0].length

  # using an array for our queue with push + shift
  # if I was truly keen then I'd make a doubly linked list for actual
  # O(1) shift + push (with slightly more space used)
  visited = []

  # init distance matrix, store idxs of the zeros in the queue
  distances = mat.map.with_index do |row, i|
    row.map.with_index do |cell, j|
      if cell.zero?
        visited << [i, j]
        cell
      else
        nil
      end
    end
  end

  # as we update distances, we want to add the idxs of those newly
  # updated cells to our visited list so we can check their adjacent
  # cells as well. Once there's nothing left to check then we've
  # visited every single cell on the board.
  while !visited.empty?
    current = visited.shift # ruby array shift is amortized O(1)
    value = distances[current.first][current.last]

    # visit all 4 directly connected cells, if available
    update_value(visited, distances, current.first - 1, current.last, value) if current.first > 0
    update_value(visited, distances, current.first + 1, current.last, value) if current.first < rows - 1
    update_value(visited, distances, current.first, current.last - 1, value) if current.last > 0
    update_value(visited, distances, current.first, current.last + 1, value) if current.last < cols - 1
  end

  distances
end

# helper to update distance and add to visited queue, if needed
def update_value(visited, distances, r, c, value)
  return unless distances[r][c].nil?

  visited << [r, c]
  distances[r][c] = value + 1
end

# This approach uses DP, 'cept I messed up the implementation despite
# having the lil subproblem done correctly i.e. the distance at any
# cell would be 1 + [left, right, top, bottom].min, dependent on
# those cells being valid and not out of bounds. BUT if you just
# iterate from the beginning, you're SOL if the neighbours of the
# cell being looked don't have values either, since you'll go right
# to them and they'll go left to you and ping pong in despair before
# your computer gives up and dies. The whole thing with DP is that
# the values it's calculating from have to already exist
#
# Instead, the way to go is to limit the directions we can originate
# from. So rather than 1 + [left, right, top, bottom].min, we would
# first imagine that we could only travel ➡️⬇️, and then only ⬅️⬆️,
# finding the min for each of those. In the first case, we'd travel
# from [0,0] and only go down and right, and then we traverse in the
# opposite direction and compare the mins and replace with the one
# min to rule them all.
#
# @param {Integer[][]} mat
# @return {Integer[][]}
def update_matrix_2(mat)
  # easy out - single cell
  return mat if mat.one? && mat[0].one?

  rows = mat.length
  cols = mat[0].length
  big_num = rows * cols

  # init distance matrix
  distance = mat.map do |row|
    row.map do |cell|
      cell.zero? ? cell : nil
    end
  end

  # as we iterate right + down, we pretend that the only place the
  # cell could have got its value is from the adjacent left and above
  (0..rows - 1).each do |r|
    (0..cols - 1).each do |c|
      next unless distance[r][c].nil?
      distance[r][c] = big_num
      distance[r][c] = [distance[r][c], distance[r - 1][c] + 1].min if r > 0
      distance[r][c] = [distance[r][c], distance[r][c - 1] + 1].min if c > 0
    end
  end

  # as we iterate left + up, we pretend that the only place the cell
  # could have got its value is from the adjacent right and below
  (0..rows - 1).reverse_each do |r|
    (0..cols - 1).reverse_each do |c|
      distance[r][c] = [distance[r][c], distance[r + 1][c] + 1].min if r < rows - 1
      distance[r][c] = [distance[r][c], distance[r][c + 1] + 1].min if c < cols - 1
    end
  end

  distance
end

# just going to paste the LC proof instead of trying to explain it:
# Assume we have a 2x2 matrix: [a, b], [c, d]. There are two possibilities:
# a = 0. On the first pass (moving down and right only), we can
# correctly calculate dp.
# a = 1. One of b, c, d must be 0, since the constraints say there
# must be at least one 0. No matter where the 0 is, we can calculate
# the correct distance for d, since it is in the bottom right. Now
# that we know the answer for d, in the second pass, we can calculate
# the answer for b, c, and with that we can calculate the answer of a.
# Therefore, a, b, c, d can always be calculated regardless of their
# initial values. This logic extends to any size matrix.
