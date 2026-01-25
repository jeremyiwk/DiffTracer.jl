"""
    ``
"""
struct Column{T} <: AbstractColumn
    elements::Dict{Union{Symbol, String}, }
end

function get_fields(col::Column{T}, xyz::SVector{3, T})
end
