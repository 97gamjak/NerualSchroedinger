include("potential/matchinput__n_datapoints.jl")
include("potential/matchinput__x_start.jl")
include("potential/matchinput__x_end.jl")
include("potential/matchinput__stencil.jl")
include("potential/matchinput__potential.jl")

function matchinput(lineelements::Vector{SubString{String}}, line::Int64, storage::Storage)

    valid_key = false

    key   = lowercase(lineelements[1])
    value = string(lineelements[2])      # buffer[2] would only be substring

    valid_key = valid_key || parse_potential(key, value, storage)
    valid_key = valid_key || parse_n_datapoints(key, value, storage)
    valid_key = valid_key || parse_x_start(key, value, storage)
    valid_key = valid_key || parse_x_end(key, value, storage)
    valid_key = valid_key || parse_stencil(key, value, storage)

    if(!valid_key)
        @error ("Unknown keyword " * key * " in line " * string(line) * " in input file")
        exit(1)
    end
end