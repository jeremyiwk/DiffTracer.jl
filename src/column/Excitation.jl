const ExcitationList{T} = Union{
    Dict{Symbol, T}, Dict{String, T}} where {T}

mutable struct Excitation{T}
    voltages::ExcitationList{T}
end