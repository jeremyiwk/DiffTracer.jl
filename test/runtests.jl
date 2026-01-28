using DiffTracer
using SafeTestsets
using Test

@safetestset "Axial Potential" begin
    include("physics/AxialPotential.jl")
end
@safetestset "Multipole Expansion" begin
    include("physics/MultipoleExpansion.jl")
end
# @safetestset "Column" begin
#     include("column/types.jl")
# end