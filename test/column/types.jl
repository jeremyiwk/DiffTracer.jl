using DiffTracer

@testset "Column Elements" begin
    for field_form in DiffTracer._names
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

        potential = AnalyticMultipoleField(
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
            field_form
        )

        lens = RoundLens(potential)
        for i in 0:(DiffTracer.MAX_MULTIPOLE_ORDER)
            potential = AnalyticMultipoleField(
                i,
                zcenter,
                radius,
                length,
                ffleft,
                ffright,
                zmin,
                zmax,
                rmin,
                rmax,
                field_form
            )
            mp = Multipole(i, potential)
            @test true
        end
    end
end
