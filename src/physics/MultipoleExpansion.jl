"""
Generation of the expansion in Eq. 3.31 in
`Rose, Harald. (2012). Geometrical Charged-Particle Optics. 10.1007/978-3-642-32119-1.`
"""

multipole_expansion = []
for ν in 0:MAX_MULTIPOLE_ORDER,
    λ in 0:MAX_DERIVATIVE_ORDER

    @variables x, y
    Dx = Differential(x)
    Dy = Differential(y)
    w = x + im * y
    w̅ = conj(w)
    c = simplify((-1/4)^λ * factorial(ν) / (factorial(λ) * factorial(λ + ν)))
    ϕ = c * real((w * w̅)^λ * real(w^ν))
    ex = -expand_derivatives(Dx(ϕ))
    ey = -expand_derivatives(Dy(ϕ))

    field = (ν, λ) => (;
        φ = eval(build_function(ϕ, x, y)),
        Ex = eval(build_function(ex, x, y)),
        Ey = eval(build_function(ey, x, y)),
    )
    push!(multipole_expansion, field)
end

multipole_expansion = Dict(multipole_expansion)