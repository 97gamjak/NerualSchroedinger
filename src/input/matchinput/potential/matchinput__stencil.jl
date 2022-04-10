function parse_stencil(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    potential    = storage.potential

    if(key == inputkeys.stencil)

        value = lowercase(value)
        if(value == "3")
            potential.stencil      = stencil_3
        elseif(value == "5")
            potential.stencil      = stencil_5
        elseif(value == "7")
            potential.stencil      = stencil_7
        elseif(value == "9")
            potential.stencil      = stencil_9
        else
            printerror("Unknown stencil keyword " * value * "!")
            printempty("- 3")
            printempty("- 5")
            printempty("- 7")
            printempty("- 9")
            exit(1)
        end

        inputcontrol[inputkeys.potential] += 1
        return true

    end

    return false
end