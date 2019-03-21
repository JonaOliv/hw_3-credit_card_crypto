# frozen_string_literal: true

## Added unshuffle method to array class
class Array
  def unshuffle(random:)
    returning = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| returning[i] }
  end
end

## DoubleTranspositionCipher have cryptography methods of transposition cipher.
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    a_letters = handle_text_double_transposition_cipher(document)

    key = handle_key_double_transposition_cipher(key)

    # https://stackoverflow.com/questions/23047911/how-to-shuffle-an-array-the-same-way-every-time
    # https://stackoverflow.com/questions/29522377/reverse-an-array-shufflerandom-to-get-the-original/29524063

    a_letters.shuffle!(random: Random.new(key))

    a_letters.map! { |e| e.shuffle!(random: Random.new(key)) }

    a_letters.map! { |i| i.reduce { |n1, n2| n1 + n2 } }
    a_letters.reduce { |n1, n2| n1 + n2 }
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    a_letters = handle_text_double_transposition_cipher(ciphertext)

    key = handle_key_double_transposition_cipher(key)

    a_letters.map! { |e| e.unshuffle(random: Random.new(key)) }
    a_letters = a_letters.unshuffle(random: Random.new(key))

    a_letters.map! { |i| i.reduce { |n1, n2| n1 + n2 } }
    result = a_letters.reduce { |n1, n2| n1 + n2 }
    result.rstrip
  end

  def self.handle_key_double_transposition_cipher(key)
    a_key = key.to_s.chars.map(&:to_i)
    i_key = a_key.reduce { |n1, n2| n1.to_s + n2.to_s }
    i_key = i_key.to_i
    i_key
  end

  def self.handle_text_double_transposition_cipher(document)
    a_letters = document.to_s.chars

    size = search_size(a_letters.length)

    a_letters = a_letters.each_slice(size).to_a

    if (size * size) > a_letters.length
      a_letters.map! { |e| e.fill(' ', e.length, size - e.length) }
    end

    a_letters
  end

  def self.search_size(length, original = 1)
    size = original

    size = search_size(length, original + 1) if original * original < length

    size
  end

  def self.unshuffle(array, random:)
    a_transformed = array.to_a.shuffle!(random: random)
    array.sort_by.with_index { |_, i| a_transformed[i] }
    array
  end
end
