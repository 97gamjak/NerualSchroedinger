###########################################
#                                         #
# struct containing all laplace info data #
#                                         #
###########################################
mutable struct Laplace
    
    stencil::Int64

    func_stencil::Function

    Laplace() = new()
end

eigen(matrix::Matrix{T}) where T<:Unitful.Energy = eigen(ustrip.(matrix))