using DiffTracer

@testset "axial potentials" begin
    test_z_res = 100
    max_order = 8
    zc, R, L, FR, FL = 0.0, 1.0, 1.0, 1.0, 1.0
    field_forms = DiffTracer._field_forms
    zrange = range(-L + zc, L + zc, test_z_res)

    @test length(field_forms) == max_order + 1

    for name in keys(field_forms)
        fields = DiffTracer._get_field(name, max_order) # creates a tuple of length max_order + 1
        for i in 1:max_order
            f0(z) = fields[i](z, zc, R, L, FR, FL)
            f1(z) = fields[i+1](z, zc, R, L, FR, FL)
            for T in (Float32, Float64)
                h = eps(T)
                z = T.(zrange)
                f0z = (f0.(z .+ h) .- f0.(z .- h)) ./ (2*h)
                f1z = f1.(z)
                @test f0z .≈ f1z
            end
        end
    end
end

