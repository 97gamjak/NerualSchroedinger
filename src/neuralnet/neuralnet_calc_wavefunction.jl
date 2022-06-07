function calc_neural_wavefunction(storage::Storage)

    ################################
    #                              #
    # retrieving data from storage #
    #                              #
    ################################

    ndatapoints    = storage.potential.ndatapoints
    nstates        = storage.settings.nstates
    nodes          = storage.settings.nodes
    actFunc        = storage.activationFunction

    actFunc.vec_x  = ustrip(storage.potential.vec_x) #removing unit of energy for minimization

    #################################################################
    # calculation loop for requested number of states - default = 1 #
    #################################################################

    for state in 1:nstates

        ################################################
        # initialization of activation function params #
        # TODO: at the moment only random implemented  #
        ################################################

        init_y(actFunc, nodes)        

        #############################################################
        # calculation of activation function at input grid points   #
        # TODO: try to use potentialNN approach as further approach #
        #############################################################

        calc_y(actFunc)

        ###########################################
        # Normalize generated activation function #
        # and set initial params for minimizer    #
        ###########################################

        vec_params = [actFunc.vec_a; actFunc.vec_b; actFunc.vec_c]
        normalize_y(storage, vec_params)

        #################################
        # actual optimization           #
        # TODO: implement basin hopping #
        #################################

        #vec_params =  basinhopping(2, loss_function, storage, vec_params)
        vec_params = bfgs(x -> loss_function(storage, x), vec_params)
            
        calc_y(actFunc)

        normalize_y(storage, vec_params)

        calc_d2y_dx2(actFunc)

        vec_hamiltonian = calc_hamiltonian_y(storage)

        eigenvalue       = integrate(actFunc.vec_x, actFunc.vec_y.*vec_hamiltonian, SimpsonEven())
        contr_eigenvalue = abs(eigenvalue)

        vec_diffequation   = vec_hamiltonian - eigenvalue*actFunc.vec_y
        contr_diffequation = mean(abs.(vec_diffequation))

        contr_boundary = (abs(actFunc.vec_y[1]) + abs(actFunc.vec_y[ndatapoints])) / max(abs.(actFunc.vec_y)...)

        loss = contr_boundary + contr_diffequation + contr_eigenvalue

        push!(storage.output.vec_eigenvalues, eigenvalue)
        storage.output.mat_eigenvectors[:,state] = actFunc.vec_y
        storage.output.mat_param_a[:,state]      = actFunc.vec_a
        storage.output.mat_param_b[:,state]      = actFunc.vec_b
        storage.output.mat_param_c[:,state]      = actFunc.vec_c

    end

    print_results(storage)

end

function loss_function(storage::Storage, vec_params::Vector{Float64})

    nodes          = storage.settings.nodes
    ndatapoints    = storage.potential.ndatapoints
    actFunc        = storage.activationFunction

    vec_a = vec_params[1:nodes]
    vec_b = vec_params[nodes+1:2*nodes]
    vec_c = vec_params[2*nodes+1:3*nodes]

    actFunc.vec_a = vec_a
    actFunc.vec_b = vec_b
    actFunc.vec_c = vec_c

    calc_y(actFunc)

    normalize_y(storage, vec_params)

    calc_d2y_dx2(actFunc)

    vec_hamiltonian = calc_hamiltonian_y(storage)

    eigenvalue       = integrate(actFunc.vec_x, actFunc.vec_y.*vec_hamiltonian, SimpsonEven())
    contr_eigenvalue = abs(eigenvalue)

    vec_diffequation   = vec_hamiltonian - eigenvalue*actFunc.vec_y
    contr_diffequation = mean(abs.(vec_diffequation))

    contr_boundary = 2*(abs(actFunc.vec_y[1]) + abs(actFunc.vec_y[ndatapoints])) / maximum(abs.(actFunc.vec_y))

    loss = contr_boundary + contr_diffequation + contr_eigenvalue

    #TODO: place this within bfgs - less printlns and better controllability
    if(actFunc.iteration % 1000 == 0)
        println("boundary   ", contr_boundary)
        println("diff_eq    ", contr_diffequation)
        println("eigenvalue ", contr_eigenvalue)
        println("norm       ", actFunc.norm)
        println("loss       ", loss)
        println("")
    end

    actFunc.iteration += 1

    #TODO: make a loss function wrapper and a loss function for each contribution
    return loss

end

function normalize_y(storage::Storage, vec_params::Vector{Float64})

    actFunc = storage.activationFunction
    nodes   = storage.settings.nodes

    actFunc.norm        = sqrt(integrate(actFunc.vec_x, actFunc.vec_y.^2, SimpsonEven()))
    actFunc.vec_a      /= actFunc.norm
    actFunc.vec_y      /= actFunc.norm
    vec_params[1:nodes] = actFunc.vec_a
end

function calc_hamiltonian_y(storage::Storage)

    vec_potential  = storage.potential.vec_potential
    mass           = storage.settings.mass
    actFunc        = storage.activationFunction
    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit

    vec_hamiltonian = -0.5 * ħ^2 / mass * actFunc.vec_d2y_dx2 / x_unit^2 + vec_potential .* actFunc.vec_y
    
    return ustrip.(uconvert.(potential_unit, vec_hamiltonian))
end