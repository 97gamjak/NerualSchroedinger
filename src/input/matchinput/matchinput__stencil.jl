function parse_stencil(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    laplace      = storage.laplace

    if(key == inputkeys.stencil)

        value = lowercase(value)
        if(value == "3")
            laplace.stencil = 3
        elseif(value == "5")
            laplace.stencil = 5
        elseif(value == "7")
            laplace.stencil = 7
        elseif(value == "9")
            laplace.stencil = 9
        else
            printerror("Unknown stencil keyword " * value * " - Valid options are:")
            printempty("- 3")
            printempty("- 5")
            printempty("- 7")
            printempty("- 9")
            exit(1)
        end

        inputcontrol[inputkeys.stencil] += 1
        return true

    end

    return false
end