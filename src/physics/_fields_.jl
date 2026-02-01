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

_names = (:erf, :tanh, :sigmoid,) # :sign)
_funcs = (_erf, _tanh, _sigmoid,) # _sign)

_field_forms = NamedTuple(zip(_names, _funcs))

FIELDS = Dict([name => Dict() for name in _names])

λ_MAX = Int((MAX_DERIVATIVE_ORDER - 1)/2)

function field_radial_terms(ν, λ)
    r2λ(x, y) = (x*x + y*y)^λ
    c =  (-1/4)^λ / (factorial(λ) * factorial(λ + ν, ν))

    wν(x, y) = sqrt(x*x + y*y)^ν * cis(ν * atan(y, x))

    dr2λ(x, y) = λ > 0 ? 2 * λ * (x*x + y*y)^(λ - 1) : zero(x)
    dwν(x, y) = ν > 0 ? ν * wν(x,y) * (x - im * y) / (x*x + y*y) : zero(x)

    r2λdx(x, y) = x * dr2λ(x, y)
    r2λdy(x, y) = y * dr2λ(x, y)
    wνdx(x, y) = dwν(x, y)
    wνdy(x, y) = im * dwν(x, y)

    φ(x, y) = c * r2λ(x, y) * wν(x, y)
    Ex(x, y) = - c * (r2λdx(x, y) * wν(x, y) + r2λ(x, y) * wνdx(x, y))
    Ey(x, y) = - c * (r2λdy(x, y) * wν(x, y) + r2λ(x, y) * wνdy(x, y))
    Ez(x, y) = - φ(x, y)
    return (;φ, Ex, Ey, Ez)
end

for name in _names,
    ν in 0:MAX_MULTIPOLE_ORDER

    func = _field_forms[name]
    numeric_Φ_terms = []
    numeric_dΦdz_terms = []
    radial_terms = []
    
    @variables z, zc, R, L, FR, FL
    Dz = Differential(z)

    for λ in 0:λ_MAX
        Dz2λ = Differential(z)^(2*λ)
        Φ = 0.5 * (func(_fwd(z, zc, R, L, FR)) + func(_rev(z, zc, R, L, FL)))
        Φ2λ = expand_derivatives(Dz2λ(Φ))
        Φ2λdz = expand_derivatives(Dz(Dz2λ(Φ)))

        numeric_Φ2λ = eval(build_function(Φ2λ, z, zc, R, L, FR, FL))
        numeric_Φ2λdz = eval(build_function(Φ2λdz, z, zc, R, L, FR, FL))

        radial = field_radial_terms(ν, λ)
        push!(numeric_Φ_terms, numeric_Φ2λ)
        push!(numeric_dΦdz_terms, numeric_Φ2λdz)
        push!(radial_terms, radial)
    end

    φ(x, y, z, zc, R, L, FR, FL) = sum([
        radial_terms[λ].φ(x, y) * numeric_Φ_terms[λ](z, zc, R, L, FR, FL) for λ in 0:λ_MAX
    ])

    Ex(x, y, z, zc, R, L, FR, FL) = sum([
        radial_terms[λ].Ex(x, y) * numeric_Φ_terms[λ](z, zc, R, L, FR, FL) for λ in 0:λ_MAX
    ])

    Ey(x, y, z, zc, R, L, FR, FL) = sum([
        radial_terms[λ].Ey(x, y) * numeric_Φ_terms[λ](z, zc, R, L, FR, FL) for λ in 0:λ_MAX
    ])

    Ez(x, y, z, zc, R, L, FR, FL) = sum([
        radial_terms[λ].Ez(x, y) * numeric_dΦdz_terms[λ](z, zc, R, L, FR, FL) for λ in 0:λ_MAX
    ])

    φr(x, y, z, zc, R, L, FR, FL) = real(φ(x, y, z, zc, R, L, FR, FL))
    Exr(x, y, z, zc, R, L, FR, FL) = real(Ex(x, y, z, zc, R, L, FR, FL))
    Eyr(x, y, z, zc, R, L, FR, FL) = real(Ey(x, y, z, zc, R, L, FR, FL))
    Ezr(x, y, z, zc, R, L, FR, FL) = real(Ez(x, y, z, zc, R, L, FR, FL))

    φi(x, y, z, zc, R, L, FR, FL) = imag(φ(x, y, z, zc, R, L, FR, FL))
    Exi(x, y, z, zc, R, L, FR, FL) = imag(Ex(x, y, z, zc, R, L, FR, FL))
    Eyi(x, y, z, zc, R, L, FR, FL) = imag(Ey(x, y, z, zc, R, L, FR, FL))
    Ezi(x, y, z, zc, R, L, FR, FL) = imag(Ez(x, y, z, zc, R, L, FR, FL))

    FIELDS[name][ν] = (;
        φr  = φr,
        Exr = Exr,
        Eyr = Eyr,
        Ezr = Ezr,
        φi  = φi,
        Exi = Exi,
        Eyi = Eyi,
        Ezi = Ezi,
    )
end