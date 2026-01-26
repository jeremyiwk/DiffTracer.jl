using DiffTracer
using SafeTestsets
using Test

@safetestset "DiffTracer.jl" begin
    @safetestset "column" begin
        include("column/types.jl")
    end
end
