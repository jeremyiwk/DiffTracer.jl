"""
    `AnalyticAxialPotential`
"""

struct AnalyticAxialPotential

end

_fwd(z, zc, R, L, F) = (L/(R*F))*(0.5 + (z - zc)/L)
_rev(z, zc, R, L, F) = (L/(R*F))*(0.5 - (z - zc)/L)

_erf(z) = SpecialFunctions.erf(z)
_tanh(z) = SpecialFunctions.tanh(z)
_sigmoid(z) = 2.0 / (1.0 + exp(-z)) - 1.0
_sign(z) = sign(z)