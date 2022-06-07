function set_defaults(storage::Storage)

    ################################
    # default filenames for output #
    ################################
    
    storage.files.eigenvaluefile_name  = "eigenvalues.dat"
    storage.files.eigenvectorfile_name = "eigenvectors.dat"
    storage.files.paramfile_name       = "paramfile.dat"
    
    storage.files.directory            = "results"

    ##############################
    # defaults for neuralNetwork #
    ##############################

    storage.settings.nstates = 5
    storage.settings.nodes   = 40
    storage.settings.dim     = 1

    #######################
    # default mass to 1au #
    #######################

    storage.settings.mass    = 1.0u"u"

    #################################
    # default units for calculation #
    #################################

    storage.potential.x_unit         = u"angstrom"
    storage.potential.potential_unit = u"kcalpermol"
    storage.settings.mass_unit       = u"u" #TODO: parse

    #####################################
    # default jobtype - only solving SE #
    #####################################

    storage.settings.jobtype = WAVEFUNCTION

    #################################################
    # dafault activation function is SIREN approach #
    #################################################

    #TODO: parse input for this
    storage.activationFunction = Sine()

end