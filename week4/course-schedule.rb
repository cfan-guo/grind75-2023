# https://leetcode.com/problems/course-schedule/
#
# [Medium]
#
# This can be done with topological sort so uhhhh organize this and
# check if there's a cycle. If there's a cycle then your schedule is
# bad and you're not graduating on time and the profs/ admins are bad
# To get to a topo sort from a regular degular graph it uses Kahn's
# algo or something. But also apparently DFS will work but you gotta
# keep track of both what you've already visited and what you visited
# in *this round* of DFS-ing. Also first attempt at DFS isn't fast
# enough for the last 4 test cases, sadness :(
#
# Side note, I'm using arrays of length num_courses instead of a hash
# for the adjacency list bc while it's less space efficient, there's
# less "if this key doesn't exist, add and initialize it first" vs.
# just initializing a fixed length array with empty arrays for its
# connected vertices.
#
# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish(num_courses, prerequisites)
  # easy out
  return true if prerequisites.empty?

  # gotta convert to an adjacency list first, booooo
  # also we need to keep track of all the nodes with outgoing edges
  # since we could have a disconnected graph with a cycle
  adj = Array.new(num_courses){[]}
  nodes = Set.new()
  prerequisites.each do |p|
    adj[p.last] << p.first
    nodes.add(p.last)
  end

  # used to track if a node is currently in the stack
  recursed = Array.new(num_courses)

  # start with first prereq and go until we either find a cycle
  # or until we deplete all the nodes
  while !nodes.empty?
    is_dag = dfs(nodes.first, recursed, adj, nodes)
    return is_dag unless is_dag
  end

  # no falses were returned so this schedule works
  true
end

def dfs(current, recursed, prereqs, nodes)
  # we've seen this node already this round, so there's a cycle
  return false if recursed[current]

  recursed[current] = true

  prereqs[current].each do |p|
    is_dag = dfs(p, recursed, prereqs, nodes)
    return is_dag if !is_dag
  end

  # done looking at things from this node, remove it from the node
  # set and recursed tracker since we did not detect any cycles
  recursed[current] = false
  nodes.delete(current)
  true
end

####################################################################
# NOTE THAT THE ABOVE TIMES OUT/ ONLY WORKS FOR 48/52 TESTCASES :( #
####################################################################
# also note that we didn't track if we've been there before with the
# whole temp vs permanent visited stuff, we only track if we've seen
# it in the current cycle. So there's a chance that it's garbo time,
# since we might be running into the same vertex multiple times and
# checking its neighbours multiple times in each cycle instead of
# quitting while it's ahead (it doesn't know it's ahead!!!)

# Instead we implement the wikipedia pseudocode for detecting a cycle
# in a graph with DFS, which feels kind of similar to what we have,
# except it's not explicitly setting a "recursed" array to check if
# we've been here before - it's using the temp vs. perma-check. This
# works bc you can only ever perma-check something if you've been
# there before and there were no cycles, so if something's already
# perma-checked that means there's no cycle there, so the next time
# it pops up we can skip it.
#
# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish_2(num_courses, prerequisites)
  # easy out
  return true if prerequisites.empty?

  # create and populate adjacency list
  adj = Array.new(num_courses){[]}
  prerequisites.each do |p|
    adj[p.last] << p.first
  end

  # we will use this to mark if the vertex has been visited
  # (permanently or temporarily): nil is default/ unvisited, false is
  # temp visited, true is visited
  visited = Array.new(num_courses)

  # rather than using the Set like the previous one, we'll just reuse
  # the adjacency list and skip any vertices with no outgoine edges
  # once we get a "false" that means we got a cycle and can terminate
  (0..num_courses - 1) do |i|
    next if adj[i].empty? || visited[i]
    is_dag = dfs_2(i, adj, visited)
    return is_dag unless is_dag
  end

  # no falses were returned so this schedule works 👍
  true
end

def dfs_2(current, adj, visited)
  return true if visited[current]
  return false if visited[current] == false

  # mark as temporarily visited
  visited[current] = false

  # run dfs_2 on each connection of this vertex
  adj[current].each do |a|
    is_dag = dfs_2(a, adj, visited)
    return is_dag unless is_dag
  end

  # mark as permanently visited
  visited[current] = true
end

# Okay I fixed my garbage from the first attempt so it works with all
# the test cases without timing out. My issue was that I wasn't using
# the "visited" array I initially had with the "recursed" array to do
# the early exit bc I forgot that lil bit about the perma-check (i.e.
# it can only get checked if we confirmed there's no loop, so early
# exit if we see it again)
#
# Also got rid of the Set, easier to just skip nodes with no outgoing
# edges or that we've seen before. This soln is 60ms/ 212.53mb,
# beating 94% and 46.55% whereas the previous was 80 and 212.43 (67%
# and 53%), with memory going to 211.66 (85%) if I replace the
# adj.each with (0..num_courses - 1) each. Idk lol, whatever these #s
# are fake anyways.
#
# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish_3(num_courses, prerequisites)
  # easy out
  return true if prerequisites.empty?

  # gotta convert to an adjacency list first, booooo
  adj = Array.new(num_courses){[]}
  prerequisites.each do |p|
    adj[p.last] << p.first
  end

  # used to track if a node is currently in the stack and if we've
  # seen it before
  recursed = Array.new(num_courses)
  visited = Array.new(num_courses)

  # we need this bc the graph can be cyclic and disconnected
  (0..num_courses - 1).each do |i|
    next if adj[i].empty? || visited[i]

    is_dag = dfs_3(i, recursed, adj, visited)
    return is_dag unless is_dag
  end

  # no falses were returned so this schedule works
  true
end

def dfs_3(current, recursed, prereqs, visited)
  # we've seen this node before and it didn't cycle, so skip
  return true if visited[current]

  # we've seen this node already this round, so there's a cycle
  return false if recursed[current]

  recursed[current] = true

  prereqs[current].each do |p|
    is_dag = dfs_3(p, recursed, prereqs, visited)
    return is_dag if !is_dag
  end

  # done looking at things from this node, add it to the visited list
  # since we did not detect any cycles, remove from current stack
  # autoreturns true (visited[current]) thanks to ruby!!
  recursed[current] = false
  visited[current] = true
end

# lastly there's Kahn's algo lol do this later :/
#
# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish_4(num_courses, prerequisites)
  # TODO: kahn's algo for topo sort except we only care about if
  # there's a cycle or not, dgaf about the order itself.
  #
  # here's the pseudocode from wikipedia for an actual list
  #
  # L ← Empty list that will contain the sorted elements
  # S ← Set of all nodes with no incoming edge

  # while S is not empty do
  #     remove a node n from S
  #     add n to L
  #     for each node m with an edge e from n to m do
  #         remove edge e from the graph
  #         if m has no other incoming edges then
  #             insert m into S

  # if graph has edges then
  #     return error   (graph has at least one cycle)
  # else
  #     return L   (a topologically sorted order)
end
