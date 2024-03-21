def substrings(str, dictionary); end

test1 = { 'below' => 1, 'low' => 1 }
test2 = { 'down' => 1, 'go' => 1, 'going' => 1, 'how' => 2, 'howdy' => 1, 'it' => 2, 'i' => 3, 'own' => 1, 'part' => 1,
          'partner' => 1, 'sit' => 1 }
dictionary = %w[below down go going horn how howdy it i low own part partner sit]

puts '-------------test2--------------'
puts test1
puts substrings('below', dictionary)
puts '-------------test2--------------'
puts test2
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
