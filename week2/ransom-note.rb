# https://leetcode.com/problems/ransom-note/
# [Easy]
#
# Hm, similar to 278. first bad version looking like 704. binary search,
# this one feels similar to 242. valid anagram. So a quick solution we can
# reuse some of that logic where we iterate thru the magazine and add its
# letters to a hash (26 keys total for the lowercase english alphabet)
#
# @param {String} ransom_note
# @param {String} magazine
# @return {Boolean}
def can_construct(ransom_note, magazine)
  # easy out
  return false if magazine.length < ransom_note.length

  available = {}

  magazine.each_char do |c|
    available[c] = available[c] ? available[c] += 1 : 1
  end

  ransom_note.each_char do |c|
    return false if !available[c]
    return false if available[c] == 0
    available[c] -= 1
  end

  true
end

# shockingly, the runtime is garbage (Beats 21.70% of users with Ruby)
# but the memory isn't too bad (Beats 81.13% of users with Ruby)
# checking the leetcode editorial, this isn't the worst solution LMAO
# idek what they were doing with solution 1, solution 2 is less efficient
# with 2 hashmaps, and solution 3 is basically what we have here
# they have a solution 4 with sorting and stacks which > sol 1 but worse
# than what we have here

# solution 4 gist: turn each string into an array and sort the letters
# in the same way for each, and then turn them into a stack. Then we can
# compare the letters in each and pop off, and if there's something in
# the ransom note stack that's not in the magazine stack then game over
