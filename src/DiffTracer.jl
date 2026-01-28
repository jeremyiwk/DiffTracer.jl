module DiffTracer

using SpecialFunctions
using Symbolics

# globals
MAX_DERIVATIVE_ORDER = 5
MAX_MULTIPOLE_ORDER = 8

# utils
include("utils.jl")

# multipole expansion and EoM
include("physics/AxialPotential.jl")
include("physics/EquationsOfMotion.jl")
include("physics/InitialCondition.jl")
include("physics/MultipoleExpansion.jl")
export AnalyticAxialPotential

# column objects
include("column/AbstractTypes.jl")
include("column/Column.jl")
include("column/MultipoleField.jl")
include("column/RoundLens.jl")
export MultipoleField, RoundLens, Column

# diff eq solvers
include("tracers/Tracer.jl")

end
