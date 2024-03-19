function validate_integer_with_digit(x::T, d::D=6) where {T<:Int,D<:Int}
    println("int")
    return abs(x) < 10^d
end

function validate_integer_with_digit(x::T, d::D=6) where {T<:AbstractFloat,D<:Int}
    try
        return validate_integer_with_digit(Int(x), d)
    catch
        println("float")
        return false
    end
end

function validate_integer_with_digit(x::S, d::D=6) where {S<:AbstractString,D<:Int}
    try
        return validate_integer_with_digit(parse(Float64, x), d)
    catch
        println("string")
        return false
    end
end

function validate_integer_with_digit(_x::T, _d::D=6) where {T,D}
    println("other")
    return false
end


if abspath(PROGRAM_FILE) == @__FILE__
    x = 12345678
    println("validate a $(typeof(x)) with 8 digits: $(x)")
    println(validate_integer_with_digit(x, 8))
    println("validate a $(typeof(x)) with 5 digits: $(x)")
    println(validate_integer_with_digit(x, 5))

    x = 123456.0
    println("validate a $(typeof(x)): $(x)")
    println(validate_integer_with_digit(x))

    x = 123456.78
    println("validate a $(typeof(x)): $(x)")
    println(validate_integer_with_digit(x))

    x = "-0012345678"
    println("validate a $(typeof(x)) with 8 digits: $(x)")
    println(validate_integer_with_digit(x, 8))
    println("validate a $(typeof(x)) with 5 digits: $(x)")
    println(validate_integer_with_digit(x, 5))

    x = "-123456."
    println("validate a $(typeof(x)): $(x)")
    println(validate_integer_with_digit(x))

    x = "-123456.78"
    println("validate a $(typeof(x)): $(x)")
    println(validate_integer_with_digit(x))
end