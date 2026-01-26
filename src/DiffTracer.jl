module DiffTracer

include("utils.jl")

include("column/AbstractTypes.jl")
include("column/Column.jl")
include("column/MultipoleField.jl")
include("column/RoundLens.jl")
export MultipoleField, RoundLens, Column

include("physics/AxialFields.jl")
include("physics/AxialPotential.jl")
include("physics/EquationsOfMotion.jl")
include("physics/InitialCondition.jl")
include("physics/MultipoleExpansion.jl")
export AnalyticAxialPotential

include("tracers/Tracer.jl")

end
