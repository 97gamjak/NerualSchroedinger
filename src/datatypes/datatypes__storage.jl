################################
#                              #
# master struct for everything #
#                              #
################################
mutable struct Storage

    files             ::Files     # struct for file information
    inputkeys         ::Inputkeys # struct for input keywords
    inputcontrol      ::Dict      # dictionary for counting inputkeys
    potential         ::Potential # struct for all length and potential information
    laplace           ::Laplace 
    output            ::Output  
    settings          ::Settings
    neuralnet         ::NeuralNetwork
    activationFunction::ActivationFunction

    Storage() = new()
end