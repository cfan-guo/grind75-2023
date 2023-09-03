# https://leetcode.com/problems/longest-substring-without-repeating-characters/
# [Medium]
#
# See 2021 notes/ solution for rationale which is the same, but just done
# in a prettier way than this lol
#
# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  # easy out - 0 or 1 chars
  return s.length if s.length < 2

  max_len, curr_len, start = 0, 0, 0
  encountered = {}

  s.each_char.with_index do |c, i|
    max_len = [max_len, curr_len].max

    if encountered[c] && encountered[c] >= start
      start = encountered[c] + 1
      curr_len = i - start
    end

    curr_len += 1
    encountered[c] = i
  end

  [max_len, curr_len].max
end

# 2021 me did this in a slightly different way that's a bit cleaner
# by changing the order of calculations in the loop and using .max
# in place of some of the uglier conditionals I had previously...
# ugly conditionals seems to be a pattern this round of grinding :/
#
# 2021 notes and code:
# I did this in JS a year ago, but obviously don't remember...
# Actually no, I lied. If I'm looking at nonrepeating stuff, the best for that is a
# a hash to keep track if we've seen it so far, and where we've seen it.
#
# So I think the idea is... have a hash to store each encountered letter and last
# encountered location, a substring start tracker, and substring incrementer. When
# we encounter a letter we've already seen before, we 1) change the start of the
# substring start tracker to right after the last encountered index or the current
# start index, whichever is closest, and 2) update that index in the hash table
# to the current index. Along the way we also keep track of the max substring
# length so far (max of max substring and current substring).
#
# If there are no characters or one character, we can just return 0/ 1.
#
# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  return s.size if s.size < 2

  encountered = {}
  start = 0
  maxlen = 0
  curlen = 0

  s.each_char.with_index do |c, idx|
    if encountered[c]
      start = [encountered[c] + 1, start].max
    end

    encountered[c] = idx
    curlen = idx - start + 1
    maxlen = [curlen, maxlen].max
  end

  maxlen
end
