
const ElementList{T} = Union{
    Dict{Symbol, T}, Dict{String, T}} where {T<: AbstractColumnElement}

"""
    ``
"""
struct Column{T, F} <: AbstractColumn
    elements::ElementList{F}
    zmin::T
    zmax::T
end

function get_fields(c::Column{Tc}, e::Excitation{Te}, x, y, z) where {Tc,Te}
    el = c.elements
    return c.zmin < z < c.zmax ?
           sum([e[key].voltages * get_fields(el, x, y, z) for key in keys(el)]) : zero(Te)
end
