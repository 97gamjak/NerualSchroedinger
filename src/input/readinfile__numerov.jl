function readinfile_numerov(storage::Storage)

    files = storage.files

    files.inputfile = readfile(files.inputfile)

    for i in 1:length(filestream)

        line = filestream[i]
        line = deletecomments(line)
        
        lineelements = split(line)

        if length(lineelements) == 0
            continue
        end

        if(length(lineelements > 2))
            ToManyArguments(i, files.inputfile_name)
        elseif(length(lineelements) < 2)
            NotEnoughArguments(i, files.inputfile_name)
        end

        matchinput(lineelements, i, storage)

    end

end