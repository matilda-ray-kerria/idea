using BenchmarkTools

function fib_recursive(n::T) where {T<:Int}
    if n < 2
        return n
    end

    return fib_recursive(n - 1) + fib_recursive(n - 2)
end

function fib_iterative(n::T) where {T<:Int}
    return fibs_last2(n)[1]
end

function fibs_last2(n::T) where {T<:Int}
    a, b = 1, 0
    for _ in 2:n
        a, b = a + b, a
    end
    return a, b
end

function fib_halfiterative(n::T) where {T<:Int}
    even = n % 2 == 0
    i = even ? div(n, 2) + 1 : div(n + 1, 2)
    a, b = fibs_last2(i)
    return even ? b * (a - b + a) : a * a + b * b
end

if abspath(PROGRAM_FILE) == @__FILE__
    n = 40
    print("Fibonacci sequence for n = $n: ")

    val = fib_halfiterative(n)
    @assert val == fib_iterative(n) == fib_halfiterative(n)
    print(val)

    println("\n\nBenchmark for fib_recursive")
    display(@benchmark fib_recursive($n))
    println("\nBenchmark for fib_iterative")
    display(@benchmark fib_iterative($n))
    println("\nBenchmark for fib_halfiterative")
    display(@benchmark fib_halfiterative($n))
    println()
end