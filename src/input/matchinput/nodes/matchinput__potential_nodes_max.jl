function parse_potential_nodes_max(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.potential_nodes_max)
        settings.potential_nodes_max = parse(Int64, value)
        inputcontrol[inputkeys.potential_nodes_max] += 1
        return true
    end

    return false
end