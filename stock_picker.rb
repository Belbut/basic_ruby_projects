def stock_picker(stock_quotes)
  possible_results = stock_quotes.each_with_index.each_with_object({}) do |(buy_price, buy_day), acumulator|
    stock_quotes[buy_day..].each_with_index do |sell_price, sell_day|
      profit = sell_price - buy_price
      break if profit.negative?

      acumulator[profit] = [buy_day, buy_day + sell_day] if acumulator[profit].nil?
    end
  end
  max_profit = possible_results.keys.max
  possible_results[max_profit]
end

test1 = [1, 4]
test2 = [1, 6]
test3 = [0, 1]
puts '-------------test1--------------'
p test1
p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
puts '-------------test2--------------'
p test2
p stock_picker([17, 3, 6, 9, 15, 8, 60, 1])
puts '-------------test3--------------'
p test3
p stock_picker([1, 2, 1, 2, 1])
