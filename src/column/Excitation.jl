
mutable struct Excitation{T}
    voltages::Dict{Union{Symbol, String}, T}
end
