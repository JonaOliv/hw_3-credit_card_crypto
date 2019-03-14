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
    # number = "376190711495296 "
    # nums_a = number.to_s.chars.map(&:to_i)
    boolen = true

    nums_a.reverse!.map! do |i|
      boolen = !boolen
      boolen ? i * 2 : i
    end
    # nums_a.reverse_each { |i, index| i * 2 if index.even? }

    # nums_a.map! { |i| i % 10 + 1 if i > 9 }
    # ((nums_a.reduce { |n1, n2| n1 + n2 }) % 10).zero?

    nums_a = nums_a.reduce { |n1, n2| n2 > 9 ? n2 % 10 + 1 + n1 : n1 + n2 }

    # nums_a.reverse!.reduce! do |n1, n2, i|
    #   if i.even?
    #     n2 * 2 > 9 ? (n2 * 2) % 10 + 1 + n1 : n1 + n2 * 2
    #   else
    #     n1 + n2
    #   end
    # end

    # nums_a.reverse!.reduce! do |n1, n2| n2 > 9 ? n2 % 10 + 1 + n1 : n1 + n2
    #   if
    #
    #   else
    #
    #   end
    # end

    (nums_a % 10).zero?
    # ((nums_a.reduce { |n1, n2| n1 + n2 }) % 10).zero?

    # (nums_a.reverse.reduce do |n1, n2|
    #   b_jumping = !b_jumping
    #   if b_jumping
    #     (n2 * 2) > 9 ? n1 + (n2 * 2) % 10 + 1 : n1 + (n2 * 2)
    #   else
    #     n1 + n2
    #   end
    # end % 10).zero?
  end
end
