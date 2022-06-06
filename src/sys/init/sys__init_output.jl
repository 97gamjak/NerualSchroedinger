function init_output(storage::Storage)
    storage.output.vec_eigenvalues = Vector()
    storage.output.mat_eigenvectors = Matrix(undef, storage.potential.ndatapoints, storage.settings.nstates)
    storage.output.mat_param_a = Matrix(undef, storage.settings.nodes, storage.settings.nstates)
    storage.output.mat_param_b = Matrix(undef, storage.settings.nodes, storage.settings.nstates)
    storage.output.mat_param_c = Matrix(undef, storage.settings.nodes, storage.settings.nstates)
end