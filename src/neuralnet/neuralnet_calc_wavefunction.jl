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

    actFunc.coords  = ustrip(storage.potential.x) #removing unit of energy for minimization

    #################################################################
    # calculation loop for requested number of states - default = 1 #
    #################################################################

    for state in 1:nstates

        ################################################
        # initialization of activation function params #
        # TODO: at the moment only random implemented  #
        ################################################

        init_f(actFunc, nodes, state)        

        #############################################################
        # calculation of activation function at input grid points   #
        # TODO: try to use potentialNN approach as further approach #
        #############################################################

        calc_f(actFunc)

        ###########################################
        # Normalize generated activation function #
        # and set initial params for minimizer    #
        ###########################################

        params = [actFunc.a; actFunc.b; actFunc.c]
        normalize_f(storage, params)

        #################################
        # actual optimization           #
        # TODO: implement basin hopping #
        #################################

        params = bfgs(x -> loss_function(storage, x), params)
            
        calc_f(actFunc)

        normalize_f(storage, params)

        calc_laplace_f(actFunc)

        hamiltonian = calc_hamiltonian_f(storage)

        eigenvalue       = integrate(actFunc.coords, actFunc.f.*hamiltonian, SimpsonEven())
        contr_eigenvalue = abs(eigenvalue)

        diffequation   = hamiltonian - eigenvalue*actFunc.f
        contr_diffequation = mean(abs.(diffequation))

        contr_boundary = (abs(actFunc.f[1]) + abs(actFunc.f[ndatapoints])) / max(abs.(actFunc.f)...)

        loss = contr_boundary + contr_diffequation + contr_eigenvalue

        push!(storage.output.eigenvalues, eigenvalue)
        storage.output.mat_eigenvectors[:,state] = actFunc.f
        storage.output.mat_param_a[:,state]      = actFunc.a
        storage.output.mat_param_b[:,state]      = actFunc.b
        storage.output.mat_param_c[:,state]      = actFunc.c

    end

    print_results(storage)

end

function loss_function(storage::Storage, params::Vector{Float64})

    nodes          = storage.settings.nodes
    ndatapoints    = storage.potential.ndatapoints
    actFunc        = storage.activationFunction

    a = params[1:nodes]
    b = params[nodes+1:2*nodes]
    c = params[2*nodes+1:3*nodes]

    actFunc.a = a
    actFunc.b = b
    actFunc.c = c

    calc_y(actFunc)

    normalize_y(storage, params)

    calc_d2y_dx2(actFunc)

    hamiltonian = calc_hamiltonian_y(storage)

    eigenvalue       = integrate(actFunc.x, actFunc.y.*hamiltonian, SimpsonEven())
    contr_eigenvalue = abs(eigenvalue)

    diffequation   = hamiltonian - eigenvalue*actFunc.y
    contr_diffequation = mean(abs.(diffequation))

    contr_boundary = 2*(abs(actFunc.y[1]) + abs(actFunc.y[ndatapoints])) / maximum(abs.(actFunc.y))

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

function normalize_f(storage::Storage, params::Vector{Float64})

    actFunc = storage.activationFunction
    nodes   = storage.settings.nodes

    actFunc.norm     = sqrt(integrate(actFunc.coords, actFunc.f.^2, SimpsonEven()))   #TODO: integration of activation function to be used!
    actFunc.a       /= actFunc.norm
    actFunc.y       /= actFunc.norm
    params[1:nodes]  = actFunc.a
end

function calc_hamiltonian_f(storage::Storage)

    potential      = storage.potential.potential
    mass           = storage.settings.mass
    actFunc        = storage.activationFunction
    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit

    hamiltonian = -0.5 * ħ^2 / mass * actFunc.laplace_f / x_unit^2 + potential .* actFunc.f
    
    return ustrip.(uconvert.(potential_unit, hamiltonian))
end