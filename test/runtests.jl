using DiffTracer
using SafeTestsets
using Test

@safetestset "DiffTracer.jl" begin
    @safetestset "physics" begin
        include("physics/AxialPotential.jl")
    end
    @safetestset "column" begin
        include("column/types.jl")
    end
end
