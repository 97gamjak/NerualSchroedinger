function neuralNetwork(args::Vector{String})

    storage = init()

    commandline_args = parse_commandline(args)

    storage.files.inputfile_name = commandline_args["inputfile"]

    readinfile(storage)

    ####################################
    #                                  #
    # reading potential from inputfile #
    #                                  #
    ####################################

    readpotential(storage)

    init_output(storage)

    calc_neuralnet(storage)

    print_results(storage)

end