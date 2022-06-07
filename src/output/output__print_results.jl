function print_results(storage::Storage)

    jobtype = storage.settings.jobtype

    if(jobtype == WAVEFUNCTION)
        print_eigenvalues(storage)
    end

    print_eigenvectors(storage)

    print_params(storage)
    
end