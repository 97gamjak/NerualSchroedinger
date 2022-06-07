function parse_nodes_min(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.nodes_min)
        settings.nodes_min = parse(Int64, value)
        inputcontrol[inputkeys.nodes_min] += 1
        return true
    end

    return false
end