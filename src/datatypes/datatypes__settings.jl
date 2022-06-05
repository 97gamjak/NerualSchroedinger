#######################################
#                                     #
# struct containing all settings data #
#                                     #
#######################################
mutable struct Settings
    
    mass::Unitful.Mass

    nstates::Int64

    Settings() = new()
end