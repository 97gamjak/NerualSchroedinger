function calc_neural_potential(storage::Storage)

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

    actFunc = storage.activationFunction

    nodes = storage.settings.nodes

    actFunc.vec_x = ustrip(storage.potential.vec_x)

    actFunc.iteration = 1

    init_y(storage.activationFunction, nodes)
    
    calc_y(storage.activationFunction)

    vec_params = [storage.activationFunction.vec_a; storage.activationFunction.vec_b; storage.activationFunction.vec_c]

    vec_params = bfgs(x -> loss_function_pot(storage, x), vec_params)

    calc_y(actFunc)

    storage.activationFunction = actFunc

    storage.output.mat_eigenvectors[:,1] = actFunc.vec_y
    storage.output.mat_param_a[:,1]      = actFunc.vec_a
    storage.output.mat_param_b[:,1]      = actFunc.vec_b
    storage.output.mat_param_c[:,1]      = actFunc.vec_c

    print_results(storage)

end

function loss_function_pot(storage, vec_params)

    nodes = storage.settings.nodes

    vec_a = vec_params[1:nodes]
    vec_b = vec_params[nodes+1:2*nodes]
    vec_c = vec_params[2*nodes+1:3*nodes]

    storage.activationFunction.vec_a = vec_a
    storage.activationFunction.vec_b = vec_b
    storage.activationFunction.vec_c = vec_c

    calc_y(storage.activationFunction)

    pot_max = ustrip(maximum(abs.(storage.potential.vec_potential)))
    #loss = sqrt(sum((storage.activationFunction.vec_y-ustrip(storage.potential.vec_potential)).^2)/ndatapoints)
    loss = sqrt(sum((storage.activationFunction.vec_y-ustrip(storage.potential.vec_potential)).^2)/pot_max)
    #loss = sqrt(sum(x -> (storage.activationFunction.vec_y[x]-ustrip(storage.potential.vec_potential[x]))^2/(abs(ustrip(storage.potential.vec_potential[x]))*exp10(-5)), 1:length(storage.potential.vec_potential)))

    if(storage.activationFunction.iteration % 1000 == 0)
        println("loss       ", loss)
        println("")
    end

    storage.activationFunction.iteration += 1

    #TODO: make a loss function wrapper and a loss function for each contribution
    return loss

end