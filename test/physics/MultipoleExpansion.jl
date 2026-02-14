

# # function get_field(x, y, z)
# #     return sum([
# #         f0(z) = fields[2*λ](z, zc, R, L, FR, FL) DiffTracer.multipole_expansion[(ν, λ)]
# #         for ν in 0:DiffTracer.MAX_MULTIPOLE_ORDER,
# #             λ in 0:round(Int, DiffTracer.MAX_DERIVATIVE_ORDER / 2)
# #     ])
# # end

# @testset "eval" begin
#     for ν in 0:DiffTracer.MAX_MULTIPOLE_ORDER,
#         λ in 0:DiffTracer.MAX_DERIVATIVE_ORDER

#         x, y = randn(2)
#         field = DiffTracer.multipole_expansion[(ν, λ)]

#         @test field.φ(x,y) isa Number
#         @test field.Ex(x,y) isa Number
#         @test field.Ey(x,y) isa Number
#     end
# end

# using ForwardDiff
# using DiffTracer

# @testset "Axial Potentials" begin
#     max_order = DiffTracer.MAX_DERIVATIVE_ORDER
#     zc, R, L, FR, FL = 0.0, 1.0, 1.0, 1.0, 1.0
#     field_forms = DiffTracer._field_forms
#     for name in keys(field_forms)
#         @testset "AD comparison, field: $(name)" begin
#             fields = DiffTracer._get_field(name, max_order) # creates a tuple of length max_order + 1
#             @test length(fields) == max_order + 1
#             for i in 1:max_order
#                 f0(z) = fields[i](z, zc, R, L, FR, FL)
#                 f1(z) = fields[i+1](z, zc, R, L, FR, FL)
#                 adf1(z) = ForwardDiff.derivative(f0, z)

#                 # test endpoint because f(z) ≈ 0
#                 @test adf1(zc + L) ≈ f1(zc + L)
#                 @test adf1(zc - L) ≈ f1(zc - L)
#             end
#         end
#     end
# end
