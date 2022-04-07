mutable struct Storage

    files        ::Files
    inputkeys    ::Inputkeys
    inputcontrol ::Dict

    Storage() = new()
end