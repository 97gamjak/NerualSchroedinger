function print_results(storage::Storage)

    eigenvaluefile = open(storage.files.eigenvaluefile_name, "w")

    for i in 1:storage.settings.nstates
        @printf(eigenvaluefile, "%d %20.14lf\n", i-1, storage.output.vec_eigenvalues[i])
    end

    close(eigenvaluefile)

    eigenvectorfile = open(storage.files.eigenvectorfile_name, "w")

    vec_x            = ustrip(storage.potential.vec_x)
    vec_potential    = ustrip(storage.potential.vec_potential)
    #mat_eigenvectors = storage.output.mat_eigenvectors

    for i in 1:storage.potential.ndatapoints
        @printf(eigenvectorfile, "%20.14lf %20.14lf ", vec_x[i], vec_potential[i])
        # for j in 1:storage.settings.nstates
        #     @printf(eigenvectorfile, "%20.14lf ", mat_eigenvectors[i, j])
        # end
        @printf(eigenvectorfile, "%20.14lf ", storage.activationFunction.vec_ψ[i])
        @printf(eigenvectorfile, "\n")
    end

    close(eigenvectorfile)
    
end