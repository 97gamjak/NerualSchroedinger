function parse_nodes(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.nodes)

        settings.nodes = parse(Int64, value)

        inputcontrol[inputkeys.nodes] += 1
        return true

    end

    return false
end