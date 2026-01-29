using DiffTracer
using ForwardDiff
using LinearAlgebra

@testset "Derivatives" begin
    field_forms = DiffTracer._field_forms
    names = keys(field_forms)
    FIELDS = DiffTracer.FIELDS
    for name in names,
        ν in 0:DiffTracer.MAX_MULTIPOLE_ORDER

        x, y, z, zc, R, L, FR, FL = randn(8)
        x, y, z = zeros(3)
        zc, R, L, FR, FL = ones(5)

        r = [x, y, z]

        f = FIELDS[name][ν]
        φr(r)  = f.φr(r..., zc, R, L, FR, FL)
        Exr(r) = f.Exr(r..., zc, R, L, FR, FL)
        Eyr(r) = f.Eyr(r..., zc, R, L, FR, FL)
        Ezr(r) = f.Ezr(r..., zc, R, L, FR, FL)
        φi(r)  = f.φi(r..., zc, R, L, FR, FL)
        Exi(r) = f.Exi(r..., zc, R, L, FR, FL)
        Eyi(r) = f.Eyi(r..., zc, R, L, FR, FL)
        Ezi(r) = f.Ezi(r..., zc, R, L, FR, FL)

        # @test φr(r) isa Float64
        # @test Exr(r) isa Float64
        # @test Eyr(r) isa Float64
        # @test Ezr(r) isa Float64
        # @test φi(r) isa Float64
        # @test Exi(r) isa Float64
        # @test Eyi(r) isa Float64
        # @test Ezi(r) isa Float64

        ∇φr = ForwardDiff.gradient(φr, r)
        ∇φi = ForwardDiff.gradient(φi, r)

        # ∇²φr = tr(ForwardDiff.hessian(φr, r))
        # ∇²φi = tr(ForwardDiff.hessian(φi, r))

        @test ∇φr[1] ≈ -Exr(r)
        @test ∇φr[2] ≈ -Eyr(r)
        @test ∇φr[3] ≈ -Ezr(r)
        @test ∇φi[1] ≈ -Exi(r)
        @test ∇φi[2] ≈ -Eyi(r)
        @test ∇φi[3] ≈ -Ezi(r)

        dr = 1e-8
        r1 = [x + dr, y, z]
        r2 = [x - dr, y, z]
        r3 = [x, y + dr, z]
        r4 = [x, y - dr, z]
        r5 = [x, y, z + dr]
        r6 = [x, y, z - dr]
        rs = [r1, r2, r3, r4, r5, r6]
        D²φr = (sum(φr.(rs)) - 6*φr(r))/dr^2
        D²φi = (sum(φi.(rs)) - 6*φi(r))/dr^2

        @test D²φr ≈ 0.0 atol=1e-16
        @test D²φi ≈ 0.0 atol=1e-16
    end
end