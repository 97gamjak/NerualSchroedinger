function parse_n_datapoints(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    potential    = storage.potential

    if(key == inputkeys.n_datapoints)

        potential.n_datapoints = parse.(Int64, value)
        inputcontrol[inputkeys.n_datapoints] += 1
        return true

    end

    return false
end