require "test/unit/assertions"
include Test::Unit::Assertions

NUMBERS = { "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9,
            "ten" => 10, "eleven" => 11, "twelve" => 12, "thirteen" => 13, "fourteen" => 14, "fifteen" => 15, "sixteen" => 16,
            "seventeen" => 17, "eighteen" => 18, "nineteen" => 19, "twenty" => 20, "thirty" => 30, "forty" => 40, "fifty" => 50,
            "sixty" => 60, "seventy" => 70, "eighty" => 80, "ninety" => 90, "one million" => 1000000}

def parse_int(string)
  return NUMBERS[string] if NUMBERS[string]
  if string.match(/\sand\s/) then string = string.split(/\sand\s/).join(' ') end
  thousands, less_thousands = split_words(string, / thousand\s?/)
  hundred_thousands, tens_and_units_thousands = split_words(thousands, / hundred\s?/)
  tens_thousands, up_to_nineteen_thousands = split_words(tens_and_units_thousands, /\-/)
  hundreds, tens_and_units = split_words(less_thousands, / hundred\s?/)
  tens, up_to_nineteen = split_words(tens_and_units, /\-/)

  convert_words(up_to_nineteen, 0) + convert_words(tens, 0) + convert_words(hundreds, 2) +
  convert_words(up_to_nineteen_thousands, 3) + convert_words(tens_thousands, 3) + convert_words(hundred_thousands, 5)
end

def split_words(str, pattern)
  if str.nil?
    return nil, nil
  elsif str.match(pattern)
    return str.split(pattern)
  else
    return nil, str
  end
end

def convert_words(str, pow_10)
  return 0 if str.nil?
  NUMBERS[str] * 10 ** pow_10
end

assert_equal(parse_int('one'), 1)
assert_equal(parse_int('twenty'), 20)
assert_equal(parse_int('two hundred forty-six'), 246)
