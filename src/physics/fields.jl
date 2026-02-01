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
_atan(z) = 2 * atan(z) / π
_sign(z) = sign(z)

_names = (:erf, :tanh, :atan, :sigmoid, :sign)
_funcs = (_erf, _tanh, _atan, _sigmoid, _sign)

_field_forms = NamedTuple(zip(_names, _funcs))

FIELDS = Dict([name => Dict() for name in _names])

symbolic_FIELDS = Dict([name => Dict() for name in _names])

@variables x, y, z, zc, R, L, FR, FL
Dx = Differential(x)
Dy = Differential(y)
Dz = Differential(z)

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

    for λ in 0:Int((MAX_DERIVATIVE_ORDER - 1)/2)
        Dz2λ = Differential(z)^(2*λ)
        Φ = 0.5 * (func(_fwd(z, zc, R, L, FR)) + func(_rev(z, zc, R, L, FL)))
        w = x + im * y
        w̅ = x - im * y
        r2 = w * w̅
        r = sqrt(x*x + y*y)
        θ = atan(y, x)
        c =  (-1/4)^λ / (factorial(λ) * factorial(λ + ν, ν))

        Φ2λ = expand_derivatives(Dz2λ(Φ))
        Φ2λdz = expand_derivatives(Dz(Dz2λ(Φ)))

        wν = w^ν #r^ν * cis(ν * θ)
        r2λ = r2^λ
        r2λdx = λ > 0 ? 2 * λ * x * r2^(λ - 1) : zero(r2)
        r2λdy = λ > 0 ? 2 * λ * y * r2^(λ - 1) : zero(r2)
        wνdx = ν > 0 ? ν * wν * w̅ / r2 : zero(w)
        wνdy = im * (ν > 0 ? ν * wν * w̅ / r2 : zero(w))

        φ = r2^λ * wν * Φ2λ
        Ex = -(r2λdx * wν + r2λ * wνdx) * Φ2λ
        Ey = -(r2λdy * wν + r2λ * wνdy) * Φ2λ
        Ez = - r2^λ * wν * Φ2λdz
        
        φr, φi = real(φ), imag(φ)
        Exr, Exi = real(Ex), imag(Ex)
        Eyr, Eyi = real(Ey), imag(Ey)
        Ezr, Ezi = real(Ez), imag(Ez)

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

    symbolic_FIELDS[name][ν] = (;
        φr  = symbolic_φr,
        Exr = symbolic_Exr,
        Eyr = symbolic_Eyr,
        Ezr = symbolic_Ezr,
        φi  = symbolic_φi,
        Exi = symbolic_Exi,
        Eyi = symbolic_Eyi,
        Ezi = symbolic_Ezi,
    )

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

# name = :erf
# n = 2
# Exr = symbolic_FIELDS[name][n].Exr
# Eyr = symbolic_FIELDS[name][n].Eyr
# Ezr = symbolic_FIELDS[name][n].Ezr

# Dx2 = Differential(x)
# Dy2 = Differential(y)
# Dz2 = Differential(z)

# dEx = expand_derivatives(Dx(Exr))
# dEy = expand_derivatives(Dy(Eyr))
# dEz = expand_derivatives(Dz(Ezr))

# divE = dEx + dEy + dEz

# ndivE = eval(build_function(divE, x, y, z, zc, R, L, FR, FL))

