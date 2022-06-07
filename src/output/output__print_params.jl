function print_params(storage::Storage)

    nodes       = storage.settings.nodes
    nstates     = storage.settings.nstates
    filename_a  = storage.files.paramfile_a_name
    filename_b  = storage.files.paramfile_b_name
    filename_c  = storage.files.paramfile_c_name
    directory   = storage.files.directory
    mat_param_a = storage.output.mat_param_a
    mat_param_b = storage.output.mat_param_b
    mat_param_c = storage.output.mat_param_c

    paramfile_a = open(directory * "/" * filename_a, "w")
    paramfile_b = open(directory * "/" * filename_b, "w")
    paramfile_c = open(directory * "/" * filename_c, "w")

    for i in 1:nodes
        for j in 1:nstates
            @printf(paramfile_a, "%20.14lf ", mat_param_a[i, j])
            @printf(paramfile_b, "%20.14lf ", mat_param_b[i, j])
            @printf(paramfile_c, "%20.14lf ", mat_param_c[i, j])
        end
        @printf(paramfile_a, "\n")
        @printf(paramfile_b, "\n")
        @printf(paramfile_c, "\n")
    end

    close(paramfile_a)
    close(paramfile_b)
    close(paramfile_c)
end