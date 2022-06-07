#######################################
#                                     #
# struct containing all settings data #
#                                     #
#######################################
mutable struct Settings

    jobtype::JobTypeEnum
    scan   ::Bool
    
    mass::Unitful.Mass
    mass_unit::Unitful.MassUnits

    nodes    ::Int64
    nodes_min::Int64
    nodes_max::Int64

    potential_nodes    ::Int64
    potential_nodes_min::Int64
    potential_nodes_max::Int64

    nstates::Int64

    dim::Int64

    Settings() = new()
end