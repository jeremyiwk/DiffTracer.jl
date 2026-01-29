"""
Multipole field given by the multipole expansion in eq. 3.31 of
`Rose, Harald. (2012). Geometrical Charged-Particle Optics. 10.1007/978-3-642-32119-1.`
"""

# Axial field form definition
_fwd(z, zc, R, L, FR) = (L / (R * FR)) * (0.5 + (z - zc) / L)
_rev(z, zc, R, L, FL) = (L / (R * FL)) * (0.5 - (z - zc) / L)

_erf(z) = SpecialFunctions.erf(z)
_tanh(z) = SpecialFunctions.tanh(z)
_sigmoid(z) = 2.0 / (1.0 + exp(-z)) - 1.0
_sign(z) = sign(z)

_names = (:erf, :tanh) #, :sigmoid, :sign)
_funcs = (_erf, _tanh) #, _sigmoid, _sign)

_field_forms = NamedTuple(zip(_names, _funcs))

FIELDS = Dict([name => Dict() for name in _names])

for name in _names,
    ν in 0:MAX_MULTIPOLE_ORDER

    func = _field_forms[name]
    symbolic_φr_terms  = []
    symbolic_Exr_terms = []
    symbolic_Eyr_terms = []
    symbolic_Ezr_terms = []
    symbolic_φi_terms  = []
    symbolic_Exi_terms = []
    symbolic_Eyi_terms = []
    symbolic_Ezi_terms = []
    
    @variables x, y, z, zc, R, L, FR, FL
    Dx = Differential(x)
    Dy = Differential(y)
    Dz = Differential(z)

    for λ in 0:Int((MAX_DERIVATIVE_ORDER - 1)/2)
        Dz2λ = Differential(z)^(2*λ)
        Φ = 0.5 * (func(_fwd(z, zc, R, L, FR)) + func(_rev(z, zc, R, L, FL)))
        w = x + im * y
        w̅ = conj(w)
        c = (-1/4)^λ * factorial(ν) / (factorial(λ) * factorial(λ + ν))

        Φ2λ = expand_derivatives(Dz2λ(Φ))
        φr = c * real((w * w̅)^λ * real(w^ν)) * Φ2λ
        Exr = -expand_derivatives(Dx(φr))
        Eyr = -expand_derivatives(Dy(φr))
        Ezr = -expand_derivatives(Dz(φr))
        φi = c * real((w * w̅)^λ * imag(w^ν)) * Φ2λ
        Exi = -expand_derivatives(Dx(φi))
        Eyi = -expand_derivatives(Dy(φi))
        Ezi = -expand_derivatives(Dz(φi))

        push!(symbolic_φr_terms, φr)
        push!(symbolic_Exr_terms, Exr)
        push!(symbolic_Eyr_terms, Eyr)
        push!(symbolic_Ezr_terms, Ezr)
        push!(symbolic_φi_terms, φi)
        push!(symbolic_Exi_terms, Exi)
        push!(symbolic_Eyi_terms, Eyi)
        push!(symbolic_Ezi_terms, Ezi)
    end
    symbolic_φr  = sum(symbolic_φr_terms)
    symbolic_Exr = sum(symbolic_Exr_terms)
    symbolic_Eyr = sum(symbolic_Eyr_terms)
    symbolic_Ezr = sum(symbolic_Ezr_terms)
    symbolic_φi  = sum(symbolic_φi_terms)
    symbolic_Exi = sum(symbolic_Exi_terms)
    symbolic_Eyi = sum(symbolic_Eyi_terms)
    symbolic_Ezi = sum(symbolic_Ezi_terms)

    numeric_φr  = eval(build_function(symbolic_φr, x, y, z, zc, R, L, FR, FL))
    numeric_Exr = eval(build_function(symbolic_Exr, x, y, z, zc, R, L, FR, FL))
    numeric_Eyr = eval(build_function(symbolic_Eyr, x, y, z, zc, R, L, FR, FL))
    numeric_Ezr = eval(build_function(symbolic_Ezr, x, y, z, zc, R, L, FR, FL))
    numeric_φi  = eval(build_function(symbolic_φi, x, y, z, zc, R, L, FR, FL))
    numeric_Exi = eval(build_function(symbolic_Exi, x, y, z, zc, R, L, FR, FL))
    numeric_Eyi = eval(build_function(symbolic_Eyi, x, y, z, zc, R, L, FR, FL))
    numeric_Ezi = eval(build_function(symbolic_Ezi, x, y, z, zc, R, L, FR, FL))

    FIELDS[name][ν] = (;
        φr  = numeric_φr,
        Exr = numeric_Exr,
        Eyr = numeric_Eyr,
        Ezr = numeric_Ezr,
        φi  = numeric_φi,
        Exi = numeric_Exi,
        Eyi = numeric_Eyi,
        Ezi = numeric_Ezi,
    )
end