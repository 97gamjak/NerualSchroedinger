function simpson(f::Function, a::Number, b::Number, n::Number)
    n % 2 == 0 || error("`n` must be even")
    h = (b-a)/n
    s = f(a) + f(b)
    s += 4sum(f.(a .+ collect(1:2:n) * h))
    s += 2sum(f.(a .+ collect(2:2:n-1) * h))
    return h/3 * s
end