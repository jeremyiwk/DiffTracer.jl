

"""
    struct AnalyticMultipoleField

"""
struct AnalyticMultipoleField{T<:Real} <: AbstractMultipoleField
    multipole_order::Int64
    derivative_order::Int64
    zcenter::T
    radius::T
    length::T
    ffleft::T
    ffright::T
    zmin::T
    zmax::T
    rmin::T
    rmax::T
    field_form::Symbol
    field::Tuple{Function}
end

"""Axial field form definition"""

_fwd(z, zc, R, L, FR) = (L / (R * FR)) * (0.5 + (z - zc) / L)
_rev(z, zc, R, L, FL) = (L / (R * FL)) * (0.5 - (z - zc) / L)

_erf(z) = SpecialFunctions.erf(z)
_tanh(z) = SpecialFunctions.tanh(z)
_sigmoid(z) = 2.0 / (1.0 + exp(-z)) - 1.0
_sign(z) = sign(z)

_names = (:erf, :tanh, :sigmoid, :sign)
_funcs = (_erf, _tanh, _sigmoid, _sign)

_field_forms = NamedTuple(zip(_names, _funcs))

# function _get_field(name::Symbol, max_order::Int64)
#     orders = Tuple(0:max_order)
#     fields = map(orders) do n
#         @variables z, zc, R, L, FR, FL
#         Dn = Differential(z)^n
#         func = _field_forms[name]
#         expr = 0.5 * (func(_fwd(z, zc, R, L, FR)) + func(_rev(z, zc, R, L, FL)))
#         expr_dn = expand_derivatives(Dn(expr))
#         return eval(build_function(expr_dn, z, zc, R, L, FR, FL))
#     end
#     return fields
# end

"""
Generation of the expansion in Eq. 3.31 in
`Rose, Harald. (2012). Geometrical Charged-Particle Optics. 10.1007/978-3-642-32119-1.`
"""
