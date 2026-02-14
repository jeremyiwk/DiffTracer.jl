
"""
    struct AnalyticMultipoleField
"""
struct AnalyticMultipoleField{T} <: AbstractMultipoleField
    multipole_order::Int64
    zcenter::T
    radius::T
    length::T
    ffleft::T
    ffright::T
    zmin::T
    zmax::T
    rmin::T
    rmax::T
    field_form::Symbol
    field::Field

    function AnalyticMultipoleField(
            multipole_order::Int64,
            zcenter::T,
            radius::T,
            length::T,
            ffleft::T,
            ffright::T,
            zmin::T,
            zmax::T,
            rmin::T,
            rmax::T,
            field_form::Symbol
    ) where {T}
        generic_fields = FIELDS[field_form][multipole_order]
        zc = zcenter
        R = radius
        L = length
        FL = ffleft
        FR = ffright
        φr(x, y, z) = generic_fields.φr(x, y, z, zc, R, L, FR, FL)
        Exr(x, y, z) = generic_fields.Exr(x, y, z, zc, R, L, FR, FL)
        Eyr(x, y, z) = generic_fields.Eyr(x, y, z, zc, R, L, FR, FL)
        Ezr(x, y, z) = generic_fields.Ezr(x, y, z, zc, R, L, FR, FL)
        φi(x, y, z) = generic_fields.φi(x, y, z, zc, R, L, FR, FL)
        Exi(x, y, z) = generic_fields.Exi(x, y, z, zc, R, L, FR, FL)
        Eyi(x, y, z) = generic_fields.Eyi(x, y, z, zc, R, L, FR, FL)
        Ezi(x, y, z) = generic_fields.Ezi(x, y, z, zc, R, L, FR, FL)
        field = Field(
            φr = φr, Exr = Exr, Eyr = Eyr, Ezr = Ezr,
            φi = φi, Exi = Exi, Eyi = Eyi, Ezi = Ezi
        )
        return new{T}(
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
            field_form,
            field
        )
    end
end
