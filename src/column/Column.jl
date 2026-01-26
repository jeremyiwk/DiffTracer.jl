"""
    ``
"""
struct Column{T} <: AbstractColumn
    elements::Dict{Union{Symbol, String}, AbstractColumnElement}
    zmin::T
    zmax::T
end
