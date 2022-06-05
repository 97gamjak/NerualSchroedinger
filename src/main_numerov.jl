function numerov(args::Vector{String})

    storage = init()

    commandline_args = parse_commandline(args)

    storage.files.inputfile_name = commandline_args["inputfile"]

    readinfile(storage)

    if(storage.laplace.stencil == 3)
        storage.laplace.func_stencil = stencil_3
    elseif(storage.laplace.stencil == 5)
        storage.laplace.func_stencil = stencil_5
    elseif(storage.laplace.stencil == 7)
        storage.laplace.func_stencil = stencil_7
    elseif(storage.laplace.stencil == 9)
        storage.laplace.func_stencil = stencil_9
    end

    calc_numerov(storage)

    print_results(storage)

end