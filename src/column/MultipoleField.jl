"""
"""
struct MultipoleField{TF<:AbstractAxialPotential} <: AbstractColumnElement
    order::Int64
    axialpotential::TF
end