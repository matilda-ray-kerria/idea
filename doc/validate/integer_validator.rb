def validate_integer_with_digit(value, digit = 6)
  if value.class != Integer
    v = value.to_s.match(/^-?\d[_\d]*(\.[_0]*)?$/){|v| v[0]}
    return false if v.nil?

    value = v.to_i
  end

  value.abs < 10**digit
end
