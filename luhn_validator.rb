# frozen_string_literal: true

## Module to validate credit card number using Luhn Algorithm.
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit

    (nums_a.reverse.each_slice(2).flat_map do |odd, even|
      [odd.to_i, *(even.to_i * 2).divmod(10)]
    end.inject(:+) % 10).zero?
  end
end
