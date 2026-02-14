
abstract type AbstractColumn end

function get_fields(c::AbstractColumn, x, y, z) end
function get_fields(m::AbstractColumn, r::SVector{3, T}) where {T} end

abstract type AbstractColumnElement end

function get_fields(e::AbstractColumnElement, x, y, z) end
function get_fields(m::AbstractColumnElement, r::SVector{3, T}) where {T} end

abstract type AbstractMultipoleField end

function get_fields(m::AbstractMultipoleField, x, y, z) end
function get_fields(m::AbstractMultipoleField, r::SVector{3, T}) where {T} end
