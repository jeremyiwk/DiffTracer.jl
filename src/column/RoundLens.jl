"""
"""
struct RoundLens{TF <: AbstractMultipoleField} <: AbstractColumnElement
    field::TF
end

function Base.show(io::IO, r::RoundLens)
    compact = get(io, :compact, false)
    if !compact
        Base.show(io::IO, r::RoundLens, "     ")
    else
        print(io, "Round Lens")
    end
end

function Base.show(io::IO, r::RoundLens, pfx)
    f = r.field
    println(pfx[1] * "╦═ Round Lens")
    println(pfx[2] * "╠═ z center: $(f.zcenter)")
    println(pfx[3] * "╠═ radius: $(f.radius)")
    println(pfx[4] * "╠═ length: $(f.length)")
    println(pfx[5] * "╚═ field form: $(f.field_form)")
end
