# https://leetcode.com/problems/valid-anagram/
# [Easy]
#
# The cheeky way to do this is to sort the characters and check lol
#
# @param {String} s
# @param {String} t
# @return {Boolean}
def is_anagram(s, t)
  return true if s == t
  return false if s.length != t.length

  s.split("").sort === t.split("").sort
end

# alas, we probably want to do some actual algorithms
# so we just count the characters and compare
def is_anagram_2(s, t)
  return true if s == t
  return false if s.length != t.length

  s_h = {}
  t_h = {}

  s.each_char do |c|
    s_h[c] = s_h[c] ? s_h[c] + 1 : 1
  end

  t.each_char do |c|
    t_h[c] = t_h[c] ? t_h[c] + 1 : 1
  end

  s_h == t_h
end

# yet another option (for those languages where objects are not equal
# cough JS cough), you can use a single counter and then inc/dec and check
# A) or populate with first string and check for nonexistence with second string
# B) you can populate it with the entire alphabet set to 0, and check for negative
def is_anagram_3a(s, t)
  return true if s == t
  return false if s.length != t.length

  counter = {}

  s.each_char do |c|
    counter[c] = counter[c] ? counter[c] + 1 : 1
  end

  t.each_char do |c|
    return false if !counter[c] || counter[c] == 0
    counter[c] -= 1
  end

  true
end

def is_anagram_3b(s, t)
  return true if s == t
  return false if s.length != t.length

  counter = ("a".."z").each_with_object({}) { |letter, hash| hash[letter] = 0 }

  s.each_char do |c|
    counter[c] += 1
  end

  t.each_char do |c|
    return false if counter[c] == 0
    counter[c] -= 1
  end

  true
end
