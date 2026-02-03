using DiffTracer
using ForwardDiff
using LinearAlgebra

@testset "Derivatives" begin
    field_forms = DiffTracer._field_forms
    names = keys(field_forms)
    FIELDS = DiffTracer.FIELDS
    for name in names,
        ν in 0:DiffTracer.MAX_MULTIPOLE_ORDER

        @testset "Field: $(name), Multipole Order: $(ν)" begin
            zc, R, L, FR, FL = 0.0, 1.0, 1.0, 0.1, 0.1
            x, y, z = [0.1, 0.1, zc]
            r = [x, y, z + zc]

            f = FIELDS[name][ν]
            φr(r)  = f.φr(r..., zc, R, L, FR, FL)
            Exr(r) = f.Exr(r..., zc, R, L, FR, FL)
            Eyr(r) = f.Eyr(r..., zc, R, L, FR, FL)
            Ezr(r) = f.Ezr(r..., zc, R, L, FR, FL)
            φi(r)  = f.φi(r..., zc, R, L, FR, FL)
            Exi(r) = f.Exi(r..., zc, R, L, FR, FL)
            Eyi(r) = f.Eyi(r..., zc, R, L, FR, FL)
            Ezi(r) = f.Ezi(r..., zc, R, L, FR, FL)

            for z in (zc - L, zc, zc + L)
                r = [x, y, z]
                ∇φr = ForwardDiff.gradient(φr, r)
                ∇φi = ForwardDiff.gradient(φi, r)

                @test ∇φr[1] ≈ -Exr(r) atol=1e-10
                @test ∇φr[2] ≈ -Eyr(r) atol=1e-10
                @test ∇φr[3] ≈ -Ezr(r) atol=1e-10
                @test ∇φi[1] ≈ -Exi(r) atol=1e-10
                @test ∇φi[2] ≈ -Eyi(r) atol=1e-10
                @test ∇φi[3] ≈ -Ezi(r) atol=1e-10

                ∇²φr = tr(ForwardDiff.hessian(φr, r))
                ∇²φi = tr(ForwardDiff.hessian(φi, r))

                @test ∇²φr ≈ 0.0 atol=1e-4
                @test ∇²φi ≈ 0.0 atol=1e-4
            end
        end
    end
end

            # dr = 1e-6
            # r1 = [x + dr, y, z]
            # r2 = [x - dr, y, z]
            # r3 = [x, y + dr, z]
            # r4 = [x, y - dr, z]
            # r5 = [x, y, z + dr]
            # r6 = [x, y, z - dr]
            # rs = [r1, r2, r3, r4, r5, r6]
            # D²φr = (sum(φr.(rs)) - 6*φr(r))/(dr^2)
            # D²φi = (sum(φi.(rs)) - 6*φi(r))/(dr^2)

            # @test D²φr ≈ 0.0 atol=1e-4
            # @test D²φi ≈ 0.0 atol=1e-4