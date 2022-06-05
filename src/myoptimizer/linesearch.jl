include("dcsrch.jl")

function linesearch(f, g, ϕ0, old_ϕ0, der_ϕ0, xk, pk)
    α1 = 1.0

    der_ϕ0 = dot(der_ϕ0,pk)

    if(der_ϕ0 != 0.0)
        α1 = min(1.0, 1.01*2*(ϕ0 - old_ϕ0)/der_ϕ0)
        if(α1 < 0)
            α1 = 1.0
        end
    end

    ϕ1     = ϕ0
    der_ϕ1 = der_ϕ0

    step_tmp, ϕ1_tmp, der_ϕ1_tmp, g_tmp, warning_level = dcsrch(α1, ϕ1, der_ϕ1, 1e-14, 0.9, 1e-14, 1e-100, 1e100, f, g, xk, pk)

    # if(warning_level != 0)
    #     wolfe_2(α1, ϕ1, der_ϕ1, 1e-14, 1e-14, 1e-14, 1e-100, 1e100, f, g, xk, pk)
    # end

    step   = step_tmp
    ϕ1     = ϕ1_tmp
    der_ϕ1 = der_ϕ1_tmp
    g      = g_tmp

    return step, ϕ1, ϕ0, g

end

function wolfe_2(step, f, g, ftol, gtol, xtol, stepmin, stepmax, func, grad, xk, pk)
    alpha1 = min(step, stepmax)

    phi_a1 = func(xk + step*pk)

    phi_a0 = f
    derphi_a0 = g

    for i in 1:10
    end

        

end

function line_search_armijo(func, grad, xk, pk, gfk, old_fval, c1, alpha0)

    step = armijo(func, xk, pk, gfk, old_fval, c1, alpha0)

    if step == Inf
        return step, 0.0, 0.0, 0.0
    end

    f = func(xk + step*pk)
    h = sqrt(eps())
    tmp = max.(1.0, abs.(xk))
    dx    = (xk .+ h) - xk
    vec_h = ifelse.(dx .== 0.0, h * sign.(xk) .* tmp, h)
    g = grad(func, xk + step*pk, f, vec_h)
    derphi = dot(g, pk)

    return step, f, derphi, g

end

function armijo(func, xk, pk, gfk, old_fval, c1, alpha0)
    
    derphi0 = dot(gfk, pk)

    phi_a0 = func(xk + alpha0*pk)

    if(phi_a0 <= old_fval + c1*alpha0*derphi0)
        return alpha0
    end

    alpha1 = - derphi0 * alpha0^2 / 2.0 / (phi_a0 - old_fval - derphi0*alpha0)
    phi_a1 = func(xk + alpha1*pk)

    if(phi_a1 <= old_fval + c1*alpha1*derphi0)
        return alpha1
    end

    amin = 0.0
    while(alpha1 > amin)
        tmp1 = phi_a1 - old_fval - derphi0*alpha1
        tmp2 = phi_a0 - old_fval - derphi0*alpha0
        a = alpha0^2 * (tmp1) - alpha1^2 * (tmp2)

        factor = alpha0^2 * alpha1^2 * (alpha1 - alpha0)

        a /= factor

        b = -alpha0^3 * (tmp1) + alpha1^3 * (tmp2)

        b /= factor

        alpha2 = (-b + sqrt(abs(b^2 - 3*a*derphi0))) / (3.0*a)

        phi_a2 = func(xk + alpha2*pk)

        if(phi_a2 < old_fval + c1*alpha2*derphi0)
            return alpha2
        end

        if((alpha1 - alpha2) > alpha1 / 2.0 || (1 - alpha2 / alpha1) < 0.95)
            alpha2 = alpha1 / 2.0
        end

        alpha0 = alpha1
        alpha1 = alpha2
        phi_a0 = phi_a1
        phi_a1 = phi_a2
    end

    println("Error!")
    return Inf
end