module ApplicationHelper
  def indian_currency_in_words(number)
    return "Zero Rupees" if number == 0

    number_parts = number.to_s.split(".")
    integer_part = number_parts[0].to_i
    decimal_part = (number_parts[1].to_i * 10) if number_parts[1]&.length == 1  # Ensure two-digit paise
    decimal_part = number_parts[1].to_i if number_parts[1]&.length == 2

    units = %w[Zero One Two Three Four Five Six Seven Eight Nine]
    teens = %w[Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen]
    tens = %w[Ten Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety]
    thousands = %w[ Hundred Thousand Lakh Crore ]

    # def number_to_words(num, units, teens, tens, thousands)
    #   words = []
    #   num_str = num.to_s.rjust(9, "0")  # Ensure 9 digits (Crore, Lakh, Thousand, Hundred)
    #   crore, lakh, thousand, hundred, tens_units = num_str[0..1], num_str[2..3], num_str[4..5], num_str[6], num_str[7..8]

    #   words << "#{units[crore.to_i]} Crore" if crore.to_i > 0
    #   words << "#{units[lakh.to_i]} Lakh" if lakh.to_i > 0
    #   words << "#{units[thousand.to_i]} Thousand" if thousand.to_i > 0
    #   words << "#{units[hundred.to_i]} Hundred" if hundred.to_i > 0

    #   if tens_units.to_i > 10 && tens_units.to_i < 20
    #     words << teens[tens_units.to_i - 11]
    #   else
    #     words << tens[tens_units[0].to_i - 1] if tens_units[0].to_i > 0
    #     words << units[tens_units[1].to_i] if tens_units[1].to_i > 0
    #   end

    #   words.compact.join(" ")
    # end

    words = number_to_words(integer_part, units, teens, tens)
    decimal_words = number_to_words(decimal_part, units, teens, tens, thousands) if decimal_part && decimal_part > 0
    result = words + " Rupees"
    result += " and #{decimal_words} Paise" if decimal_words

    result
  end

  def convert_up_to_99(num, units, teens, tens)
    return "" if num == 0
    return teens[num - 11] if num > 10 && num < 20

    tens_part = (num / 10) * 10
    ones_part = num % 10
    words = []
    words << tens[tens_part / 10 - 1] if tens_part >= 10
    words << units[ones_part] if ones_part > 0
    words.join(" ")
  end

  def number_to_words(num, units, teens, tens)
    return "Zero" if num == 0

    words = []

    crores = num / 10000000
    remainder = num % 10000000

    lakhs = remainder / 100000
    remainder = remainder % 100000

    thousands = remainder / 1000
    remainder = remainder % 1000

    hundreds = remainder / 100
    remainder = remainder % 100

    tens_units = remainder

    # Crores
    if crores > 0
      words << convert_up_to_99(crores, units, teens, tens) + " Crore"
    end

    # Lakhs
    if lakhs > 0
      words << convert_up_to_99(lakhs, units, teens, tens) + " Lakh"
    end

    # Thousands
    if thousands > 0
      words << convert_up_to_99(thousands, units, teens, tens) + " Thousand"
    end

    # Hundreds
    if hundreds > 0
      words << units[hundreds] + " Hundred"
    end

    # Tens & Units
    if tens_units > 0
      words << convert_up_to_99(tens_units, units, teens, tens)
    end
    words.join(" ")
  end
end
