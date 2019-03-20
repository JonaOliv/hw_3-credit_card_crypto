require 'minitest/autorun'
require './double_trans_cipher'

def random_string
  [*'a'..'z'].sample(rand(1..12)).join
end

describe 'Check result encrypt' do
  it 'encrypt equal string' do
    ran_string = random_string
    packed = DoubleTranspositionCipher.encrypt(ran_string,26546)
    _(packed).must_be_instance_of String
  end
end

describe 'Test double trans cipher' do
  it 'encrypt and decryt, same document' do
    ran_string = random_string
    packed = DoubleTranspositionCipher.encrypt(ran_string,26546)
    unpacked = DoubleTranspositionCipher.decrypt(packed,26546)
    _(unpacked).must_equal ran_string
  end
end
