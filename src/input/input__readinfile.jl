function readinfile(storage::Storage)

    files = storage.files

    ##################################
    # reading all lines of inputfile #
    ##################################

    files.inputfile = readfile(files.inputfile_name)
    filestream      = readlines(files.inputfile)

    for i in 1:length(filestream)

        #####################
        # deleting comments #
        #####################

        line = filestream[i]
        line = deletecomments(line)

        ###################################################################
        # splitting line and checking number of arguments => has to be 2! #
        ###################################################################
        
        lineelements = split(line)

        if length(lineelements) == 0
            continue                  # if no elements were found - skip line
        end

        if(length(lineelements) > 2)
            ToManyArguments(i, files.inputfile_name)
        elseif(length(lineelements) < 2)
            NotEnoughArguments(i, files.inputfile_name)
        end

        #############################################
        # parse input and check if keyword is valid #
        #############################################

        matchinput(lineelements, i, storage)

    end

end