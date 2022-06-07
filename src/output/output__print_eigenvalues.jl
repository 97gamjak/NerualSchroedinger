function print_eigenvalues(storage::Storage)

    nstates         = storage.settings.nstates
    filename        = storage.files.eigenvaluefile_name
    directory       = storage.files.directory
    vec_eigenvalues = storage.output.vec_eigenvalues

    eigenvaluefile = open(directory * "/" * filename, "w")

    for i in 1:nstates
        @printf(eigenvaluefile, "%d %20.14lf\n", i-1, vec_eigenvalues[i])
    end

    close(eigenvaluefile)
end