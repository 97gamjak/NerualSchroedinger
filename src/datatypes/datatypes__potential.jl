mutable struct Potential

    potential ::PotentialEnum
    func      ::Function

    n_datapoints::Int64
    x_start::Float64
    x_end::Float64

    intervall::Float64
    
    stencil::Function

    Potential() = new()
end
