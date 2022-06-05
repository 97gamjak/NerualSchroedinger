function set_defaults(storage::Storage)
    
    storage.files.eigenvaluefile_name  = "eigenvalues.dat"
    storage.files.eigenvectorfile_name = "eigenvectors.dat"

    storage.settings.mass    = 1.0u"u"
    storage.settings.nstates = 5
    storage.settings.nodes   = 40

    storage.potential.x_unit         = u"angstrom"
    storage.potential.potential_unit = u"kcalpermol"
end