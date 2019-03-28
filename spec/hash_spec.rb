# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  before do
    class << self
      %w[hash_secure hash].each do |action|
        define_method("unique_#{action}") do |cards, n|
          cards.each do |curr|
            0.upto(cards.size - 1) do |x|
              curr.send(n).wont_equal cards[x].send(n) if curr != cards[x]
            end
          end
        end

        define_method("const_#{action}") do |cards, n|
          cards.each do |card|
            first_hash = {}
            count = 1
            1.upto(10) do # repeated hash card obj 10 times
              repeated_hash = card.send(n)
              if count > 0
                first_hash = repeated_hash
                count -= 1
              end
              repeated_hash.must_equal first_hash
            end
          end
        end
      end
    end
  end

  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'Test card if its hashed repeatedly 10 times but still consistent' do
        const_hash(cards, 'hash')
      end
    end
  end

  describe 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards
    it 'Test if each card produce unigue hashes from each other' do
      unique_hash(cards, 'hash')
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'Test card if its hashed repeatedly 10 times but still consistent' do
        const_hash(cards, 'hash_secure')
      end
    end
  end

  describe 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards
    it 'Test if each card produce unigue hashes from each other' do
      unique_hash(cards, 'hash_secure')
    end
  end

  describe 'Check regular hash not same as cryptographic hash' do
    # TODO: Check that each card's hash is different from its hash_secure
    it 'Test if each card hash different from their hash_secure' do
      cards.each do |c|
        c.hash.wont_equal c.hash_secure
      end
    end
  end
end
