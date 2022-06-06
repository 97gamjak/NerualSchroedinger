using NeuralSchroedinger.MyOptimizer
using LinearAlgebra

function bfgs(loss, x0)

    sign_x0 = sign.(x0)

    h = sqrt(eps())

    tmp = max.(1.0, abs.(x0))

    dx    = (x0 .+ h) - x0
    vec_h = ifelse.(dx .== 0.0, h * sign_x0 .* tmp, h)

    f0 = loss(x0)
    grad0 = grad(loss, x0, f0, vec_h)

    k = 0
    n = length(x0)
    I = diagm(ones(n))
    H_k = I

    old_old_fval = f0 + norm(grad0) / 2

    x_k = x0

    gradnorm = norm(grad0, Inf)
    grad_k = grad0

    iter_converged = 0

    while(true)

        p_k = - H_k * grad_k
        alpha_k, f0, old_old_fval, grad_kp1 = linesearch(loss, grad, f0, old_old_fval, grad_k, x_k, p_k)

        x_k_prev = x_k
        x_kp1    = x_k + alpha_k * p_k

        sk = x_kp1 - x_k
        x_k = x_kp1

        y_k = grad_kp1 - grad_k
        grad_k = grad_kp1

        if(abs(loss(x_kp1) - loss(x_k_prev)) < 1e-6)
            iter_converged += 1
            if(iter_converged == 100)
                break
            end
        else
            #iter_converged = 0
        end

        k += 1
        gradnorm = norm(grad_k, Inf)

        #if(gnorm <= gtol)
            #break
        #end

        #if(!isfinite(f0))
            #warnflag

        ρ_k_inv = dot(y_k, sk)

        if(ρ_k_inv == 0.0)
            ρ_k = 1000.0
        else
            ρ_k = 1 / ρ_k_inv
        end

        A1  = I - sk  * transpose(y_k) * ρ_k
        A2  = I - y_k * transpose(sk ) * ρ_k
        H_k = (A1 * (H_k*A2)) + ρ_k * (sk * transpose(sk))

        if(k == 10)
           break
        end
    end

    return x_k
end
