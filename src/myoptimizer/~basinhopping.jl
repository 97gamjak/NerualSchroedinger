using Distributions

function basinhopping(iter::Int64, loss_function, storage, vec_params)

    vec_params_optimal = copy(vec_params)
    vec_params_i = copy(vec_params)
    old_loss = loss_function(storage, vec_params)

    for i in 1:iter
        vec_params_i = bfgs(x -> loss_function(storage, x), vec_params_i)

        loss = loss_function(storage, vec_params_i)

        if(loss < old_loss)
            vec_params_optimal = copy(vec_params_i)
            old_loss = loss
            println("nice")
        end

        vec_params_i = copy(vec_params_optimal) + rand(Uniform(-100, 100), length(vec_params))
    end

    return vec_params_optimal
    
end