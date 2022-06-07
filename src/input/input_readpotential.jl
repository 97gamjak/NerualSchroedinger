function readpotential(storage::Storage)

    potential_inputfile = readfile(storage.files.potential_inputfile_name)
    filestream          = readlines(potential_inputfile)

    vec_coords     = Vector{Unitful.Length}()
    vec_x          = Vector{Unitful.Length}()
    vec_potential  = Vector{Unitful.Energy}()

    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit

    dim = storage.settings.dim

    datacounter = 1

    mat_coords = Vector()

    for line in filestream

        #####################
        # deleting comments #
        #####################

        line = deletecomments(line)

        ###################################################################
        # splitting line and checking number of arguments => has to be 2! #
        ###################################################################
        
        lineelements = split(line)

        if length(lineelements) == 0
            continue                  # if no elements were found - skip line
        elseif(length(lineelements) != dim + 1)
            #error
        end

        push!(vec_x, parse.(Float64, lineelements[1]) * x_unit)

        for j in 1:dim
            push!(vec_coords, parse.(Float64, lineelements[j]) * x_unit)
        end

        if(datacounter == 1)
            mat_coords = vec_coords
        else
            mat_coords = hcat(mat_coords, vec_coords)
        end
        
        push!(vec_potential, parse.(Float64, lineelements[end]) * potential_unit)

        datacounter += 1
        vec_coords = Vector{Unitful.Length}()
    end

    storage.potential.vec_x         = vec_x
    storage.potential.mat_coords    = transpose(mat_coords)
    storage.potential.vec_potential = vec_potential
    storage.potential.intervall     = vec_x[2] - vec_x[1]
    storage.potential.ndatapoints   = length(vec_x)

end