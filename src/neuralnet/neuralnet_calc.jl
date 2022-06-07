function calc_neuralnet(storage::Storage)

    jobtype      = storage.settings.jobtype
    inputcontrol = storage.inputcontrol
    inputkeys    = storage.inputkeys

    if(inputcontrol[inputkeys.nodes_min] == 0 || inputcontrol[inputkeys.nodes_max] == 0)
        storage.settings.nodes_min = storage.settings.nodes
        storage.settings.nodes_max = storage.settings.nodes
    end

    if(inputcontrol[inputkeys.potential_nodes_min] == 0 || inputcontrol[inputkeys.potential_nodes_max] == 0)
        storage.settings.potential_nodes_min = storage.settings.potential_nodes
        storage.settings.potential_nodes_max = storage.settings.potential_nodes
    end

    nodes_min = storage.settings.nodes_min
    nodes_max = storage.settings.nodes_max

    potential_nodes_min = storage.settings.potential_nodes_min
    potential_nodes_max = storage.settings.potential_nodes_max

    for nodes in nodes_min:nodes_max
        for potential_nodes in potential_nodes_min:potential_nodes_max
            
            if(storage.settings.scan)
                prepare_scan(storage, nodes, potential_nodes)
            end

            if(jobtype == POTENTIAL)
                calc_neural_potential(storage)
            elseif(jobtype == WAVEFUNCTION)
                calc_neural_wavefunction(storage)
            elseif(jobtype == POTENTIAL_WAVEFUNCTION)
                calc_neuralnet_potential_wavefunction(storage)
            end

        end
    end

end

function prepare_scan(storage::Storage, nodes::Int64, potential_nodes::Int64)
    
    storage.files.directory = storage.files.scan_directory * "/nodes-" * string(nodes) * "_potentialnodes-" * string(potential_nodes)

    mkdir(storage.files.directory)

    storage.settings.nodes = nodes
    storage.settings.potential_nodes = potential_nodes

end