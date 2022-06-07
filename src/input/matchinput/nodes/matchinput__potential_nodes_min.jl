function parse_potential_nodes_min(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.potential_nodes_min)
        settings.potential_nodes_min = parse(Int64, value)
        inputcontrol[inputkeys.potential_nodes_min] += 1
        return true
    end

    return false
end