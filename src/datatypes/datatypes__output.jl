#####################################
#                                   #
# struct containing all output data #
#                                   #
#####################################
mutable struct Output

    mat_param_a::Matrix{Float64}
    mat_param_b::Matrix{Float64}
    mat_param_c::Matrix{Float64}
    
    vec_eigenvalues::Vector{Float64}

    mat_eigenvectors::Matrix{Float64}

    Output() = new()
end