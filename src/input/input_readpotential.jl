function readpotential(storage::Storage)

    potential_inputfile = readfile(storage.files.potential_inputfile_name)

    filestream = readlines(potential_inputfile)

    vec_x = Vector{Unitful.Length}()
    vec_potential = Vector{Unitful.Energy}()

    for line in filestream

        lineelements = split(line)

        push!(vec_x, parse.(Float64, lineelements[1]) * u"Å")
        push!(vec_potential, parse.(Float64, lineelements[2]) * u"kcalpermol")
    end

    storage.potential.vec_x = vec_x
    storage.potential.vec_potential = vec_potential

    storage.potential.intervall = vec_x[2] - vec_x[1]

    storage.potential.ndatapoints = length(vec_x)

end