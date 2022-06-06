#######################################
#                                     #
# struct containing all settings data #
#                                     #
#######################################
mutable struct Settings

    jobtype::JobTypeEnum
    
    mass::Unitful.Mass
    mass_unit::Unitful.MassUnits

    nodes          ::Int64
    potential_nodes::Int64

    nstates::Int64

    dim::Int64

    Settings() = new()
end