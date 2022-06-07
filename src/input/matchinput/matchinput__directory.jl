function parse_directory(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    files        = storage.files

    if(key == inputkeys.directory)
        files.directory = value
        inputcontrol[inputkeys.directory] += 1
        return true
    end

    return false
end