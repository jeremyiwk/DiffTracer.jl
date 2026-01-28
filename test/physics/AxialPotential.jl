using LinearAlgebra
using ForwardDiff
using DiffTracer

@testset "axial potentials" begin
    test_z_res = 10
    max_order = DiffTracer.MAX_Z_DERIVATIVE
    zc, R, L, FR, FL = 0.0, 1.0, 1.0, 1.0, 1.0
    field_forms = DiffTracer._field_forms

    @testset "autodiff derivative comparison" begin
        for name in keys(field_forms)
            fields = DiffTracer._get_field(name, max_order) # creates a tuple of length max_order + 1
            @test length(fields) == max_order + 1
            for i in 1:max_order
                f0(z) = fields[i](z, zc, R, L, FR, FL)
                f1(z) = fields[i+1](z, zc, R, L, FR, FL)
                adf1(z) = ForwardDiff.derivative(f0, z)

                @test adf1(zc) ≈ f1(zc)
                @test adf1(zc + L) ≈ f1(zc + L)
                @test adf1(zc - L) ≈ f1(zc - L)
            end
        end
    end
end

