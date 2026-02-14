"""
    ``
"""
struct Column{T} <: AbstractColumn
    elements::Dict{Union{Symbol, String}, AbstractColumnElement}
    zmin::T
    zmax::T
end

function get_fields(c::Column{T}, e::Excitation, x, y, z) where {T}
    e = c.elements
    return c.zmin < z < c.zmax ?
           sum([e[key].voltages * get_fields(e, x, y, z) for key in keys(e)]) : zero(T)
end
