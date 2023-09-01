# https://leetcode.com/problems/longest-palindrome/
# [Easy]
#
# So my initial thought for this is to store the count for each character
# and all the even number counts can get added to the longest palindrome
# along with the even parts of the odd number count, adding 1 at the end
# if there were any odd counts
# But is the best way to do that to hash the values and then iterate thru the hash?
#
# @param {String} s
# @return {Integer}
def longest_palindrome(s)
  # easy out
  return 1 if s.length < 2

  # hash the chars and count
  counts = {}
  s.each_char do |c|
    counts[c] = counts[c] ? counts[c] + 1 : 1
  end

  # add it up
  longest, odd = 0, false

  counts.each do |k, v|
    if (v % 2).zero?
      longest += v
    else
      longest += v - 1
      odd = true
    end
  end

  odd ? longest + 1 : longest
end

# alright after reading thru the leetcode answer and comments
# i have just concluded everyone else is dumb and overthinking
