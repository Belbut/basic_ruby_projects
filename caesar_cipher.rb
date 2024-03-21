NUMBER_OF_LETTERS_IN_ALPHABET = 26
RANGE_UPPERCASE_LETTERS = (97..122).freeze
RANGE_LOWERCASE_LETTERS = (65..90).freeze
UPPERCASE_FIRST_LETTER = 97
LOWERCASE_FIRST_LETTER = 65

def alphabetic_wrap(char_decimal_shifted, case_constant)
  # rebases upcase and lowcase to the same axis
  char_decimal_shifted -= case_constant
  # removes the number of wraps because of the shift
  cipher_char = char_decimal_shifted % NUMBER_OF_LETTERS_IN_ALPHABET
  # returns the chars to the same up/low case axis
  cipher_char + case_constant
end

def dec_mess_to_cipher(chr_code, shift_factor)
  cript_chr_code = chr_code + shift_factor

  case chr_code
  when RANGE_UPPERCASE_LETTERS
    upcase_rebase(cript_chr_code)
  when RANGE_LOWERCASE_LETTERS
    lowcase_rebase(cript_chr_code)
  else
    chr_code
  end
end

def upcase_rebase(cript_chr_code)
  alphabetic_wrap(cript_chr_code, UPPERCASE_FIRST_LETTER)
end

def lowcase_rebase(cript_chr_code)
  alphabetic_wrap(cript_chr_code, LOWERCASE_FIRST_LETTER)
end

def caesar_cipher(message, shift_factor = 0)
  splited_dec_message = message.codepoints

  splited_dec_cipher = splited_dec_message.map { |code| dec_mess_to_cipher(code, shift_factor) }

  puts splited_dec_cipher.map(&:chr).join
end

puts 'Bmfy f xywnsl!'
caesar_cipher('What a string!', 5)
a = 'a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z'
puts a
caesar_cipher(a, 1)
