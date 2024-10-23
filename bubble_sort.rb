# frozen_string_literal: true

def bubble_sort(array)
  new_array = array.clone
  (array.size - 1).times do |i|
    new_array = sort_two_elements(new_array, i)
  end

  # print "step:"; p new_array; #uncomment this if you want to check the intermediate steps
  if array == new_array
    new_array
  else
    bubble_sort(new_array)
  end
end

def sort_two_elements(array, first_e)
  array[first_e], array[first_e + 1] = array[first_e + 1], array[first_e] if array[first_e] > array[first_e + 1]
  array
end

puts '-------------test1--------------'
test1 = [4, 3, 78, 2, 0, 2]
p test1.sort
p bubble_sort(test1)
puts '-------------test2--------------'
test2 = [9, 8, 7, 6, 5, 4, 3, 2, 1]
p test2.sort
p bubble_sort(test2)
