
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

function Base.show(io::IO, ::MIME"text/plain", c::Column)
    el = c.elements
    s = "Column ═╗"
    println(s)
    p = repeat(" ", length(s) - 1)
    for (i, k) in enumerate(keys(el))
        e = i == length(keys(el))
        d = e ? "╚" : "╠"
        s = p * d * "═ $(k): ═"
        l = length(s) - length(p) - 1
        d = e ? " " : "║"
        q = p * d * repeat(" ", l)
        pfx = [s, q, q, q, q, q, q, q]
        
        # Base.show(io, ::MIME"text/plain", el[k])
        # _show(io, el[k], pfx)
    end
end
