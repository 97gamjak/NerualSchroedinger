function readinput_numerov(storage::Storage)

    files = storage.files

    files.inputfile_name = ARGS[1]

    files.inputfile = readfile(files.inputfile_name)

    for i in readlines(files.inputfile)
        println(i)
    end

end