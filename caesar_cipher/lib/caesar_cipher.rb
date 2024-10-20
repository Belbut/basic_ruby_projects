# frozen_string_literal: true

class CaesarCipher
  def initialize(message, shift_factor = 0)
    @message = message
    @shift_factor = shift_factor
  end

  def upcase_rebase(cipher_chr_code)
    alphabetic_wrap(cipher_chr_code, UPPERCASE_FIRST_LETTER)
  end

  def lowcase_rebase(cipher_chr_code)
    alphabetic_wrap(cipher_chr_code, LOWERCASE_FIRST_LETTER)
  end

  def dec_msg_to_cipher(chr_code, shift_factor)
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

  def caesar_cipher
    splitted_dec_message = @message.codepoints

    splinted_dec_cipher = splitted_dec_message.map { |code| dec_msg_to_cipher(code, @shift_factor) }

    cipher = splinted_dec_cipher.map(&:chr).join

    puts cipher
  end

  private

  def alphabetic_wrap(char_dec_shifted, first_letter_up_low_case_code)
    # rebases upcase and lowcase to the same axis of alphabet eg a/A = 0 b/B=1
    char_dec_shifted -= first_letter_up_low_case_code
    # removes the number of wraps because of the shift
    alphabet_letter_dec_code = char_dec_shifted % NUMBER_OF_LETTERS_IN_ALPHABET
    # returns the chars to the same up/low case axis
    alphabet_letter_dec_code + first_letter_up_low_case_code
  end

  NUMBER_OF_LETTERS_IN_ALPHABET = 26
  RANGE_UPPERCASE_LETTERS = (97..122).freeze
  RANGE_LOWERCASE_LETTERS = (65..90).freeze
  UPPERCASE_FIRST_LETTER = 97
  LOWERCASE_FIRST_LETTER = 65
end
# puts 'Bmfy f xywnsl!'
# caesar_cipher('What a string!', 5)
# a = 'a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z'
# puts a
# caesar_cipher(a, 1)
