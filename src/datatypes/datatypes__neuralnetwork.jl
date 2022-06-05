############################################
#                                          #
# struct containing all neuralnetwork data #
#                                          #
############################################
mutable struct NeuralNetwork

    nodes::Int64
    
    NeuralNetwork() = new()
end