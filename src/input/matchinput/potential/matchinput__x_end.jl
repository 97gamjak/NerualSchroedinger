function parse_x_end(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    potential    = storage.potential

    if(key == inputkeys.x_end)

        potential.x_end = parse.(Float64, value)
        inputcontrol[inputkeys.x_end] += 1
        return true

    end

    return false
end