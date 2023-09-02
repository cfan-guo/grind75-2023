# https://leetcode.com/problems/add-binary/
# [Easy]
#
# Couple of things to keep in mind here - if iterating, we need
# to do one check more than the length of the longest of the two
# so we can account for any carryover (if it's 0 then we can discard)
# since we don't want leading 0s.
#
# Also, we need to add from end i.e. the smallest bit, which means
# we need to check from the end of each string, and pad the shorter
# string with leading 0s for comparisons.
#
# As for the actual adding, just have a carry bit, knowing that if
# there are at least 2 "1"s then we need to carry over, and the digit
# for that place is "0" if there's an odd number of "1"s else "0"
#
# @param {String} a
# @param {String} b
# @return {String}
def add_binary(a, b)
  # easy out
  return "0" if [a, b] == %w(0 0)

  sum, carry = "", "0"
  a_len, b_len = a.length, b.length
  count = [a_len, b_len].max

  # gotta iterate from the back of the string
  (0..count - 1).each do |i|
    # if we're more than the length of the string then
    # replace with leading 0
    a_digit = i < a_len ? a[a_len - i - 1] : "0"
    b_digit = i < b_len ? b[b_len - i - 1] : "0"

    sum_digit, carry = add(a_digit, b_digit, carry)

    sum.prepend(sum_digit)
  end

  # after iterating thru the length of the longer of the two
  # we might still have a carry which we only prepend if it's 1
  # bc we don't want to keep leading 0s
  sum.prepend(carry) if carry == "1"
  sum
end

def add(a, b, c)
  # we only care about the number and parity of 0s and 1s
  recurrences = [a, b, c].tally

  # if there are at least 2 "1"s, then we need a carry-over
  new_carry = !recurrences["1"].nil? && recurrences["1"] > 1 ? "1" : "0"

  # if there are an even number of "1"s then it's 0, if it's odd then it's 1
  sum = !recurrences["1"].nil? ? (recurrences["1"] % 2).to_s : "0"

  return [sum, new_carry]
end

# oh my god i'm an idiot i forgot i could've just used XOR for the digit
# and AND with left shift for the carry instead of those disgusting ternaries
# Anyways this is a leetcode solution for no adding allowed... except i didn't
# technically add in the previous one lol
# @param {String} a
# @param {String} b
# @return {String}
def add_binary_2(a, b)
  x, y = a.to_i(2), b.to_i(2)

  # continuously "add" until the carry value is 0
  while !y.zero?
    # use XOR to get digit
    current_sum = x ^ y

    # use AND with left shift to get carry
    current_carry = (x & y) << 1

    # do this but now "add" the carry
    x, y = current_sum, current_carry
  end

  # return as binary string
  x.to_s(2)
end
