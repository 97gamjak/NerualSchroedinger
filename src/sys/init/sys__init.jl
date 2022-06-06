function init()

    ##########################################
    # initialization of datatypes in storage #
    ##########################################
    
    storage              = Storage()
    storage.files        = Files()
    storage.inputkeys    = Inputkeys()
    storage.potential    = Potential()
    storage.laplace      = Laplace()
    storage.output       = Output()
    storage.settings     = Settings()

    ######################################################
    # Initialize inputcontrol with all possible keywords #
    # of inputfile - dictionary to store the number of   #
    # appearances in the inputfile                       #
    ######################################################

    inputcontrol = Dict() 

    for key in fieldnames(typeof(Inputkeys()))
        push!(inputcontrol, getfield(storage.inputkeys, key) => 0)
    end

    storage.inputcontrol = inputcontrol

    ##############################
    # setting all default values #
    ##############################

    set_defaults(storage)

    return storage
    
end