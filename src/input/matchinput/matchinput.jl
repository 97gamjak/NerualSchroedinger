function matchinput(lineelements::Vector{Sting}, line::Int64, storage::Storage)

    valid_key = false

    key   = lowercase(linel)
    value = string(buffer[2])      # buffer[2] would only be substring

    valid_key = valid_key || parse_jobtype(key, value, inputkeys, storage)
    valid_key = valid_key || parse_forcefield(key, value, inputkeys, storage)
    valid_key = valid_key || parse_nonbonded(key, value, inputkeys, storage)
    valid_key = valid_key || parse_bonded_fast(key, value, inputkeys, storage)
    valid_key = valid_key || parse_integrator(key, value, inputkeys, storage)
    valid_key = valid_key || parse_gufftype(key, value, inputkeys, storage)
    valid_key = valid_key || parse_nsteps(key, value, inputkeys, storage)
    valid_key = valid_key || parse_timestep(key, value, inputkeys, storage)
    valid_key = valid_key || parse_output_freq(key, value, inputkeys, storage)
    valid_key = valid_key || parse_density(key, value, inputkeys, storage)
    valid_key = valid_key || parse_nscale(key, value, inputkeys, storage)
    valid_key = valid_key || parse_write_trajectory(key, value, inputkeys, storage)
    valid_key = valid_key || parse_celllist(key, value, inputkeys, storage)
    valid_key = valid_key || parse_cellnumber(key, value, inputkeys, storage)

    #parsing coulomb related keywords
    valid_key = valid_key || parse_rcut_c(key, value, inputkeys, storage)
    valid_key = valid_key || parse_longrange(key, value, inputkeys, storage)
    valid_key = valid_key || parse_epsilon(key, value, inputkeys, storage)
    valid_key = valid_key || parse_kappa(key, value, inputkeys, storage)

    #parsing thermostat keywords
    valid_key = valid_key || parse_thermostat(key, value, inputkeys, storage)
    valid_key = valid_key || parse_target_temperature(key, value, inputkeys, storage)
    valid_key = valid_key || parse_relaxation_time(key, value, inputkeys, storage)
    valid_key = valid_key || parse_friction(key, value, inputkeys, storage)
    valid_key = valid_key || parse_nh_chainlength(key, value, inputkeys, storage)
    valid_key = valid_key || parse_omega(key, value, inputkeys, storage)

    #parsing manostat keywords
    valid_key = valid_key || parse_manostat(key, value, inputkeys, storage)
    valid_key = valid_key || parse_target_pressure(key, value, inputkeys, storage)
    valid_key = valid_key || parse_p_relax(key, value, inputkeys, storage)
    valid_key = valid_key || parse_compressibility(key, value, inputkeys, storage)

    #parsing watermodel
    valid_key = valid_key || parse_water_intra(key, value, inputkeys, storage)
    valid_key = valid_key || parse_water_inter(key, value, inputkeys, storage)
    valid_key = valid_key || parse_r_oh_equilibrium(key, value, inputkeys, storage)
    valid_key = valid_key || parse_r_hh_equilibrium(key, value, inputkeys, storage)
    valid_key = valid_key || parse_alpha_hoh_equilibrium(key, value, inputkeys, storage)

    #parsing filenames for input
    valid_key = valid_key || parse_startfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_moldescriptorfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_guffdatfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_intra_water_file(key, value, inputkeys, storage)
    valid_key = valid_key || parse_parameterfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_topologyfile(key, value, inputkeys, storage)

    #parsing filename for output
    valid_key = valid_key || parse_infofile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_outputfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_restartfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_energyfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_trajfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_velfile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_forcefile(key, value, inputkeys, storage)
    valid_key = valid_key || parse_temperaturefile(key, value, inputkeys, storage) 

    if(!valid_key)
        printerror("Unknown keyword " * key * " in line " * string(i) * " in input file")
        exit(1)
    end
end