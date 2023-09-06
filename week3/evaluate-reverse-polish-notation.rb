# https://leetcode.com/problems/evaluate-reverse-polish-notation/
# [Medium]
#
# Had to check wikipedia for this but apparently it's just a thing
# that can be solved by pushing stuff onto a stack, thank god
#
# If we encounter a number, we push it onto the stack. If we get an
# operand, we pop off the last two numbers on the stack and run the
# operation of those two numbers, pushing the result back on. There
# are a few pitfalls like "negative number strings" but we have it
# handled here by either checking the length or if the ascii rep of
# the token is in our ascii values for 0 - 9. Since operands are only
# ever one-char long, this works yay
#
# @param {String[]} tokens
# @return {Integer}
def eval_rpn(tokens)
  # easy out
  return tokens.first.to_i if tokens.length < 2

  stack = []
  numbers = (48..57) # ascii values

  tokens.each do |t|
    if t.length > 1 || numbers === t.ord
      stack << t.to_i
    else
      b = stack.pop
      a = stack.pop

      stack << evaluate(a, b, t)
    end
  end

  stack.last
end

# for ruby and python, division with -ve integers floor it instead
# of "truncate toward zero" as required for the question, so we must
# check if only one of the values is negative. Thank u XOR!
def evaluate(a, b, operation)
  case operation
  when "+"
    a + b
  when "-"
    a - b
  when "*"
    a * b
  when "/"
    if (a < 0) ^ (b < 0)
      a.abs / b.abs * -1
    else
      a / b
    end
  end
end
