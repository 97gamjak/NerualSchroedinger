function parse_x_start(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    potential    = storage.potential

    if(key == inputkeys.x_start)

        potential.x_start = parse.(Float64, value)
        inputcontrol[inputkeys.x_start] += 1
        return true

    end

    return false
end