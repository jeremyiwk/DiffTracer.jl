"""
"""
struct RoundLens{T,TF<:AbstractAxialPotential} <: AbstractColumnElement
    field::TF
    radius::T
    length::T
end