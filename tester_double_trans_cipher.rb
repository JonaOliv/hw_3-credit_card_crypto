require 'minitest/autorun'
require './double_trans_cipher'
require './credit_card'

def random_string
  [*'a'..'z'].sample(rand(1..12)).join
end

# describe 'Check result encrypt' do
#   it 'encrypt equal string' do
#     @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
#                            'Soumya Ray', 'Visa')
#     @key = 3
#     ran_string = random_string
#     packed = DoubleTranspositionCipher.encrypt(ran_string,26546)
#     _(packed).must_be_instance_of String
#   end
# end

describe 'Test double trans cipher' do
  it 'encrypt and decryt, same document' do
    ran_string = "attackatdawn"
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                           'Soumya Ray', 'Visa')
    @key = 3
    ran_string = @cc
    packed = DoubleTranspositionCipher.encrypt(ran_string,3)
    unpacked = DoubleTranspositionCipher.decrypt(packed,3)
    puts "hola2 " + unpacked
    _(unpacked).must_equal ran_string.to_s
  end
end
