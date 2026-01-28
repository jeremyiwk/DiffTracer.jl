using BenchmarkTools

using Test
using SafeTestsets

function f1(n, x, y)
    return (x^2 + y^2)^(n/2) * cos(n * atan(y, x))
end

function f2(n, x, y)
    return real((x + im*y)^n)
end


nmax = 20

@testset "goop" begin
for i in 0:nmax
    x, y = 10 * randn(2)
    # t1 = @belapsed f1($i, $x, $y)
    # t2 = @belapsed f2($i, $x, $y)
    # @info """
    # polar time = $(t1)
    # complex time = $(t2)
    # """
    @test f1(i, x, y) ≈ f2(i, x, y)
end
end

@btime f1(3, 0.0, 0.0)
@btime f2(3, 0.0, 0.0)