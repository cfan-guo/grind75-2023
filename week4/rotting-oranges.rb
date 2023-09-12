# https://leetcode.com/problems/rotting-oranges/
# [Medium]
#
# asdlkfjasdl;f ok so it looks like this might've been the last ques
# I attempted the last time I did leetcode (2021) and i have like 10
# failed submissions lol.
#
# Idk what I did wrong last time other than overcomplicate it for
# myself but it didn't take that long to solve this time...
#
# YEAH BOIIIIII caught a speedy server and got me a 51ms runtime and
# 210.99MB memory, beating 100% and 87.23% of other rubes!!!! Anyways
# time complexity is something like O(mn) since we iterate over the
# array to get the locations of the rotters and the number of fresh,
# then we iterate over at most every cell again while looking for a
# fresh orange to infect. Spacewise is most O(mn) to store all the
# things we visited and are infected. The pro-tip to correctly calc
# the minutes is to shove each minute of new rotted finds into its
# own array, and read from the front (ruby has amortized constant
# runtime on shift iirc), and once we run out of one array then we
# know we've finished all the oranges that rotted in that minute and
# can start the next minute's worth of new rotted oranges. Just make
# sure to create that new array to add the new minute's rotters b4
# we try to add them.
#
# @param {Integer[][]} grid
# @return {Integer}
def oranges_rotting(grid)
  rows = grid.length
  cols = grid[0].length

  rotters = [[]]
  fresh = 0
  minutes = 0

  oranges = grid.map.with_index do |row, i|
    row.map.with_index do |cell, j|
      rotters[0] << [i, j] if cell == 2
      fresh += 1 if cell == 1
      cell
    end
  end

  return -1 if rotters.first.empty? && !fresh.zero?
  return 0 if fresh.zero? || rotters.first.empty?

  while !rotters.empty?
    batch = rotters.first
    newest = []
    while !batch.empty?
      current = batch.shift
      fresh = rottify(newest, oranges, fresh, current.first - 1, current.last) if current.first > 0
      fresh = rottify(newest, oranges, fresh, current.first + 1, current.last) if current.first < rows - 1
      fresh = rottify(newest, oranges, fresh, current.first, current.last - 1) if current.last > 0
      fresh = rottify(newest, oranges, fresh, current.first, current.last + 1) if current.last < cols - 1
    end

    rotters.shift
    rotters << newest unless newest.empty?
    minutes += 1 unless rotters.empty?
  end

  return -1 if !fresh.zero?
  minutes
end

# helper to calculate fresh remaining, but also to add to the rotters new
def rottify(newest, oranges, fresh, r, c)
  return fresh unless oranges[r][c] == 1
  oranges[r][c] += 1
  newest << [r,c]
  fresh -= 1
end
