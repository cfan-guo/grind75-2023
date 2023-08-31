# https://leetcode.com/problems/first-bad-version/
# [Easy]
#
# This is just a binary search with pizzazz imo
# which is good because even though I just re-implemented binary search
# I already forgot how I did it, oops
#
# If checking a version "v" and it's bad, then that's the new upper limit
# to check (since we're looking for the *first* bad version). If it's good,
# then it's the new lower limit. The first bad version is found when we find
# a good right before a bad.
# The most annoying thing is 1. 1-indexed and 2. checking bounds. Also looking
# at the solution now, n can be very big so you gotta calculate the middle
# with "(right - left) / 2 + left", which is totally why I did it that way and
# not bc I realized that "(right + left) / 2" also gets the middle lol
#
# The is_bad_version API is already defined for you.
# @param {Integer} version
# @return {boolean} whether the version is bad
# def is_bad_version(version):
#
# @param {Integer} n
# @return {Integer}
def first_bad_version(n)
  # easy out
  return n if n < 2

  right = n
  left = 1

  while left < right
    middle = (right - left) / 2 + left

    if is_bad_version(middle)
      return middle if !is_bad_version(middle - 1)
      right = middle
    else
      return middle + 1 if is_bad_version(middle + 1)
      left = middle
    end
  end
end

# cleaner version with slightly fewer checks
# since we can induce that if left and right meet up, then
# everything left of left (lol) is good, meaning left is the
# first bad
def first_bad_version_2(n)
  # easy out
  return n if n < 2

  left = 1
  right = n

  while left < right
    middle = (right - left) / 2 + left

    if is_bad_version(middle)
      right = middle
    else
      left = middle + 1
    end
  end

  left
end
