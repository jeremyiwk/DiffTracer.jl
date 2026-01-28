"""
"""
struct Multipole{TF<:AbstractMultipoleField} <: AbstractColumnElement
    order::Int64
    field::TF
end