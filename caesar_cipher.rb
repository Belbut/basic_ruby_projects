def caesar_cipher(message, shift_factor = 0)
  message_splited_code = message.codepoints
  cipher_splited_code = message_splited_code.map do |code|
    changed_code = code + shift_factor
    case code
    when (65..90)  # a->z
      alphabetic_rebase(changed_code, 65, 90)
    when (97..122) # A->Z
      alphabetic_rebase(changed_code, 97, 122)
    else
      code
    end
  end

  puts cipher_splited_code.map(&:chr).join
end

NUMBER_OF_LETTERS_IN_ALPHABET = 26
def alphabetic_rebase(changed_code, lowest_code, _highest_code)
  changed_code -= lowest_code
  letter_of_alph = changed_code % NUMBER_OF_LETTERS_IN_ALPHABET
  letter_of_alph + lowest_code
end

puts 'Bmfy f xywnsl!'
caesar_cipher('What a string!', 5)
a = 'a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z'
puts a
caesar_cipher(a, 1)
