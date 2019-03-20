# frozen_string_literal: true

## This module have cryptography methods of Substitution: Caesar & Permutation.
module SubstitutionCipher
  ## This module have cryptography methods of Substitution: Caesar.
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      a_letters = document.to_s.chars.map { |i| i.ord.to_i }
      a_letters.map! { |i| (i + key).chr }
      a_letters.reduce { |n1, n2| n1 + n2 }
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      a_letters = document.to_s.chars.map { |i| i.ord.to_i }
      a_letters.map! { |i| (i - key).chr }
      a_letters.reduce { |n1, n2| n1 + n2 }
    end
  end

  ## This module have cryptography methods of Substitution: Permutation.
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
    end
  end
end
