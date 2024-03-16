# Fibonacci sequence

$$
\begin{align*}
  F_1 &= 1 \\
  F_2 &= 1 \\
  F_3 &= 2 \\
  F_4 &= 3 \\
  F_5 &= 5 \\
  F_6 &= 8 \\
  F_7 &= 13 \\
  &\vdots \\
  F_n &= F_{n-1} + F_{n-2} \\
\end{align*}
$$

```julia
function fib_recursive(n::T) where {T<:Int}
    if n < 2
        return n
    end

    return fib_recursive(n - 1) + fib_recursive(n - 2)
end
```

```julia
function fib_iterative(n::T) where {T<:Int}
    a, b = 1, 0
    for _ in 2:n
        a, b = a + b, a
    end
    return a
end
```

$$
\begin{alignedat}{5}
  F_n & = && F_{n-1} && + & &F_{n-2} &&= \left( F_{n-2} + F_{n-3} \right) + F_{n-2} \\
    & = & 2 & F_{n-2} && + & &F_{n-3} &&= 2\left( F_{n-3} + F_{n-4} \right) + F_{n-3} \\
    & = & 3 & F_{n-3} && + & 2&F_{n-4} \\
    & = & 5 & F_{n-4} && + & 3&F_{n-5} \\
    && \vdots \\
    & = & F_{i} & F_{n-i+1} && + & F_{i-1} & F_{n-i} \\
\end{alignedat}
$$

$$
F_n = \begin{cases}
  F_{\frac{n}{2}} \left( F_{\frac{n}{2}+1} + F_{\frac{n}{2}-1} \right) & \left( i = \displaystyle\frac{n}{2} + 1,\ n\ \text{is even} \right) \\
  F_{\frac{n+1}{2}}^2 + F_{\frac{n+1}{2}-1}^2 & \left( i = \displaystyle\frac{n+1}{2},\ n\ \text{is odd} \right) \\
\end{cases}
$$

```julia
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
```

```text
$ julia doc/fibonacci-sequence/benchmark.jl 
Fibonacci sequence for n = 40: 102334155

Benchmark for fib_recursive
BenchmarkTools.Trial: 11 samples with 1 evaluation.
 Range (min … max):  458.954 ms … 465.007 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     460.620 ms               ┊ GC (median):    0.00%
 Time  (mean ± σ):   460.989 ms ±   2.190 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▁ ▁█  ▁         ▁▁     ▁      ▁                             █  
  █▁██▁▁█▁▁▁▁▁▁▁▁▁██▁▁▁▁▁█▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▁
  459 ms           Histogram: frequency by time          465 ms <

 Memory estimate: 0 bytes, allocs estimate: 0.

Benchmark for fib_iterative
BenchmarkTools.Trial: 10000 samples with 999 evaluations.
 Range (min … max):  12.112 ns … 46.947 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     12.312 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   12.428 ns ±  0.826 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▆█ ▆ █ ▄                                                    ▂
  ██▁█▁█▁█▁▅▁█▁▆▁▄▁▅▁▅▁▅▁▆▁▆▁▆▁▆▁▆▁▇▁█▁█▁█▁▇▁▇▁▅▁▆▁▇▁▇▁▇▁▇▁▄▄ █
  12.1 ns      Histogram: log(frequency) by time      15.1 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.

Benchmark for fib_halfiterative
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  9.400 ns … 34.200 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     9.500 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   9.606 ns ±  0.491 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▅ █  █  ▅                                                  ▂
  █▁█▁▁█▁▁█▁▁▆▁▁▇▁▁▇▁▁▅▁▁▅▁▁▆▁▅▁▁▇▁▁▇▁▁█▁▁▆▁▁▇▁▁▆▁▁▇▁▁█▁▁█▁▇ █
  9.4 ns       Histogram: log(frequency) by time     11.4 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```

```text
Fibonacci sequence for n = 400: 2121778230729308891
Benchmark for fib_iterative
BenchmarkTools.Trial: 10000 samples with 916 evaluations.
 Range (min … max):  115.611 ns … 197.380 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     118.450 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   118.520 ns ±   2.487 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▂▄▁▇▂█ ▅▅▆▄▅▅▂██▂ ▅▇▁▃▄▄▃▂▁▂▁▂ ▁▁▁                            ▃
  ██████▆███████████████████████████▇██▇▇▆▆▇▇▄▇▇▆▆▇▅▆▆▆▇▇▆▆█▇▇▅ █
  116 ns        Histogram: log(frequency) by time        127 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.

Benchmark for fib_halfiterative
BenchmarkTools.Trial: 10000 samples with 980 evaluations.
 Range (min … max):  63.265 ns … 113.878 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     64.796 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   65.050 ns ±   3.652 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▅█▅ ▅█▃▅▆▂▂▃▁▂▁▂                                             ▂
  █████████████████▇▇▇▇▇▇▇▇▇▆▆▅▅▆▆▇▇▇▆▅▄▃▄▃▄▁▁▃▁▁▁▁▁▁▃▃▁▅▁▃▁▄▃ █
  63.3 ns       Histogram: log(frequency) by time      79.6 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
```
