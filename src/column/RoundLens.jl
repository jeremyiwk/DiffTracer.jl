"""
"""
struct RoundLens{TF <: AbstractMultipoleField} <: AbstractColumnElement
    field::TF
end
