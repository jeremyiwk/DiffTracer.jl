"""
    ``
"""
struct Column{T} <: AbstractColumn
    elements::Dict{Union{Symbol, String}, }
    z_min::T
    z_max::T
    r_max::T
end

function get_fields(col::Column{T}, xyz::SVector{3, T})
end
