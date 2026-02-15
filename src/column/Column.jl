
const ElementList{T} where {T} = Union{
    Dict{Symbol, T <: AbstractColumnElement}, Dict{String, T <: AbstractColumnElement}}

"""
    ``
"""
struct Column{T, F} <: AbstractColumn
    elements::ElementList{F}
    zmin::T
    zmax::T
end

function get_fields(c::Column{T}, e::Excitation, x, y, z) where {T}
    e = c.elements
    return c.zmin < z < c.zmax ?
           sum([e[key].voltages * get_fields(e, x, y, z) for key in keys(e)]) : zero(T)
end
