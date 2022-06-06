using LinearAlgebra

function grad(fun, x0, f0, h)
    
    dim = length(x0)
    grad = zeros(dim)

    mat_h = diagm(h)

    for i in 1:dim
        x = x0 + mat_h[i,:]
        dx = x[i] - x0[i]
        df = fun(x) - f0
        grad[i] = df / dx
    end

    return grad   
end