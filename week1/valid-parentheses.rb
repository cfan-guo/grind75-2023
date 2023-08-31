# https://leetcode.com/problems/valid-parentheses/
# [Easy]
#
# Possibly one of the easiest questions except I forgot how Ruby hashes work?? 
# Anyways, leetcode freaks out when I tried doing something like `checker = {']': '['}` 
# unless I referenced it as `checker[c.to_sym]`... anyways in that case it was neater
# to use the hashrocket
# 
# Previously solved with JS
#
# @param {String} s
# @return {Boolean}
def is_valid(s)
  stack = []
  checker = {
    "}" => "{",
    "]" => "[",
    ")" => "(",
  }
  
  s.each_char do |c|
    return false if (stack.empty? and checker[c])
    return false if (checker[c] && stack.last != checker[c])
    if !checker[c]
      stack << c
    else
      stack.pop
    end
  end
  return true if stack.empty?
  false
end
