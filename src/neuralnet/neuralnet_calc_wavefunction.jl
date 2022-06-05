function calc_neural_wavefunction(storage::Storage)

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

    ndatapoints    = storage.potential.ndatapoints
    vec_potential  = storage.potential.vec_potential
    mass           = storage.settings.mass
    nstates        = storage.settings.nstates
    nodes          = storage.settings.nodes
    actFunc        = storage.activationFunction
    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit

    actFunc.vec_x  = ustrip(storage.potential.vec_x)

    for state in 1:nstates

        init_y(actFunc, nodes)        

        calc_y(actFunc)

        actFunc.norm   = sqrt(integrate(actFunc.vec_x, actFunc.vec_y.^2, SimpsonEven()))
        actFunc.vec_a /= actFunc.norm
        actFunc.vec_y /= actFunc.norm

        vec_params = [actFunc.vec_a; actFunc.vec_b; actFunc.vec_c]

        #vec_params =  basinhopping(2, loss_function, storage, vec_params)
        vec_params = bfgs(x -> loss_function(storage, x), vec_params)
            
        calc_y(actFunc)

        actFunc.norm   = sqrt(integrate(actFunc.vec_x, actFunc.vec_y.^2, SimpsonEven()))
        actFunc.vec_a /= actFunc.norm
        actFunc.vec_y /= actFunc.norm
        
        calc_d2y_dx2(actFunc)

        hamiltonian = -0.5 * ħ^2 / mass * actFunc.vec_d2y_dx2 / x_unit^2 + vec_potential .* actFunc.vec_y
        hamiltonian = ustrip.(uconvert.(potential_unit, hamiltonian))

        expectation       = integrate(actFunc.vec_x, actFunc.vec_y.*hamiltonian, SimpsonEven())
        contr_expectation = abs(expectation)

        diff_equation       = hamiltonian - expectation*actFunc.vec_y
        contr_diff_equation = mean(abs.(diff_equation))

        contr_boundary = (abs(actFunc.vec_y[1]) + abs(actFunc.vec_y[ndatapoints])) / max(abs.(actFunc.vec_y)...)

        loss = contr_boundary + contr_diff_equation + contr_expectation

        actFunc = actFunc

        storage.output.vec_eigenvalues = Vector()
        push!(storage.output.vec_eigenvalues, 17.6)

        print_results(storage)

    end

end

function loss_function(storage, vec_params)

    nodes          = storage.settings.nodes
    ndatapoints    = storage.potential.ndatapoints
    vec_potential  = storage.potential.vec_potential
    mass           = storage.settings.mass
    x_unit         = storage.potential.x_unit
    potential_unit = storage.potential.potential_unit
    actFunc        = storage.activationFunction

    vec_a = vec_params[1:nodes]
    vec_b = vec_params[nodes+1:2*nodes]
    vec_c = vec_params[2*nodes+1:3*nodes]

    actFunc.vec_a = vec_a
    actFunc.vec_b = vec_b
    actFunc.vec_c = vec_c

    calc_y(actFunc)

    norm                = sqrt(integrate(actFunc.vec_x, actFunc.vec_y.^2, SimpsonEven()))
    actFunc.vec_a      /= norm
    actFunc.vec_y      /= norm
    vec_params[1:nodes] = actFunc.vec_a

    calc_d2y_dx2(actFunc)

    hamiltonian = -0.5 * ħ^2 / mass * actFunc.vec_d2y_dx2 / x_unit^2 + vec_potential .* actFunc.vec_y
    hamiltonian = ustrip.(uconvert.(potential_unit, hamiltonian))

    expectation       = integrate(actFunc.vec_x, actFunc.vec_y.*hamiltonian, SimpsonEven())
    contr_expectation = abs(expectation)

    diff_equation       = hamiltonian - expectation*actFunc.vec_y
    contr_diff_equation = mean(abs.(diff_equation))

    contr_boundary = 2*(abs(actFunc.vec_y[1]) + abs(actFunc.vec_y[ndatapoints])) / max(abs.(actFunc.vec_y)...)

    loss = contr_boundary + contr_diff_equation + contr_expectation

    #todo place this within bfgs - less printlns and better controllability
    if(actFunc.iteration % 1000 == 0)
        println("boundary   ", contr_boundary)
        println("diff_eq    ", contr_diff_equation)
        println("eigenvalue ", contr_expectation)
        println("loss       ", loss)
        println("")
    end

    actFunc.iteration += 1

    #TODO: make a loss function wrapper and a loss function for each contribution
    return loss

end