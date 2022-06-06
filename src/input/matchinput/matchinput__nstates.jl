function parse_nstates(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.nstates)
        settings.nstates = parse(Int64, value)
        inputcontrol[inputkeys.nstates] += 1
        return true
    end

    return false
end