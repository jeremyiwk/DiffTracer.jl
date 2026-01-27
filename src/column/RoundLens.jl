"""
"""
struct RoundLens{TF<:AbstractAxialPotential} <: AbstractColumnElement
    axialpotential::TF
end

function RoundLens(args)
    return RoundLens(AnalyticAxialPotential(;args...))
end

