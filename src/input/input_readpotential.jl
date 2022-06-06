function readpotential(storage::Storage)

    potential_inputfile = readfile(storage.files.potential_inputfile_name)

    filestream = readlines(potential_inputfile)

    vec_x         = Vector{Unitful.Length}()
    vec_potential = Vector{Unitful.Energy}()

    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit

    for line in filestream

        lineelements = split(line)

        push!(vec_x, parse.(Float64, lineelements[1]) * x_unit)
        push!(vec_potential, parse.(Float64, lineelements[2]) * potential_unit)
    end

    storage.potential.vec_x = vec_x
    storage.potential.vec_potential = vec_potential

    storage.potential.intervall = vec_x[2] - vec_x[1]

    storage.potential.ndatapoints = length(vec_x)

end