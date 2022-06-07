function matchinput(lineelements::Vector{SubString{String}}, line::Int64, storage::Storage)

    valid_key = false

    key   = lowercase(lineelements[1])
    value = string(lineelements[2])      # lineelements[2] would only be substring

    ####################
    # parsing keywords #
    ####################

    valid_key = valid_key || parse_nstates(key, value, storage)

    valid_key = valid_key || parse_dim(key, value, storage)

    valid_key = valid_key || parse_potential_inputfile(key, value, storage)
    valid_key = valid_key || parse_eigenvaluefile(key, value, storage)
    
    valid_key = valid_key || parse_directory(key, value, storage)

    ###################################
    # NeuralNetwork specific keywords #
    ###################################

    valid_key = valid_key || parse_jobtype(key, value, storage)

    valid_key = valid_key || parse_nodes(key, value, storage)
    valid_key = valid_key || parse_potential_nodes(key, value, storage)

    #############################
    # Numerov specific keywords #
    #############################

    valid_key = valid_key || parse_stencil(key, value, storage)

    ##########################################
    # check if key was found in keyword list #
    ##########################################

    if(!valid_key)
        @error ("Unknown keyword " * key * " in line " * string(line) * " in input file")
        exit(1)
    end

end