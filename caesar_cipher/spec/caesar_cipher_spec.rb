# frozen_string_literal: true

require_relative '../lib/caesar_cipher'

EXPECTED_SYMBOLS = [',', '!', '?', '.', ':', ';', "'", '"',
                    '-', '_', '=', '+', '(', ')', '[', ']',
                    '{', '}', '<', '>', '/', '\\', '|',
                    '@', '#', '$', '%', '^', '&', '*',
                    '~', '`'].map(&:ord)
ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze
ALPHABET_UPCASE = ALPHABET.map(&:upcase)
ALPHABET_LOWCASE = ALPHABET

describe CaesarCipher do
  context '#caesar_cipher' do
    context 'correctly ciphers' do
      context 'the alphabet ' do
        let(:alphabet_upcase) { ALPHABET_UPCASE.join }
        subject(:upcase_cipher) { described_class.new(alphabet_upcase) }
        it 'with uppercase' do
          expected_result = 'BCDEFGHIJKLMNOPQRSTUVWXYZA'
          expect(upcase_cipher.caesar_cipher).to eq expected_result
        end

        let(:alphabet_lowcase) { ALPHABET_LOWCASE.join }
        subject(:lowcase_cipher) { described_class.new(alphabet_lowcase) }
        it 'with lowercase' do
          expected_result = 'bcdefghijklmnopqrstuvwxyza'
          expect(lowcase_cipher.caesar_cipher).to eq expected_result
        end

        let(:alphabet_multicase) { [ALPHABET_UPCASE, ALPHABET_LOWCASE].join }
        subject(:multicase_cipher) { described_class.new(alphabet_multicase) }
        it 'multicase' do
          expected_result = 'BCDEFGHIJKLMNOPQRSTUVWXYZAbcdefghijklmnopqrstuvwxyza'
          expect(multicase_cipher.caesar_cipher).to eq expected_result
        end
      end

      context 'with a shift that is' do
        let(:basic_msg) { 'ABCD' }

        context 'small' do
          subject(:small_shift_right) { described_class.new(basic_msg, 2) }
          it 'to the right' do
            expected_result = 'CDEF'
            expect(small_shift_right.caesar_cipher).to eq(expected_result)
          end

          subject(:small_shift_left) { described_class.new(basic_msg, -2) }
          it 'to the left' do
            expected_result = 'YZAB'
            expect(small_shift_left.caesar_cipher).to eq(expected_result)
          end
        end

        context 'big' do
          # shifting 28/-28 is the same as shifting 2/-2 because alphabet wraps every 26 letters
          subject(:big_shift_right) { described_class.new(basic_msg, 28) }
          it 'to the right' do
            expected_result = 'CDEF'
            expect(big_shift_right.caesar_cipher).to eq(expected_result)
          end

          subject(:big_shift_left) { described_class.new(basic_msg, -28) }
          it 'to the left' do
            expected_result = 'YZAB'
            expect(big_shift_left.caesar_cipher).to eq(expected_result)
          end
        end
      end

      context 'a phrase' do
        subject(:space_cipher) { described_class.new(msg_spaces, 5) }
        let(:msg_spaces) do
          "My mom loved Valium and lots of drugs Thats why I am like I am cause I'm like her"
        end
        it 'with spaces' do
          expected_result = "Rd rtr qtaji Afqnzr fsi qtyx tk iwzlx Ymfyx bmd N fr qnpj N fr hfzxj N'r qnpj mjw"
          expect(space_cipher.caesar_cipher).to eq(expected_result)
        end

        subject(:pontuation_cipher) { described_class.new(msg_pontuation, 5) }
        let(:msg_pontuation) do
          'Hi, kids! Do you like violence? (Yeah yeah yeah) Wanna see me stick nine inch nails through each one of my eyelids? (A-ha)'
        end

        it 'with pontuation' do
          expected_result = 'Mn, pnix! It dtz qnpj antqjshj? (Djfm djfm djfm) Bfssf xjj rj xynhp snsj nshm sfnqx ymwtzlm jfhm tsj tk rd jdjqnix? (F-mf)'
          expect(pontuation_cipher.caesar_cipher).to eq(expected_result)
        end
      end
    end
  end

  context '::dec_msg_to_cipher' do
    context 'when the char is' do
      let(:random_shift) { rand(42) }
      context 'from the alphabet' do
        context 'and is upcase' do
          let(:initial_upcase_char_code) { ALPHABET_UPCASE.sample.ord }

          it 'it is seen has a uppercase letter' do
            expect(initial_upcase_char_code).to be_between(65, 90)
            described_class.dec_msg_to_cipher(initial_upcase_char_code, random_shift)
          end

          it 'it is handled has a uppercase letter' do
            expect(described_class).to receive(:upcase_rebase).with(initial_upcase_char_code + random_shift).once
            described_class.dec_msg_to_cipher(initial_upcase_char_code, random_shift)
          end
        end

        context 'and is lowcase' do
          let(:initial_lowcase_char_code) { ALPHABET_LOWCASE.sample.ord }

          it 'it is seen has a uppercase letter' do
            expect(initial_lowcase_char_code).to be_between(97, 122)
            described_class.dec_msg_to_cipher(initial_lowcase_char_code, random_shift)
          end

          it 'it is handled has a uppercase letter' do
            expect(described_class).to receive(:lowcase_rebase).with(initial_lowcase_char_code + random_shift).once
            described_class.dec_msg_to_cipher(initial_lowcase_char_code, random_shift)
          end
        end
      end

      context 'a symbol' do
        let(:initial_random_symbol) { EXPECTED_SYMBOLS.sample }
        it 'it is seen and handled has a symbol' do
          result_from_random_symbol = described_class.dec_msg_to_cipher(initial_random_symbol, random_shift)
          expect(result_from_random_symbol).to be initial_random_symbol
        end
      end
    end
  end

  context '::upcase_rebase' do
    let(:random_number_to_wrap) { rand(described_class::UPPERCASE_FIRST_LETTER..4200) }
    it 'forwards the correct message' do
      expect(described_class).to receive(:alphabetic_wrap).with(random_number_to_wrap,
                                                                described_class::UPPERCASE_FIRST_LETTER)
      described_class.upcase_rebase(random_number_to_wrap)
    end
  end

  context '::upcase_rebase' do
    let(:random_number_to_wrap) { rand(described_class::LOWERCASE_FIRST_LETTER..4200) }
    it 'forwards the correct message' do
      expect(described_class).to receive(:alphabetic_wrap).with(random_number_to_wrap,
                                                                described_class::LOWERCASE_FIRST_LETTER)
      described_class.lowcase_rebase(random_number_to_wrap)
    end
  end

  context '::alphabetic_wrap' do
    let(:possible_output_start) { 1 }
    let(:first_number) { 1 }
    let(:random_number) { rand(first_number..last_number) }
    let(:last_number) { described_class::NUMBER_OF_LETTERS_IN_ALPHABET }

    context 'when there is no need to wrap' do
      context 'should return the same has input' do
        it 'first number of range' do
          expect(described_class.alphabetic_wrap(first_number, possible_output_start)).to be first_number
        end

        it 'random number of range' do
          expect(described_class.alphabetic_wrap(random_number, possible_output_start)).to be random_number
        end

        it 'last number of alphabet' do
          expect(described_class.alphabetic_wrap(last_number, possible_output_start)).to be last_number
        end
      end
    end

    context 'when values need to wrap' do
      let(:range_to_wrap) { described_class::NUMBER_OF_LETTERS_IN_ALPHABET }

      context 'when the wrap is in the positive direction' do
        it 'wrapping once' do
          input_number_to_test = random_number + range_to_wrap
          expect(described_class.alphabetic_wrap(input_number_to_test, possible_output_start)).to be random_number
        end

        it 'wrapping multiple times' do
          input_number_to_test = random_number + (range_to_wrap * rand(42))
          expect(described_class.alphabetic_wrap(input_number_to_test, possible_output_start)).to be random_number
        end
      end

      context 'when the wrap is in the negative direction' do
        it 'negative wrap once' do
          input_number_to_test = random_number - range_to_wrap
          expect(described_class.alphabetic_wrap(input_number_to_test, possible_output_start)).to be random_number
        end

        it 'negative wrap multiple times' do
          input_number_to_test = random_number - (range_to_wrap * rand(42))
          expect(described_class.alphabetic_wrap(input_number_to_test, possible_output_start)).to be random_number
        end
      end
    end
  end
end
