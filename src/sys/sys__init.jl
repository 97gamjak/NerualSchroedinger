function init()
    
    storage              = Storage()
    storage.files        = Files()
    storage.inputkeys    = Inputkeys()
    storage.potential    = Potential()
    storage.laplace      = Laplace()
    storage.output       = Output()
    storage.settings     = Settings()
    storage.neuralnet    = NeuralNetwork()

    #TODO: parse input for this

    storage.activationFunction = Sine()


    ######################################################
    #                                                    #
    # Initialize inputcontrol with all possible keywords #
    # of inputfile - dictionary to store the number of   #
    # appearances in the inputfile                       #
    #                                                    #
    ######################################################

    inputcontrol = Dict() 

    for key in fieldnames(typeof(Inputkeys()))
        push!(inputcontrol, getfield(storage.inputkeys, key) => 0)
    end

    storage.inputcontrol = inputcontrol

    storage.files.eigenvaluefile_name  = "eigenvalues.dat"
    storage.files.eigenvectorfile_name = "eigenvectors.dat"

    storage.settings.mass    = 1.0u"u"
    storage.settings.nstates = 5

    return storage
    
end