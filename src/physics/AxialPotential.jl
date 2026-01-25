"""
    `AnalyticAxialPotential`
"""
struct AnalyticAxialPotential{T} <: AbstractAxialPotential
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

function get_fields()
end