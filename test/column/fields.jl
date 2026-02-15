using DiffTracer

@testset "Column Fields" begin
    @testset "Two Lens Column" begin
        multipole_order = 0
        zcenter = 0.0
        radius = 1.0
        length = 1.0
        zmin = 0.0
        zmax = 1.0
        rmin = 0.0
        rmax = 1.0
        ffleft = 1.0
        ffright = 1.0

        params = [
            multipole_order,
            zcenter,
            radius,
            length,
            ffleft,
            ffright,
            zmin,
            zmax,
            rmin,
            rmax,
            :erf,
        ]

        potential = AnalyticMultipoleField(params...)

        l0 = RoundLens(potential)
        params[2] = 0.1
        l1 = RoundLens(AnalyticMultipoleField(params...))
        params[2] = 0.35
        l2 = RoundLens(AnalyticMultipoleField(params...))

        zmin = 0.0
        zmax = 0.4
        column = Column(
            Dict(
                "l0" => l0,
                "l1" => l1,
                "l2" => l2,
            ),
            zmin,
            zmax,
        )

        excitation = Excitation(
            Dict(
                "l0" => 1.0,
                "l1" => 1.0,
                "l2" => 1.0,
            ),
        )
        f = get_fields(column, excitation, 0.0, 0.0, 0.0)

        @test true
    end
end