############################################
#                                          #
# struct to store all keywors of inputfile #
#                                          #
############################################
Base.@kwdef struct Inputkeys

    #################################
    #                               #
    # keywords for general settings #
    #                               #
    #################################

    mass = "mass" #TODO: parse input

    #########################################
    #                                       #
    # keywords to define the units to apply #
    #                                       #
    #########################################

    units       = "units"       #TODO: parse input
    length_unit = "length_unit" #TODO: parse input
    energy_unit = "energy_unit" #TODO: parse input
    mass_unit   = "mass_unit"   #TODO: parse input

    ##############################
    #                            #
    # potential related keywords #
    #                            #
    ##############################

    potential_inputfile = "potential_inputfile"
    equi_distant        = "equi_distant" #TODO: parse input

    ###########################
    #                         #
    # output related keywords #
    #                         #
    ###########################

    eigenvaluefile  = "eigenvalue_file"
    eigenvectorfile = "eigenstate_file"

    ###########################
    #                         #
    # numerov related keywors #
    #                         #
    ###########################

    stencil = "stencil"
end