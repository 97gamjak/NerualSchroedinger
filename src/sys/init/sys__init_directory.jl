function init_directory(storage::Storage)
    
    files_in_dir = readdir()

    directory = storage.files.directory

    dir_count = 1
    dir_exists = true

    while (dir_exists)

        if(dir_count < 10)
            directory = storage.files.directory * "-0" * string(dir_count)
        elseif(dir_count < 100)
            directory = storage.files.directory * "-" * string(dir_count)
        else
            ToManyDirectories(storage.files.directory)
        end

        dir_exists = directory ∈ files_in_dir

        dir_count += 1
    end

    mkdir(directory)

    storage.files.directory = directory
end