function parse_dim(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.dim)

        settings.dim = parse(Int64, value)

        inputcontrol[inputkeys.dim] += 1
        return true

    end

    return false
end