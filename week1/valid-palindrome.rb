# https://leetcode.com/problems/valid-palindrome/
# [Easy]
#
# This is the lazy bum version which uses a bunch of built-in
# functions, namely the gsub, downcase, split etc
#
# In the JS folder I have a bunch of other ways of solving them,
# one of which doesn't rely on any additional space (here we transform the
# string into an array), or the other option which is doing the strip and
# reversing the string to compare the two
#
# Granted, the ruby one's runtime was still better than all my JS solutions but
# the memory is monstrous (according to leetcode submissions)
#
# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  alphanumeric = s.gsub(/[^0-9a-z]/i, '').downcase.split('')
  len = alphanumeric.length
  return true if !alphanumeric.length

  for i in (0..(len/2)) do
    return false if alphanumeric[i] != alphanumeric[len-i-1]
  end
  true
end

# alright here is the keener solution since it's disgusting and it's good practice
# in case some interviewer throws the "oh but what if we took away your built-ins"
# anyways gfl remembering the stupid charcodes (ruby uses .ord)

# LMFAO this got a worse runtime and the memory savings are negligible. Still good practice...

# @param {String} s
# @return {Boolean}
def is_palindrome_2(s)
  return true if s == ""

  # number charcodes are [48, 57] (0 - 9)
  # uppercase charcodes are [65, 90] (A - Z)
  num_range = (48..57)
  alpha_range = (65..90)

  left = 0
  right = s.length - 1

  while (left < right)
    while (!(alpha_range === (s[left]).upcase.ord) &&
      !(num_range === (s[left]).upcase.ord) &&
      left < right)
      left+=1
    end

    while (!(alpha_range === (s[right]).upcase.ord) &&
      !(num_range === (s[right]).upcase.ord) &&
      right > left)
      right-=1
    end

    return false if s[left].upcase != s[right].upcase
    left+=1
    right-=1
  end

  true
end
