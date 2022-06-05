#######################################
#                                     #
# struct containing all settings data #
#                                     #
#######################################
mutable struct Settings
    
    mass::Unitful.Mass

    nodes          ::Int64
    potential_nodes::Int64

    nstates::Int64

    Settings() = new()
end