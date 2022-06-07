########################################
#                                      #
# struct containing all potential data #
#                                      #
########################################
mutable struct Potential

    ndatapoints    ::Int64

    x_unit        ::Unitful.LengthUnits
    potential_unit::Unitful.EnergyUnits

    intervall::Unitful.Length
    
    vec_x    ::Vector{Unitful.Length}

    mat_coords::Matrix{Unitful.Length}

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