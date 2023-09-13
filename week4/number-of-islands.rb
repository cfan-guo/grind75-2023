# https://leetcode.com/problems/number-of-islands/
# [Medium]
#
# So this is a bit different from all those other griddy problems
# that end up using BFS or something bc 1. the stupid cells are "1"
# or "0" STRINGS making it a whole annoyance to convert to and from,
# and 2. it's less "expand out from a bunch of different places until
# you can't anymore, then return" and more "yeah expand out!! find
# your limits!! but haha good luck figuring out where to start :)".
#
# So the first approach I took was to keep track of all the bits that
# are land by iterating thru the entire grid (sad O(nm)). Since we
# don't really need to store anything there, and also for ease of
# search, I went with a Set over a hash or array. The idea is that
# we start with the first coordinates for land from the set, and then
# BFS from there to find the rest of the island, deleting the ones we
# encounter along the way from the set. As we encounter more land, we
# know if it's been already explored if it's land "1" but not in the
# set, and add the unexplored ones to the "visited" list. Once the
# list runs dry then we're done BFS on that island, and we can go to
# the next set of coords in the set and increment our island count.
#
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
  rows = grid.length
  cols = grid[0].length

  islands = 0
  land = Set.new

  grid.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      land << stringify(i, j) if cell == "1"
    end
  end

  return islands if land.empty?

  while !land.empty?
    i, j = coordinatify(land.first)
    to_visit = [[i, j]]
    land.delete(land.first)

    while !to_visit.empty?
      i, j = to_visit.shift
      explore([i + 1, j], land, to_visit, grid) if i + 1 < rows
      explore([i - 1, j], land, to_visit, grid) if i > 0
      explore([i, j + 1], land, to_visit, grid) if j + 1 < cols
      explore([i, j - 1], land, to_visit, grid) if j > 0
    end

    islands += 1
  end

  islands
end

def explore(cell, land, to_visit, grid)
  i, j = cell

  if grid[i][j] == "1" && land === stringify(i, j)
    to_visit << cell
  end

  land.delete(stringify(i, j))
end

def stringify(i, j)
  i.to_s + "," + j.to_s
end

def coordinatify(s)
  s.split(",").map {|x| x.to_i}
end
