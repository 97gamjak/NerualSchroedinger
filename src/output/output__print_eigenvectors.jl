function print_eigenvectors(storage::Storage)

    ndatapoints      = storage.potential.ndatapoints
    nstates          = storage.settings.nstates
    filename         = storage.files.eigenvectorfile_name
    vec_x            = ustrip(storage.potential.vec_x)
    vec_potential    = ustrip(storage.potential.vec_potential)
    mat_eigenvectors = storage.output.mat_eigenvectors

    eigenvectorfile = open(filename, "w")

    for i in 1:ndatapoints
        @printf(eigenvectorfile, "%20.14lf %20.14lf ", vec_x[i], vec_potential[i])
        for j in 1:nstates
            @printf(eigenvectorfile, "%20.14lf ", mat_eigenvectors[i, j])
        end
        @printf(eigenvectorfile, "\n")
    end

    close(eigenvectorfile)
end