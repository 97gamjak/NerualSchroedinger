include("sys/sys__fileoperations.jl")
include("sys/sys__parse_commandline.jl")
include("sys/sys__stringhandling.jl")
include("sys/sys__excpetions.jl")
include("sys/sys__init.jl")
include("datatypes/datatypes__enums.jl")
include("datatypes/datatypes__files.jl")
include("datatypes/datatypes__inputkeys.jl")
include("datatypes/datatypes__potential.jl")
include("datatypes/datatypes__storage.jl")
include("input/readinfile__numerov.jl")

include("numerov/numerov__calc.jl")

using LinearAlgebra

function numerov(args::Vector{String})

    storage = init()

    commandline_args = parse_commandline(args)

    storage.files.inputfile_name = commandline_args["inputfile"]

    readinfile_numerov(storage)

    calc_numerov(storage)

end

function harmonic(x::Float64)

    return x*x*0.5
    
end