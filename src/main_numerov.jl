include("sys/sys__fileoperations.jl")
include("sys/sys__parse_commandline.jl")
include("exceptions/exceptions__filenotfound.jl")
include("datatypes/datatypes__files.jl")
include("datatypes/datatypes__storage.jl")
include("readinput/readinput__numerov.jl")

function numerov(args::Vector{String})

    storage       = Storage()
    storage.files = Files()

    parse_commandline(args)
    #readinput_numerov(storage)

end