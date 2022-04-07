include("sys/sys__fileoperations.jl")
include("sys/sys__parse_commandline.jl")
include("sys/sys__stringhandling.jl")
include("sys/sys__excpetions.jl")
include("sys/sys__init.jl")
include("datatypes/datatypes__files.jl")
include("datatypes/datatypes__inputkeys.jl")
include("datatypes/datatypes__storage.jl")
include("input/readinfile__numerov.jl")

function numerov(args::Vector{String})

    storage = init()

    commandline_args = parse_commandline(args)

    storage.files.inputfile_name = commandline_args["inputfile"]

    # readinfile_numerov(storage)

end