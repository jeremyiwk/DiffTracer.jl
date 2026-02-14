using DiffTracer

@testset "AnalyticMultipoleField" begin
    n = 4
    AnalyticMultipoleField(
        n,
        0.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        :erf
    )
end
