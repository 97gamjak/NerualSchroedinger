function parse_eigenvaluefile(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    files        = storage.files

    if(key == inputkeys.eigenvaluefile)

        files.eigenvaluefile_name = value
        inputcontrol[inputkeys.eigenvaluefile] += 1
        return true

    end

    return false
end