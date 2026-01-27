using DiffTracer
using LinearAlgebra

@testset "axial potentials" begin
    test_z_res = 10
    max_order = 8
    zc, R, L, FR, FL = 0.0, 1.0, 1.0, 1.0, 1.0
    field_forms = DiffTracer._field_forms
    zrange = range(-L + zc, L + zc, test_z_res)

    @testset "numerical derivative comparison" begin
        for name in keys(field_forms)
            fields = DiffTracer._get_field(name, max_order) # creates a tuple of length max_order + 1
            @test length(fields) == max_order + 1
            for i in 1:max_order
                f0(z) = fields[i](z, zc, R, L, FR, FL)
                f1(z) = fields[i+1](z, zc, R, L, FR, FL)
                z = zrange
                h = 1e-8
                f0z = (f0.(z .+ h) .- f0.(z .- h)) ./ (2*h)
                f1z = f1.(z)
                e = norm(f0z .- f1z)/norm(f1z)
                @test isapprox(e, 0.0, atol=sqrt(h))
            end
        end
    end
end

