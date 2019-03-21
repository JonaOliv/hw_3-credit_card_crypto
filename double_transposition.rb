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

  module DoubleTranspo
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    @keyword = 'dbca' #permutation keyword/order.
    @key_size = 4

    def self.encrypt(document, k)
      # TODO: encrypt string using a permutation cipher

      # convert obj to json string
      document = DoubleTranspo.to_json_string(document)
      #document = 'HelloWorld'

      # generate a keyword for the column order of the grid
      key = random_key(@key_size, k)

      # Grid document string to appropriate columns
      grid = []
      (document).split('').each { |c| c != ' ' ? grid.push(c) : grid.push('@') }

      # check for grid empty slot and populate with dummy char
      if (grid.size % key.size) != 0
        1.upto(key.size - (grid.size % key.size)) do
          grid.push('#')
        end
      end

      # slice up array(grid) to create multidimensional array
      grid = grid.each_slice(key.size).to_a
      
      grid.unshift(key)

      grid = grid.transpose

      # generate key for row order of the grid
      key_row_size = document.size / (@keyword.size)
      row_key_length = 0
      keyword_row = []

      document.size % @keyword.size > 0 ? (row_key_length = key_row_size + 1) : 
      row_key_length = key_row_size

      row_order_key = random_key(row_key_length, k)

      row_order_key.unshift(0)

      grid.unshift(row_order_key)

      grid = grid.transpose


      # sort grid by row then by column header(key)
      grid = grid.sort
      
      grid = grid.transpose.sort
      grid = grid.transpose

      # Remove (header/column)key from grid
      grid.shift

      # Remove (label/row)key from grid
      grid = grid.transpose
      grid.shift
      grid = grid.transpose

      # Extract cipher values from grid, row after row ###.
      cipher_string = ''

      grid.each do |sub_array|
        sub_array.each do |item|
          cipher_string += item
        end
      end

      cipher_string
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    # returns json string    
    def self.decrypt(document, k)
      # TODO: decrypt string using a permutation cipher

      # generate a keyword for the column order of the grid
      key = random_key(@key_size, k)

      # populate a grid table with key header and characters from document.
      grid = []
      #grid = grid.sort
      document.split('').each { |c| grid.push(c) }

      # slice up ciphered document (grid) to multidimensional array
      grid = grid.each_slice(key.size).to_a


      # add column key in sorted order
      grid.unshift(key.sort)

      grid = grid.transpose

      # generate key for row order of the grid
      key_row_size = document.size / (@keyword.size)
      row_key_length = 0
      keyword_row = []

      document.size % @keyword.size > 0 ? (row_key_length = key_row_size + 1) : 
      row_key_length = key_row_size

      row_order_key = random_key(row_key_length, k)

      # add row key in sorted order
      sorted_keyword_row = row_order_key.sort
      sorted_keyword_row.unshift(0)
      grid.unshift(sorted_keyword_row.sort)

      # sort grid by column according to column original keword 
      key.unshift(0)
      grid = grid.sort_by { |a| key.index(a[0]) }

      grid = grid.transpose

      # sort grid by row according to row original keword 
      row_order_key.unshift(0)
      grid = grid.sort_by { |a| row_order_key.index(a[0]) }

      # Remove (header)key and row label(keyword_row)from grid
      grid.shift
      grid = grid.transpose
      grid.shift
      grid = grid.transpose

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

      decipher_string    
    end

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

    def self.random_key(size, k)
      if k < 0 
        k = 1
      end

      order_key =[]
      num_list = (1..127).to_a
      num_list = num_list.shuffle(random: Random.new(k))
    
      0.upto(size-1) do |i|
        order_key.push(num_list[i])
      end

      order_key
    end

    def self.print_matrix(m_array)
      m_array.each do |sub_array|
        print "#{sub_array} \n"
      end
      puts ' '
    end  
  end
end
