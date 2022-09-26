#######################################################
#                                                     #
# struct containing all sine activation function data #
#                                                     #
#######################################################
mutable struct Sine <: ActivationFunction

    a::Vector{Float64}
    b::Matrix{Float64}
    c::Matrix{Float64}

    f::Vector{Float64}
    ∇f::Matrix{Float64} # for band structure calculcation
    laplace_f::Vector{Float64}

    coords::Matrix{Float64}

    integration::Function  # TODO: at the moment not used!

    norm::Float64

    state::Int64

    iteration::Int64

    Sine() = new()
end

############################################################
#                                                          #
# function to initialize sine activation function randomly #
#                                                          #
############################################################
function init_f(sine::Sine, nodes::Int64, state::Int64)
    weird_number1 = sqrt(6) #divided by number of nodes in sqrt???
    weird_number2 = 30

    sine.state = state

    sine.a = rand(Uniform(0, 2), nodes)
    sine.b = weird_number2 .* rand(Uniform(-weird_number1, weird_number1), (nodes, dim)) #maybe for higher dimensions different initialization
    sine.c = rand(Uniform(0, 2*π), (nodes, dim)) #maybe for higher dimensions different initialization
end

###########################################################
#                                                         #
# function to calculate activation function of grid vec_x #
#                                                         #
#                   ψ = ∑ᵢ aᵢ*sin(bᵢx + cᵢ)                  #
#                                                         #
###########################################################
function calc_f(sine::Sine)
    sine.f = Vector()
    for x in sine.coords
        push!(sine.f, sum(sine.a.*sin.(sine.b*x .+ sine.c)))
    end
end

########################################################
#                                                      #
# function to calculate first derivative of activation #
# function of grid vec_x                               # 
#                                                      #
#               dψ/dx = ∑ᵢ aᵢ*bᵢ*cos(bᵢx + cᵢ)             #
#                                                      #
########################################################
function calc_∇f(sine::Sine)
    sine.∇f = Vector()
    for x in sine.coords
        push!(sine.∇f, sum(sine.a.*sine.b.*cos.(sine.a*x .+ sine.c)))
    end
end

#########################################################
#                                                       #
# function to calculate second derivative of activation #
# function of grid vec_x                                # 
#                                                       #
#            d²ψ/dx² = -∑ᵢ aᵢ*b²ᵢ*sin(bᵢx + cᵢ)             #
#                                                       #
#########################################################
function calc_laplace_f(sine::Sine)
    sine.laplace_f = Vector()
    for x in sine.coords
        push!(sine.laplace_f, -sum(sine.a.*sine.b.^2 .*sin.(sine.b*x .+ sine.c)))
    end
end


