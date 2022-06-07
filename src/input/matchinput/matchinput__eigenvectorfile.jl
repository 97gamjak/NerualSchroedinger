function parse_eigenvectorfile(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    files        = storage.files

    if(key == inputkeys.eigenvectorfile)
        files.eigenvectorfile_name = value
        inputcontrol[inputkeys.eigenvectorfile] += 1
        return true
    end

    return false
end