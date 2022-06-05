function parse_jobtype(key::String, value::String, storage::Storage)
    
    inputkeys    = storage.inputkeys
    inputcontrol = storage.inputcontrol
    settings     = storage.settings

    if(key == inputkeys.jobtype)

        value = lowercase(value)
        if(value == "potential")
            settings.jobtype = POTENTIAL
        elseif(value == "wavefunction")
            settings.jobtype = WAVEFUNCTION
        elseif(value == "potential_wavefunction")
            settings.jobtype = POTENTIAL_WAVEFUNCTION
        else
            printerror("Unknown jobtype keyword " * value * " - Valid options are:")
            printempty("- potential")
            printempty("- wavefunction")
            printempty("- potential_wavefunction")
            exit(1)
        end

        inputcontrol[inputkeys.jobtype] += 1
        return true

    end

    return false
end