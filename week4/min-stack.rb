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
