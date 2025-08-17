
_fwd(z, zc, R, L, F) = (L / (R * F)) * (0.5 + (z - zc) / L)
_rev(z, zc, R, L, F) = (L / (R * F)) * (0.5 - (z - zc) / L)

_erf(z) = SpecialFunctions.erf(z)
_tanh(z) = SpecialFunctions.tanh(z)
_sigmoid(z) = 2.0 / (1.0 + exp(-z)) - 1.0
_sign(z) = sign(z)

_names = (:erf, :tanh, :sigmoid, :sign)
_funcs = (_erf, _tanh, _sigmoid, _sign)

_field_forms = NamedTuple(zip(_names, _funcs))

"""
    `AnalyticAxialPotential`
"""
struct AnalyticAxialPotential{T <: AbstractFloat} <: AbstractAxialPotential
    z_center::T
    radius::T
    length::T
    z_min::T
    z_max::T
    fringe_factor::T
    field_form::Symbol

    function AnalyticAxialPotential(args...; ff::Symbol = :erf)
        T = promote_type(typeof.(args)...)
        @assert T <: AbstractFloat
        @assert z_min < z_center < z_max
        @assert ff in _names "field form must be one of $(_names)"
        _args = map(x -> convert(T, x), args)
        return new{T}(_args..., ff)
    end
end
