function calc_neuralnet(storage::Storage)

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

    storage.settings.nstates = 1 #TODO: just for benchmarking if it works with one state!!

    ndatapoints   = storage.potential.ndatapoints
    vec_potential = storage.potential.vec_potential
    mass          = storage.settings.mass
    nstates       = storage.settings.nstates
    nodes         = storage.settings.nodes
    actFunc       = storage.activationFunction

    actFunc.x_min = ustrip(storage.potential.vec_x[1])
    actFunc.x_max = ustrip(storage.potential.vec_x[ndatapoints])

    actFunc.vec_x = ustrip(storage.potential.vec_x)

    for state in 1:nstates

        init_ψ(storage.activationFunction, nodes)        

        calc_ψ(storage.activationFunction)

        norm = integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.^2, SimpsonEven())
        storage.activationFunction.vec_a /= sqrt(norm)

        vec_params = [storage.activationFunction.vec_a; storage.activationFunction.vec_b; storage.activationFunction.vec_c]

        #vec_params =  basinhopping(2, loss_function, storage, vec_params)
        vec_params = bfgs(x -> loss_function(storage, x), vec_params)
            
        calc_ψ(storage.activationFunction)
        norm = integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.^2, SimpsonEven())
        storage.activationFunction.vec_a /= sqrt(norm)
        calc_ψ(storage.activationFunction)
        calc_d2ψ_dx2(storage.activationFunction)
        hamiltonian = -0.5 * ħ^2 / mass * storage.activationFunction.vec_d2ψ_dx2 / u"Å^2" + vec_potential .* storage.activationFunction.vec_ψ
        hamiltonian = ustrip.(uconvert.(u"kcalpermol", hamiltonian))
        expectation = integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.*hamiltonian, SimpsonEven())
        diff_equation = hamiltonian - expectation*storage.activationFunction.vec_ψ
        contr_boundary = (abs(storage.activationFunction.vec_ψ[1]) + abs(storage.activationFunction.vec_ψ[ndatapoints])) / max(abs.(storage.activationFunction.vec_ψ)...)
        contr_diff_equation = mean(abs.(diff_equation))
        contr_expectation = abs(expectation)

        norm = abs(integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.^2, SimpsonEven()))

        loss = contr_boundary + contr_diff_equation + contr_expectation

        println("boundary   ", contr_boundary)
        println("diff_eq    ", contr_diff_equation)
        println("eigenvalue ", contr_expectation)
        println("norm       ", norm)
        println("loss       ", loss)
        println("")

        calc_ψ(actFunc)

        storage.activationFunction = actFunc

        storage.output.vec_eigenvalues = Vector()
        push!(storage.output.vec_eigenvalues, 17.6)

        print_results(storage)

    end

end

function loss_function(storage, vec_params)

    vec_a = vec_params[1:nodes]
    vec_b = vec_params[nodes+1:2*nodes]
    vec_c = vec_params[2*nodes+1:3*nodes]

    storage.activationFunction.vec_a = vec_a
    storage.activationFunction.vec_b = vec_b
    storage.activationFunction.vec_c = vec_c

    nodes         = storage.settings.nodes
    ndatapoints   = storage.potential.ndatapoints
    vec_potential = storage.potential.vec_potential
    mass          = storage.settings.mass

    calc_ψ(storage.activationFunction)

    norm = integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.^2, SimpsonEven())
    storage.activationFunction.vec_a /= sqrt(norm)
    vec_params[1:nodes] = storage.activationFunction.vec_a
    storage.activationFunction.vec_ψ /= sqrt(norm)

    calc_d2ψ_dx2(storage.activationFunction)

    hamiltonian = -0.5 * ħ^2 / mass * storage.activationFunction.vec_d2ψ_dx2 / u"Å^2" + vec_potential .* storage.activationFunction.vec_ψ
    hamiltonian = ustrip.(uconvert.(u"kcalpermol", hamiltonian))

    expectation = integrate(storage.activationFunction.vec_x, storage.activationFunction.vec_ψ.*hamiltonian, SimpsonEven())
    contr_expectation = abs(expectation)

    diff_equation = hamiltonian - expectation*storage.activationFunction.vec_ψ
    contr_diff_equation = mean(abs.(diff_equation))

    contr_boundary = 2*(abs(storage.activationFunction.vec_ψ[1]) + abs(storage.activationFunction.vec_ψ[ndatapoints])) / max(abs.(storage.activationFunction.vec_ψ)...)

    loss = contr_boundary + contr_diff_equation + contr_expectation

    #todo place this within bfgs - less printlns and better controllability
    if(storage.activationFunction.iteration % 1000 == 0)
        println("boundary   ", contr_boundary)
        println("diff_eq    ", contr_diff_equation)
        println("eigenvalue ", contr_expectation)
        println("loss       ", loss)
        println("")
    end

    storage.activationFunction.iteration += 1

    #TODO: make a loss function wrapper and a loss function for each contribution
    return loss

end