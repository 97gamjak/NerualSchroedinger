using SparseArrays

function stencil_3(n_datapoints::Int64)

    return spdiagm(
        -1 => ones(n_datapoints-1),
         0 => ones(n_datapoints)*(-2),
         1 => ones(n_datapoints-1)
    )
    
end

function stencil_5(n_datapoints::Int64)

    return spdiagm(
        -2 => ones(n_datapoints-2)*(-1/12),
        -1 => ones(n_datapoints-1)*(4/3),
         0 => ones(n_datapoints  )*(-5/2),
         1 => ones(n_datapoints-1)*(4/3),
         2 => ones(n_datapoints-2)*(-1/12)
    )
    
end

function stencil_7(n_datapoints::Int64)

    return spdiagm(
        -3 => ones(n_datapoints-3)*(1/90),
        -2 => ones(n_datapoints-2)*(-3/20),
        -1 => ones(n_datapoints-1)*(3/2),
         0 => ones(n_datapoints  )*(-49/18),
         1 => ones(n_datapoints-1)*(3/2),
         2 => ones(n_datapoints-2)*(-3/20),
         3 => ones(n_datapoints-3)*(1/90)
    )
    
end

function stencil_9(n_datapoints::Int64)

    return spdiagm(
        -4 => ones(n_datapoints-4)*(-1/560),
        -3 => ones(n_datapoints-3)*(8/315),
        -2 => ones(n_datapoints-2)*(-1/5),
        -1 => ones(n_datapoints-1)*(8/5),
         0 => ones(n_datapoints  )*(-205/72),
         1 => ones(n_datapoints-1)*(8/5),
         2 => ones(n_datapoints-2)*(-1/5),
         3 => ones(n_datapoints-3)*(8/315),
         4 => ones(n_datapoints-4)*(-1/560)
    )
    
end