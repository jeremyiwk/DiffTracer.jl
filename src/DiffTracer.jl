module DiffTracer

using SpecialFunctions
using Symbolics

# globals
MAX_Z_DERIVATIVE = 4

# utils
include("utils.jl")

# column objects
include("column/AbstractTypes.jl")
include("column/Column.jl")
include("column/MultipoleField.jl")
include("column/RoundLens.jl")
export MultipoleField, RoundLens, Column

# multipole expansion and EoM
include("physics/AxialPotential.jl")
include("physics/EquationsOfMotion.jl")
include("physics/InitialCondition.jl")
include("physics/MultipoleExpansion.jl")
export AnalyticAxialPotential

# diff eq solvers
include("tracers/Tracer.jl")

end
