# frozen_string_literal: true

class CaesarCipher
  NUMBER_OF_LETTERS_IN_ALPHABET = 26
  RANGE_UPPERCASE_LETTERS = (65..90).freeze
  RANGE_LOWERCASE_LETTERS = (97..122).freeze
  UPPERCASE_FIRST_LETTER = 65
  LOWERCASE_FIRST_LETTER = 97

  def initialize(message, shift_factor = 1)
    @message = message
    @shift_factor = shift_factor
  end

  def caesar_cipher
    splitted_dec_message = @message.codepoints

    splinted_dec_cipher = splitted_dec_message.map { |code| CaesarCipher.dec_msg_to_cipher(code, @shift_factor) }

    splinted_dec_cipher.map(&:chr).join
  end

  def self.upcase_rebase(number_to_wrap)
    alphabetic_wrap(number_to_wrap, UPPERCASE_FIRST_LETTER)
  end

  def self.lowcase_rebase(number_to_wrap)
    alphabetic_wrap(number_to_wrap, LOWERCASE_FIRST_LETTER)
  end

  def self.dec_msg_to_cipher(chr_code, shift_factor)
    cipher_chr_code = chr_code + shift_factor

    case chr_code
    when RANGE_UPPERCASE_LETTERS
      upcase_rebase(cipher_chr_code)
    when RANGE_LOWERCASE_LETTERS
      lowcase_rebase(cipher_chr_code)
    else
      chr_code
    end
  end

  def self.alphabetic_wrap(input_number, wrap_on_number)
    # rebases upcase and lowcase to the same axis of alphabet eg a/A = 0 b/B=1
    input_number -= wrap_on_number
    # removes the number of wraps because of the shift
    alphabet_letter_dec_code = input_number % NUMBER_OF_LETTERS_IN_ALPHABET
    # returns the chars to the same up/low case axis
    alphabet_letter_dec_code + wrap_on_number
  end
end
# puts 'Bmfy f xywnsl!'
# caesar_cipher('What a string!', 5)
# a = 'a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z'
# puts a
# caesar_cipher(a, 1)
