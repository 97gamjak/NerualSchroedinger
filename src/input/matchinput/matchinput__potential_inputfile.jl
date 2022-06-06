function parse_potential_inputfile(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    files        = storage.files

    if(key == inputkeys.potential_inputfile)
        files.potential_inputfile_name = value
        inputcontrol[inputkeys.potential_inputfile] += 1
        return true
    end

    return false
end