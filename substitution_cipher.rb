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

      # convert document(creditcard obj) to json string
      document = Permutation.to_json_string(document)

      # generate a lookup table
      lookup_tbl = generate_lookup_tbl

      # convert the document to int representation using the lookup_tbl
      doc_fixnum = []
      document.split('').each { |k| doc_fixnum.push(lookup_tbl[k]) }

      # shuffle the values in the lookup table using the key
      shuff_lookup_tbl = Permutation.shuffle_lookup_tbl(lookup_tbl, key)

      # convert the org_doc_fixnum to string using the suffled lookup_tbl
      cipher_string = []
      doc_fixnum.each do |val|
        cipher_string.push(shuff_lookup_tbl.key(val.to_i))
      end

      cipher_string.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    # returns json string
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher

      # generate a lookup table
      lookup_tbl = generate_lookup_tbl

      # shuffle the values in the lookup table using the key
      shuff_lookup_tbl = Permutation.shuffle_lookup_tbl(lookup_tbl, key)

      # convert the document to int representation using the shuff_lookup_tbl
      cipher_fixnum = []
      document.split('').each { |k| cipher_fixnum.push(shuff_lookup_tbl[k]) }

      # convert the cipher_fixnum to string using the lookup_tbl
      decipher_string = []
      cipher_fixnum.each do |val|
        decipher_string.push(lookup_tbl.key(val.to_i))
      end
      decipher_string = decipher_string.join('')

      decipher_string
    end

    # convert document to json_string
    def self.to_json_string(c_card)
      {
        # TODO: setup the hash with all instance
        #  vairables to serialize into json
        "number": c_card.number,
        "expiration_date": c_card.expiration_date,
        "owner": c_card.owner,
        "credit_network": c_card.credit_network
      }.to_json
    end

    # create/generate a lookup table
    def self.generate_lookup_tbl
      lookup_tbl = {}
      h_key = ('a'..'z').to_a + ('A'..'Z').to_a + ('!'..'?').to_a
      h_key += ['{', '}', ' ', '_']
      h_val = (0..127).to_a
      v = 0
      h_key.each do |k|
        lookup_tbl[k] = h_val[v]
        v += 1
      end
      lookup_tbl
    end

    # shuffle the values of a lookup table
    def self.shuffle_lookup_tbl(lookup_tbl, key)
      shuff_lookup_tbl = {}
      max_val = 0
      lookup_tbl.max_by { |_, v| max_val = v }
      h_key = ('a'..'z').to_a + ('A'..'Z').to_a + ('!'..'?').to_a
      h_key += ['{', '}', ' ', '_']
      h_val2 = (0..max_val).to_a
      h_val2 = h_val2.shuffle(random: Random.new(key)) # shuffle values
      v = 0
      h_key.map do |k|
        shuff_lookup_tbl[k] = h_val2[v]
        v += 1
      end
      shuff_lookup_tbl
    end
  end
end
