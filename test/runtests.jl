using DiffTracer
using SafeTestsets
using Test

@safetestset "Physics" begin
    include("physics/AxialPotential.jl")
end
# @safetestset "column" begin
#     include("column/types.jl")
# end