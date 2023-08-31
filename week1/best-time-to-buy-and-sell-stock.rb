# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
# [Easy]
#
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  # easy out
  return 0 if prices.length < 2

  max = 0
  buy = prices.first

  # could iterate without the first element but trivial here
  prices.map do |p|
    buy = [buy, p].min
    max = [p - buy, max].max
  end

  max
end
