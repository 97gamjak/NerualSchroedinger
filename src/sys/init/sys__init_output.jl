function init_output(storage::Storage)
    storage.output.vec_eigenvalues = Vector()
    storage.output.mat_eigenvectors = Matrix(undef, storage.potential.ndatapoints, storage.settings.nstates)
    storage.output.mat_param_a = Matrix(undef, storage.settings.nodes, storage.settings.nstates)
    storage.output.mat_param_b = Matrix(undef, storage.settings.nodes, storage.settings.nstates)
    storage.output.mat_param_c = Matrix(undef, storage.settings.nodes, storage.settings.nstates)

    set_paramfile_name(storage)

end

function set_paramfile_name(storage::Storage)

    paramfile_name = storage.files.paramfile_name
    dot_index = findlast('.', paramfile_name)

    if(dot_index === nothing)
        paramfile_a_name = paramfile_name * "_a"
        paramfile_b_name = paramfile_name * "_b"
        paramfile_c_name = paramfile_name * "_c"
    else
        paramfile_a_name = paramfile_name[1:dot_index-1] * "_a" * paramfile_name[dot_index:end]
        paramfile_b_name = paramfile_name[1:dot_index-1] * "_b" * paramfile_name[dot_index:end]
        paramfile_c_name = paramfile_name[1:dot_index-1] * "_c" * paramfile_name[dot_index:end]
    end

    try
        paramfile_a_name = storage.files.paramfile_a_name
    catch
        storage.files.paramfile_a_name = paramfile_a_name
    end

    try
        paramfile_b_name = storage.files.paramfile_b_name
    catch
        storage.files.paramfile_b_name = paramfile_b_name
    end
    
    try
        paramfile_c_name = storage.files.paramfile_c_name
    catch
        storage.files.paramfile_c_name = paramfile_c_name
    end

end