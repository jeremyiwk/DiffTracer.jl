"""
"""
struct RoundLens{TF <: AbstractMultipoleField} <: AbstractColumnElement
    axialpotential::TF
end
