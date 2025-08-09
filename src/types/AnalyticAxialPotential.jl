
_fwd(z, zc, R, L, F) = (L/(R*F))*(0.5 + (z - zc)/L)
_rev(z, zc, R, L, F) = (L/(R*F))*(0.5 - (z - zc)/L)

_erf(z) = SpecialFunctions.erf(z)
_tanh(z) = SpecialFunctions.tanh(z)
_sigmoid(z) = 2.0 / (1.0 + exp(-z)) - 1.0
_sign(z) = sign(z)

_funcs = (_erf, _tanh, _sigmoid, _sign)
_names = (:erf, :tanh, :sigmoid, :sign)

_field_form = Dict(zip(_funcs, _names))

"""
    `AnalyticAxialPotential`
"""
struct AnalyticAxialPotential{T<:AbstractFloat}
    z_center::T
    radius::T
    length::T
    fringe_factor::T
    field_form::Symbol

    function AnalyticAxialPotential(args...; ff::Symbol=:erf)
        T = promote_type(typeof.(args)...)
        @assert T <: AbstractFloat
        @assert ff in _names "field form must be one of $(_names)"
        _args = map(x -> convert(T,x), args)
        return new{T}(_args..., ff)
    end
end
