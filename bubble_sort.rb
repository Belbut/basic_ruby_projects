def bubble_sort(array)
  new_array = array.clone
  (array.size - 1).times do |i|
    new_array = sort_two_elements(new_array, i)
  end

  # print "step:"; p new_array; #uncoment this if you want to check the intermedit steps
  if array != new_array
    bubble_sort(new_array)
  else
    new_array
  end
end

def sort_two_elements(array, index_to_check)
  first = array[index_to_check]
  second = array[index_to_check + 1]

  if first > second
    array[index_to_check] = second
    array[index_to_check + 1] = first
  end
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
