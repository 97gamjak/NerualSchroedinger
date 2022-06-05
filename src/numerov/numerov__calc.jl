function calc_numerov(storage::Storage)

    ####################################
    #                                  #
    # reading potential from inputfile #
    #                                  #
    ####################################

    readpotential(storage)

    ################################
    #                              #
    # retrieving data from storage #
    #                              #
    ################################

    ndatapoints   = storage.potential.ndatapoints
    intervall     = storage.potential.intervall
    vec_potential = storage.potential.vec_potential
    mass          = storage.settings.mass

    ##################################
    #                                #
    # creating kinetic energy matrix #
    #                                #
    ##################################

    mat_laplace = -0.5 * ħ^2 / mass * storage.laplace.func_stencil(ndatapoints)/intervall^2

    ####################################
    #                                  #
    # creating potential energy matrix #
    #                                  #
    ####################################

    mat_potential = diagm(vec_potential)

    ###############################
    #                             #
    # creating hamiltonian matrix #
    #                             #
    ###############################

    mat_hamiltonian = mat_laplace + mat_potential

    mat_hamiltonian = uconvert.(u"kcalpermol",  mat_hamiltonian)

    decomposition = eigen(mat_hamiltonian) # pay attention here the Eigen struct is returned without units!!!

    storage.output.vec_eigenvalues  = decomposition.values
    storage.output.mat_eigenvectors = decomposition.vectors

end

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