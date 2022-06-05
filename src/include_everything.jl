function include_files(path::String, file::IOStream)
    directories = filter(isdir, joinpath.(path, readdir(path)))

    #directories = filter(x->x != joinpath(path, "datatypes"), directories)



    for directory in directories

        include_files(directory, file)

        for path_to_file in filter(!isdir, joinpath.(directory, readdir(directory)))
            path_to_file = chop(path_to_file, head=length(@__DIR__) + 1, tail = 0)  #NOTE: +1 due to the ending / of file path
            println(file, "include(\"" * path_to_file * "\")")
        end
    end
end

file = open("files_to_include.jl", "w")

#println(file, "include(\"datatypes/datatypes__include.jl\")")

include_files(@__DIR__, file)