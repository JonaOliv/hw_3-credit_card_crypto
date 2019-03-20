# frozen_string_literal: true

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
    # a_letters = document.to_s.chars
    # size = search_size(a_letters.length / 2, a_letters.length)
    # a_letters = a_letters.each_slice(size).to_a
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

    a_letters = unshuffle(a_letters, random: Random.new(key))
    a_letters.map! { |e| unshuffle(e, random: Random.new(key)) }

    a_letters.map! { |i| i.reduce { |n1, n2| n1 + n2 } }
    a_letters.reduce { |n1, n2| n1 + n2 }
  end

  def self.handle_key_double_transposition_cipher(key)
    a_key = key.to_s.chars.map(&:to_i)
    i_key = a_key.reduce { |n1, n2| n1.to_s + n2.to_s }
    i_key = i_key.to_i
    i_key
  end

  def self.handle_text_double_transposition_cipher(document)
    a_letters = document.to_s.chars
    size = search_size(a_letters.length / 2, a_letters.length)
    a_letters = a_letters.each_slice(size).to_a
    a_letters
  end

  def self.search_size(half, length)
    dimensions = half * half
    if dimensions > length
      half = search_size(half / 2, length)
    elsif dimensions < length
      half += 1
    end
    half
  end

  def self.unshuffle(array, random:)
    a_transformed = array.to_a.shuffle!(random: random)
    array.sort_by.with_index { |_, i| a_transformed[i] }
    array
  end
end
