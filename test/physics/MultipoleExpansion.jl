using DiffTracer
@testset "eval" begin
    for ν in 0:DiffTracer.MAX_MULTIPOLE_ORDER,
        λ in 0:DiffTracer.MAX_DERIVATIVE_ORDER

        x, y = randn(2)
        field = DiffTracer.multipole_expansion[(ν, λ)]

        @test field.φ(x,y) isa Number
        @test field.Ex(x,y) isa Number
        @test field.Ey(x,y) isa Number
    end
end