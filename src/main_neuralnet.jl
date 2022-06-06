function neuralNetwork(args::Vector{String})

    ############################   
    # initalization of storage #
    ############################   

    storage = init()

    ##################################
    # parsing command line arguments #
    ##################################

    commandline_args = parse_commandline(args)

    storage.files.inputfile_name = commandline_args["inputfile"] # setting name of inputfile

    #####################
    # reading inputfile #
    #####################

    readinfile(storage)

    ###############################
    # reading potential inputfile #
    ###############################

    readpotential(storage)

    ####################################
    # initialization of output results #
    ####################################

    init_output(storage)

    #########################################
    # calculation with neural neuralNetwork #
    #                                       #
    #  main calculation is performed here!  #
    #########################################

    calc_neuralnet(storage)

    ####################
    # printing results #
    ####################

    print_results(storage) #TODO: move this printing into loop for possibility to check calculation for each state!

end