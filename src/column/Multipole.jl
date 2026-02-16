"""
"""
struct Multipole{TF <: AbstractMultipoleField} <: AbstractColumnElement
    order::Int64
    field::TF
end


# ::MIME"text/plain"
function Base.show(io::IO, ::MIME"text/plain", m::Multipole)
    Base.show(io::IO, m::Multipole, "      ")
    # compact = get(io, :compact, false)
    # if !compact
    #     Base.show(io::IO, m::Multipole, "      ")
    # else
    #     # Base.show(io::IO, Multipole)
    #     print(io, "Multipole")
    # end
end

 Base.show(io::IO, m::Multipole) = print(io, "Multipole")
function Base.show(io::IO, m::Multipole, pfx)
    f = m.field
    println(pfx[1] * "╦═ Multipole")
    println(pfx[2] * "╠═ order: $(m.order)")
    println(pfx[3] * "╠═ z center: $(f.zcenter)")
    println(pfx[4] * "╠═ radius: $(f.radius)")
    println(pfx[5] * "╠═ length: $(f.length)")
    println(pfx[6] * "╚═ field form: $(f.field_form)")
end
