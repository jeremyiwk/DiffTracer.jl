"""
"""
struct RoundLens{TF <: AbstractMultipoleField} <: AbstractColumnElement
    field::TF
end

function _show(io::IO, r::RoundLens, pfx)
    f = r.field
    println(pfx[1] * "╦═ Round Lens")
    println(pfx[2] * "╠═ z center: $(f.zcenter)")
    println(pfx[3] * "╠═ radius: $(f.radius)")
    println(pfx[4] * "╠═ length: $(f.length)")
    println(pfx[5] * "╚═ field form: $(f.field_form)")
end

Base.show(io::IO, r::RoundLens) = print(io, "$(typeof(r))")
Base.show(io::IO, ::MIME"text/plain", r::RoundLens) = _show(io::IO, r::RoundLens, "     ")