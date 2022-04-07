function parse_potential(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    potential    = storage.potential

    if(key == inputkeys.potential)

        value = lowercase(value)
        if(value == "harmonic")
            potential.potential = Harmonic
        else
            printerror("Unknown potential keyword " * value * "!")
            printempty("- harmonic")
            exit(1)
        end

        inputcontrol[inputkeys.potential] += 1
        return true

    end

    return false
end