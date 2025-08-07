using DiffTracer
using SafeTestsets
using Test

@safetestset "DiffTracer.jl" begin
    @safetestset "types" begin
        include("./types.jl")
    end
    @safetestset "solve" begin
        include("./solve.jl")
    end
end
