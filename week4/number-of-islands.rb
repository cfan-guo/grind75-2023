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
      land << [i.to_i, j.to_i] if cell == "1"
    end
  end

  return islands if land.empty?

  while !land.empty?
    cell = land.first
    to_visit = [cell]
    land.delete(cell)

    while !to_visit.empty?
      i, j = to_visit.shift
      explore(i + 1, j, land, to_visit, grid) if i + 1 < rows
      explore(i - 1, j, land, to_visit, grid) if i > 0
      explore(i, j + 1, land, to_visit, grid) if j + 1 < cols
      explore(i, j - 1, land, to_visit, grid) if j > 0
    end

    islands += 1
  end

  islands
end

def explore(r, c, land, to_visit, grid)
  to_visit << [r, c] if grid[r][c] == "1" && land === [r, c]
  land.delete([r, c])
end

# another way to do this is to just... loop thru once and every time
# we (🎵 touch 🎵) see land, we BFS and transform all the land to nil
# or something else, and then just skip on by otherwise.
#
# @param {Character[][]} grid
# @return {Integer}
def num_islands_2(grid)
  rows = grid.length
  cols = grid.first.length

  island = 0

  grid.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      next if cell.nil?
      next unless cell == "1"

      island += 1
      visit_island(i, j, grid)
    end
  end

  island
end

def visit_island(i, j, grid)
  return if outta_bounds(i, j, grid)
  return unless grid[i][j] == "1"

  grid[i][j] = nil

  visit_island(i + 1, j, grid)
  visit_island(i - 1, j, grid)
  visit_island(i, j + 1, grid)
  visit_island(i, j - 1, grid)
end

def outta_bounds(i, j, grid)
  return true if i < 0 || j < 0
  i >= grid.length || j >= grid.first.length
end
