function calc_neuralnet(storage::Storage)

    jobtype = storage.settings.jobtype

    if(jobtype == POTENTIAL)
        calc_neural_potential(storage)
    elseif(jobtype == WAVEFUNCTION)
        calc_neural_wavefunction(storage)
    elseif(jobtype == POTENTIAL_WAVEFUNCTION)
        calc_neuralnet_potential_wavefunction(storage)
    end

end