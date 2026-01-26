using DiffTracer

@testset "Column Elements" begin
    zcenter = 0.0
    radius = 1.0
    length = 1.0
    zmin = 0.0
    zmax = 1.0
    rmin = 0.0
    rmax = 1.0
    ffleft = 1.0
    ffright = 1.0
    field_form = :erf
    
    potential = AnalyticAxialPotential(
        zcenter = 0.0,
        radius = 1.0,
        length = 1.0,
        zmin = 0.0,
        zmax = 1.0,
        rmin = 0.0,
        rmax = 1.0,
        ffleft = 1.0,
        ffright = 1.0,
        field_form = :erf,
    )

    lens = RoundLens(potential)
    mp = MultipoleField(4, potential)
end