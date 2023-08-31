# https://leetcode.com/problems/implement-queue-using-stacks/
# [Easy]
#
# Damn that's a lot of starter code ugh I hate reading
# If I remember correctly, the way to do a Q with two stacks
# is to have one that just hangs out and stores stuff, and the
# other one only kicks into action when it needs to pop or peek
#
# Pop and peek means looking at the first element in the Q,
# which is sitting squarely in the bottom of the first stack.
# We can access it by popping all the elements into the second
# stack, looking or popping that value (which is now at the top)
# of the second stack, before popping it back to the first stack
#
class MyQueue
  def initialize()
    @stack1 = []
    @stack2 = []
  end


=begin
  :type x: Integer
  :rtype: Void
=end
  def push(x)
    @stack1 << x
  end


=begin
  :rtype: Integer
=end
  def pop()
    move_between(@stack1, @stack2)
    val = @stack2.pop
    move_between(@stack2, @stack1)
    return val
  end


=begin
  :rtype: Integer
=end
  def peek()
    # pop it from stack1 to stack2
    # check what's at the top
    # pop it back from stack2 to stack1
    move_between(@stack1, @stack2)
    val = @stack2.last
    move_between(@stack2, @stack1)
    return val
  end


=begin
  :rtype: Boolean
=end
  def empty()
    @stack1.empty?
  end

  private
  def move_between(source, sink)
    while !source.empty?
      sink << source.pop
    end
  end

end

# Your MyQueue object will be instantiated and called as such:
# obj = MyQueue.new()
# obj.push(x)
# param_2 = obj.pop()
# param_3 = obj.peek()
# param_4 = obj.empty()
