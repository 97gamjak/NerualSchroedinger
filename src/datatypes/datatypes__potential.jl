########################################
#                                      #
# struct containing all potential data #
#                                      #
########################################
mutable struct Potential

    ndatapoints::Int64

    intervall::Unitful.Length
    vec_x    ::Vector{Unitful.Length}

    vec_potential::Vector{Unitful.Energy}
    
    Potential() = new()
end

####################################################
#                                                  #
# Wrapper function for calling LinearAlgebra.diagm #
# on a vector of Unitful.Energy                    #
#                                                  #
####################################################

diagm(vector::Vector{Unitful.Energy}) = diagm(ustrip(vector)) .* unit(vector[1])