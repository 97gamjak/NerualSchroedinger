function parse_potential_nodes(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.potential_nodes)

        settings.potential_nodes = parse(Int64, value)

        inputcontrol[inputkeys.potential_nodes] += 1
        return true

    end

    return false
end