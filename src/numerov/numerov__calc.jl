include("numerov__laplace.jl")

function calc_numerov(storage::Storage)

    x_start = storage.potential.x_start
    x_end = storage.potential.x_end
    n_datapoints = storage.potential.n_datapoints

    intervall = (x_end - x_start) / (n_datapoints - 1)

    storage.potential.intervall = intervall

    x_data = Vector{Float64}()
    potential_vector = Vector{Float64}()

    for i in 0:n_datapoints-1
        push!(x_data, x_start + i*intervall)
        push!(potential_vector, storage.potential.func(x_start + i*intervall))
    end

    laplace = storage.potential.stencil(n_datapoints)/intervall^2

    hamiltonian = -0.5 * laplace + diagm(potential_vector)

    println(eigvals(hamiltonian)[1:5])


end