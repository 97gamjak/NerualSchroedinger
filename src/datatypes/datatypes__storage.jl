mutable struct Storage

    files        ::Files
    inputkeys    ::Inputkeys
    inputcontrol ::Dict
    potential    ::Potential

    Storage() = new()
end