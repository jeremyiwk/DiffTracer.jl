module DiffTracer

using SpecialFunctions
using Symbolics


# globals
MAX_DERIVATIVE_ORDER = 5 # should be odd
MAX_MULTIPOLE_ORDER = 8

# general
include("utils.jl")
include("AbstractTypes.jl")

# multipole expansion and EoM
include("physics/fields.jl")
include("physics/AxialPotential.jl")
include("physics/AnalyticMultipoleField.jl")
include("physics/EquationsOfMotion.jl")
include("physics/InitialCondition.jl")
export AnalyticMultipoleField

# column objects
include("column/Column.jl")
include("column/Multipole.jl")
include("column/RoundLens.jl")
export MultipoleField, RoundLens, Column

# diff eq solvers
include("tracers/Tracer.jl")

end
