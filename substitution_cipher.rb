module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
    end
  end

  module Permutation
    #convert document to json_string
    def self.to_json_string(c_card)
      {
        # TODO: setup the hash with all instance vairables to serialize into json
        "number": c_card.number,
        "expiration_date": c_card.expiration_date,
        "owner": c_card.owner,
        "credit_network": c_card.credit_network
      }.to_json
    end

    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    @keyword = 'ruby'

    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher

      # convert obj to json string
      document = Permutation.to_json_string(document)

      print "document = #{document}"

      # generate lookup table
      lookup_tbl = {}
      h_key = ('a'..'z').to_a
      h_val = (1..127).to_a
      h_val = h_val.shuffle(random: Random.new(key)) # shuffle using key
      v = 0

      h_key.each do |k|
        lookup_tbl[k] = h_val[v]
        v += 1
      end

      # convert the keyword to int representation using the lookup_tbl
      keyword = []
      @keyword.split('').each { |val| keyword.push(lookup_tbl.key(val)) }
      key = @keyword.to_s

      # Grid document string to appropriate columns
      grid = []
      (key + document).split('').each { |c| c != ' ' ? grid.push(c) : grid.push('@') }

      # check for grid empty slot and populate with dummy char
      if (grid.size % key.size) != 0
        1.upto(key.size - (grid.size % key.size)) do
          grid.push('#')
        end
      end

      # slice up gride to create multidimensional array
      grid = grid.each_slice(key.size).to_a

      # sort grid by column header(key)
      grid = grid.transpose.sort
      grid = grid.transpose

      # Remove (header)key from grid
      grid.shift

      # Extract cipher values from grid, row after row ###.
      cipher_string = ''

      grid.each do |sub_array|
        sub_array.each do |item|
          cipher_string += item
        end
      end

      return cipher_string
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    # returns json string    
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher

      # generate lookup table
      lookup_tbl = {}
      h_key = ('a'..'z').to_a
      h_val = (1..127).to_a
      h_val = h_val.shuffle(random: Random.new(key)) # shuffle using key

      v = 0
      h_key.each do |k|
        lookup_tbl[k] = h_val[v]
        v += 1
      end

      # convert the keyword to int representation using the lookup_tbl
      keyword = []
      @keyword.split('').each { |val| keyword.push(lookup_tbl.key(val)) }
      key = @keyword.to_s

      # populate a grid table with key header and characters from document.
      grid = []
      key.size > 1 ? key.split('').each { |i| grid.push(i) } : grid.push(key)
      grid = grid.sort
      document.split('').each { |c| grid.push(c) }

      # slice up ciphered document (grid) to multidimensional array
      grid = grid.each_slice(key.size).to_a

      # sort grid by column header(key) to form back keyword
      grid = grid.transpose
      key_order = key.split('').to_a
      grid = grid.sort_by { |a| key_order.index(a[0]) }
      grid = grid.transpose

      # Remove (header)key from grid
      grid.shift

      # Extract deciphered values from grid, row after row.
      decipher_string = ''

      grid.each do |sub_array|
        sub_array.each do |item|
          if item == '@'
            decipher_string += ' '
          elsif item == '#'
            # do nothing
          else
            decipher_string += item
          end
        end
      end
      
      return decipher_string
    end
  end
end
