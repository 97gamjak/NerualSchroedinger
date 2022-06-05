#####################################
#                                   #
# struct containing all output data #
#                                   #
#####################################
mutable struct Output

    vec_param_a::Vector{Float64}
    vec_param_b::Vector{Float64}
    vec_param_c::Vector{Float64}
    
    vec_eigenvalues::Vector{Float64}

    mat_eigenvectors::Matrix{Float64}

    Output() = new()
end