module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    sum_anwser = 0
    bool_alternative = false

    nums_a.reverse.each do |i|
        if (bool_alternative)
          if ((i * 2) > 9)
            sum_anwser = sum_anwser + (((i * 2) % 10) + 1)
          else
            sum_anwser = sum_anwser + ( i * 2)
          end
        else
          sum_anwser = sum_anwser + i
        end
        bool_alternative = !bool_alternative

    end
    (sum_anwser % 10 == 0)

  end
end
