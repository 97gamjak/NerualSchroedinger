function parse_nodes_max(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.nodes_max)
        settings.nodes_max = parse(Int64, value)
        inputcontrol[inputkeys.nodes_max] += 1
        return true
    end

    return false
end