#######################################################
#                                                     #
# struct containing all sine activation function data #
#                                                     #
#######################################################
mutable struct Sine <: ActivationFunction

    vec_a::Vector{Float64}
    vec_b::Vector{Float64}
    vec_c::Vector{Float64}

    vec_ψ::Vector{Float64}
    vec_dψ_dx::Vector{Float64}
    vec_d2ψ_dx2::Vector{Float64}

    vec_x::Vector{Float64}

    integration::Function  # TODO: at the moment not used!

    x_min::Float64  # TODO: at the moment not used!  
    x_max::Float64  # TODO: at the moment not used!

    norm::Float64  # TODO: at the moment not used properly... but implemented

    iteration::Int64

    Sine() = new()
end

############################################################
#                                                          #
# function to initialize sine activation function randomly #
#                                                          #
############################################################
function init_ψ(sine::Sine, nodes::Int64)
    weird_number1 = sqrt(6) #divided by number of nodes in sqrt???
    weird_number2 = 30

    sine.vec_a = rand(Uniform(0, 2), nodes)
    sine.vec_b = weird_number2 .* rand(Uniform(-weird_number1, weird_number1), nodes)
    sine.vec_c = rand(Uniform(0, 2*π), nodes)
end

###########################################################
#                                                         #
# function to calculate activation function of grid vec_x #
#                                                         #
#                   ψ = ∑ᵢ aᵢ*sin(bᵢx + cᵢ)               #
#                                                         #
###########################################################
function calc_ψ(sine::Sine)
    sine.vec_ψ = Vector()
    for x in sine.vec_x
        push!(sine.vec_ψ, sum(sine.vec_a.*sin.(sine.vec_b*x .+ sine.vec_c)))
    end
end

########################################################
#                                                      #
# function to calculate first derivative of activation #
# function of grid vec_x                               # 
#                                                      #
#               dψ/dx = ∑ᵢ aᵢ*bᵢ*cos(bᵢx + cᵢ)         #
#                                                      #
########################################################
function calc_dψ_dx(sine::Sine)
    sine.vec_dψ_dx = Vector()
    for x in sine.vec_x
        push!(sine.vec_dψ_dx, sum(sine.vec_a.*sine.vec_b.*cos.(sine.vec_a*x .+ sine.vec_c)))
    end
end

#########################################################
#                                                       #
# function to calculate second derivative of activation #
# function of grid vec_x                                # 
#                                                       #
#            d²ψ/dx² = -∑ᵢ aᵢ*b²ᵢ*sin(bᵢx + cᵢ)         #
#                                                       #
#########################################################
function calc_d2ψ_dx2(sine::Sine)
    sine.vec_d2ψ_dx2 = Vector()
    for x in sine.vec_x
        push!(sine.vec_d2ψ_dx2, -sum(sine.vec_a.*sine.vec_b.^2 .*sin.(sine.vec_b*x .+ sine.vec_c)))
    end
end
