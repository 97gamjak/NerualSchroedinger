#####################################
#                                   #
# struct containing all output data #
#                                   #
#####################################
mutable struct Output
    
    vec_eigenvalues::Vector{Float64}

    mat_eigenvectors::Matrix{Float64}

    Output() = new()
end