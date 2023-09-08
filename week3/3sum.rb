# https://leetcode.com/problems/3sum/
# [Medium]
#
# Yeah you COULD do a triple nested loop for a cool O(n^3) time comp,
# or you could throw in a hashmap somewhere along the way, or sort it
# and do something similar to the 167. Two Sum II (nongrind) with two
# pointers. Since we're dealing with 3 numbers at a time now, either
# way we slice it we're looking at O(n^2) time complexity. There's
# probably also a few ways of doing this
#
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  # easy out - only one triplet
  if nums.length < 4
    return nums.sum.zero? ? [nums] : []
  end

  sorted = nums.sort
  triplets = []

  sorted.each_with_index do |s, i|
    # skip duplicates
    next if i > 0 && s == sorted[i - 1]

    left, right = i + 1, sorted.length - 1

    while left < right
      # skip duplicates on the left
      if (left > i + 1 && sorted[left] == sorted[left - 1])
        left += 1
        next
      end

      # skip duplicates on the right
      if (right < sorted.length - 1 && sorted[right] == sorted[right + 1])
        right -= 1
        next
      end

      # rehash of 167. Two Sum II except we add to the triplets array
      if (sorted[left] + sorted[right] + s).zero?
        triplets << [s, sorted[left], sorted[right]]
        left += 1
        right -= 1
      elsif sorted[left] + sorted[right] + s > 0
        right -= 1
      else
        left += 1
      end
    end
  end

  triplets
end

# wow the runtime on that aws BRUTAL lmfao somehow it took 1415ms and
# 214.2MB of space... meanwhile my JS solution from 2020 was 136ms
# and 47.5MB. The time complexity of this is technically still O(n^2)
# since it's O(n^2) for the loops and O(nlogn) for sort at the start.
# As for space, even if we use another array for storing the sorted
# one, that's just O(n) of space... looking at it again now, the JS
# soln I did is exactly the same, maybe a lil different order fml
#
# Looks like changing the order does save some time, also I realized
# I repeated some calcs instead of storing them. Main diff is instead
# of using "ifs" and next in the while loop, and skipping subsequent
# dupes, we replace it with while loops and skip dupes first, and
# only calculate when we're on the last one (this is fine bc sorted).
# For some reason I don't get the right answer unless I stick those
# new "whiles" in the zero case... leaving them in the same spot
# doesn't work without additional tweaks I'm too sleep to do. 815ms.
# Same shitty space tho...
#
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum_2(nums)
  # easy out - only one triplet
  if nums.length < 4
    return nums.sum.zero? ? [nums] : []
  end

  sorted = nums.sort
  triplets = []

  sorted.each_with_index do |s, i|
    # skip duplicates
    next if i > 0 && s == sorted[i - 1]

    left, right = i + 1, sorted.length - 1

    while left < right
      # assign here rather than recalculating for each conditional
      a = sorted[left]
      b = sorted[right]
      sum = a + b + s

      # 167. Two Sum II except we add to triplets + skip dupes
      if sum.zero?
        triplets << [s, sorted[left], sorted[right]]
        # skip duplicates on the left
        while (left < right && sorted[left] == sorted[left + 1])
          left += 1
        end
        # skip duplicates on the right
        while (left < right && sorted[right] == sorted[right - 1])
          right -= 1
        end
        left += 1
        right -= 1
      elsif sum > 0
        right -= 1
      else
        left += 1
      end
    end
  end

  triplets
end

# Lastly, there should be a way to do it similar with a hashmap like
# OG twosum, but that feels painful......... leaving it for later
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum_3(nums)
  # TODO: OG twosum way
  # sort array to easily deal with duplicates
end

# And what if the interviewer hates us and wants us to suffer with no
# sorting to skip dupes? Here's anotha one (at least according to LC)
#
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum_4(nums)
  # TODO: OG twosum way
  # no sorting allowed, probably just need to have hash of hashes
end
