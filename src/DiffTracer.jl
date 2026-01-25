module DiffTracer

include("utils.jl")

include("physics/AxialFields.jl")
include("physics/AxialPotential.jl")
include("physics/EquationsOfMotion.jl")
include("physics/InitialCondition.jl")
include("physics/MultipoleExpansion.jl")

include("types/AbstractTypes.jl")
include("types/Column.jl")
include("types/MultipoleField.jl")
include("types/RoundLens.jl")

include("tracers/Tracer.jl")

end
