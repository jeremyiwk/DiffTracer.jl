"""
"""
struct RoundLens{TF <: AbstractMultipoleField} <: AbstractColumnElement
    field::TF
end

function Base.show(io::IO, r::RoundLens)
    Base.show(io::IO, r::RoundLens, "     ")
end

function Base.show(io::IO, r::RoundLens, pfx)
    f = r.field
    println(pfx[1] * "╦═ Round Lens")
    println(pfx[2] * "╠═ z center: $(f.zcenter)")
    println(pfx[3] * "╠═ radius: $(f.radius)")
    println(pfx[4] * "╠═ length: $(f.length)")
    println(pfx[5] * "╚═ field form: $(f.field_form)")
end
