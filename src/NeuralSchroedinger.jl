module NeuralSchroedinger

using Unitful
using PhysicalConstants
using LinearAlgebra
using ArgParse
using Printf
using Distributions
using NumericalIntegration

import PhysicalConstants.CODATA2018: ħ, N_A
import LinearAlgebra.diagm
import LinearAlgebra.eigen

include("MyUnits.jl")
using .MyUnits

MyUnits.__init__()

abstract type ActivationFunction end

include("MyOptimizer.jl")
using .MyOptimizer

include("main_numerov.jl")
include("main_neuralnet.jl")
include("files_to_include.jl")

export numerov
export neuralNetwork

end