# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
    class << self
      %w[caesar permutation double_trans modern_symmetric].each do |action|
        define_method("encrypt_#{action}") do |cc, key, cipher:|
          enc = cipher.encrypt(cc, key)
          enc.wont_equal cc.to_s
          enc.wont_be_nil
        end

        define_method("decrypt_#{action}") do |cc, key, cipher:|
          enc = cipher.encrypt(cc, key)
          dec = cipher.decrypt(enc, key)
          dec.must_equal cc.to_s
        end
      end
    end
  end

  describe 'Using Caesar cipher' do
    it 'should encrypt card information' do
      encrypt_caesar(@cc, @key, cipher: SubstitutionCipher::Caesar)
    end

    it 'should decrypt text' do
      decrypt_caesar(@cc, @key, cipher: SubstitutionCipher::Caesar)
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      encrypt_permutation(@cc, @key, cipher: SubstitutionCipher::Permutation)
    end

    it 'should decrypt text' do
      decrypt_permutation(@cc, @key, cipher: SubstitutionCipher::Permutation)
    end
  end

  describe 'Using Double Transposition' do
    it 'should encrypt card information' do
      encrypt_double_trans(@cc, @key, cipher: DoubleTranspositionCipher)
    end

    it 'should decrypt text' do
      decrypt_double_trans(@cc, @key, cipher: DoubleTranspositionCipher)
    end
  end

  describe 'Using Modern Symmetric' do
    it 'should encrypt card information' do
      encrypt_modern_symmetric(@cc, @key, cipher: ModernSymmetricCipher)
    end

    it 'should decrypt text' do
      decrypt_modern_symmetric(@cc, @key, cipher: ModernSymmetricCipher)
    end
  end

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
end
