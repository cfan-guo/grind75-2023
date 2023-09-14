# https://leetcode.com/problems/min-stack/
# [Medium]
#
# All ops have to be O(1) time but there's nothing on space so we're
# gonna just gonna track both the actual stack and a stack with just
# the min vals.
#
# Just tracking the most recent min val won't work bc what if you pop
# off the min val? Who's the min val now?
#
#
class MinStack
  def initialize()
    @stack = []
    @min_history = []
  end


=begin
    :type val: Integer
    :rtype: Void
=end
  def push(val)
    @stack << val
    @min_history << val if @min_history.empty? || val <= @min_history.last
  end


=begin
    :rtype: Void
=end
  def pop()
    @min_history.pop if @min_history.last == @stack.pop
  end


=begin
    :rtype: Integer
=end
  def top()
    @stack.last
  end

=begin
    :rtype: Integer
=end
  def get_min()
    @min_history.last
  end
end

# Your MinStack object will be instantiated and called as such:
# obj = MinStack.new()
# obj.push(val)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.get_min()

# Me again, so there's a few different ways of doing this. Once of
# them is what I did, another one is to track the current min with
# each value that's pushed onto the stack
# e.g. for values [3, 2, 1, 5, 6, 0] that get pushed, we'd store
# [[3, 3], [2, 2], [1, 1], [5, 1], [6, 1], [0, 0]] i.e. [val, min].
#
# Downside to this and the one I implemented is that if we added the
# same min value multiple times, there's a lot of repetition and
# wasted space.
#
# So alternatively, we could adapt what I already had and instead of
# continuously pushing the same min value if it occurs, we track two
# values in the min_history stack, which is the min value and how
# many times it's appeared, and when we pop, we compare both the min
# value and its occurrences before removing it from the min_his stack
# e.g. for [1, 2, 3, 1, 1, 0, 2, 0], we'd have
# stack: [1, 2, 3, 1, 1, 0, 2, 0]
# min_history: [[1, 3], [0,2]] instead of [1, 1, 1, 0, 0]
