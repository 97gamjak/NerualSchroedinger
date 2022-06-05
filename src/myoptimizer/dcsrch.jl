function dcsrch(step, f, g, ftol, gtol, xtol, stepmin, stepmax, func, grad, xk, pk)

    xtrapl = 1.1
    xtrapu = 4.0

    brackt = false
    stage  = 1
    isave_1 = 0

    f0 = f
    g0 = g
    gtest = ftol * g0
    width = stepmax - stepmin
    width1 = 2*width

    stx = 0.0
    sty = 0.0
    fx = f0
    fy = f0
    gx = g0
    gy = g0

    stepmin = 0.0
    stepmax = step + xtrapu*step

    ftest = f0 + step*gtest

    fm = 0.0
    fxm = 0.0
    fym = 0.0
    gm = 0.0
    gxm = 0.0
    gym = 0.0

    warning_level = 0

    subiter = 1

    while(true)
        
        f = func(xk + step*pk)
        h = sqrt(eps())
        tmp = max.(1.0, abs.(xk))
        dx    = (xk .+ h) - xk
        vec_h = ifelse.(dx .== 0.0, h * sign.(xk) .* tmp, h)
        g = dot(grad(func, xk + step*pk, f, vec_h), pk)

        # println("\n\nsubiter ", subiter)

        # subiter += 1

        # println("")
        # println("step    ", step)
        # println("pk      ", pk)
        # println("f       ", f)
        # println("g       ", g)
        # println("")   
        # println("g0      ", g0)
        # println("gtest   ", gtest)
        # println("gx      ", gx)
        # println("gy      ", gy)
        # println("f0      ", f0)
        # println("fx      ", fx)
        # println("fy      ", fy)
        # println("stx     ", stx)
        # println("sty     ", sty)
        # println("stepmin ", stepmin)
        # println("stepmax ", stepmax)
        # println("width   ", width)
        # println("width1  ", width1)


        ftest = f0 + step*gtest

        if(stage == 1 && f <= ftest && g >= 0.0)
            stage = 2
        end

        if(f <= ftest && abs(g) <= gtol*(-g0))
            #println("Success!")
            break
        end

        if(brackt && (step <= stepmin || step >= stepmax))
            #println("warning1!")
            warning_level = 1
            break
        end

        if(brackt && stepmax - stepmin <= xtol*stepmax)
            #println("warning2!")
            warning_level = 2
            break
        end

        if(step == stepmax && f <= ftest && g <= gtest)
            #println("warning3!")
            warning_level = 3
            break
        end

        if(step == stepmin && (f > ftest || g >= gtest))
            #println("warning4!")
            warning_level = 4
            break
        end

        #println("f     ", f)
        #println("fx    ", fx)
        #println("ftest ", fx)

        if(stage == 1 && f <= fx && f > ftest)
            fm = f - step*gtest
            fxm = fx - stx*gtest
            fym = fy - sty*gtest
            gm = g - gtest
            gxm = gx - gtest
            gym = gy - gtest

            #println("test1")

            stx, fxm, gxm, sty, fym, gym, step, brackt = dcstep(stx, fxm, gxm, sty, fym, gym, step, fm, gm, stepmin, stepmax, brackt)

            fx = fxm + stx*gtest
            fy = fym + sty*gtest
            gx = gxm + gtest
            gy = gym + gtest
        else
            #println("test2")
            stx, fx, gx, sty, fy, gy, step, brackt = dcstep(stx, fx, gx, sty, fy, gy, step, f, g, stepmin, stepmax, brackt)
        end

        if(brackt)
            if(abs(sty-stx) >= 0.66*width1)
                step = stx + 0.5*(sty-stx)
            end
            width1 = width
            width = abs(sty-stx)
        end

        if(brackt)
            stepmin = min(stx, sty)
            stepmax = max(stx, sty)
        else
            stepmin = step + xtrapl*(step-stx)
            stepmax = step + xtrapu*(step-stx)
        end

        #if(brackt)
            step = max(step, stepmin)
            step = min(step, stepmax)
        #end

        if(brackt && (step <= stepmin || step >= stepmax) || (brackt && stepmax - stepmin <= xtol*stepmax))
            step = stx
        end


    end

    f = func(xk + step*pk)
    h = sqrt(eps())
    tmp = max.(1.0, abs.(xk))
    dx    = (xk .+ h) - xk
    vec_h = ifelse.(dx .== 0.0, h * sign.(xk) .* tmp, h)
    g = grad(func, xk + step*pk, f, vec_h)
    derphi = dot(g, pk)
    
    # println(step)

    return step, f, derphi, g, warning_level
end

function dcstep(stx, fx, gx, sty, fy, gy, step, f, g, stepmin, stepmax, brackt)

    sgnd = g*sign(gx)

    if(f > fx)
        # println("subtest1")
        θ = 3.0*(fx - f)/(step - stx) + gx + g
        s = max(abs(θ), abs(gx), abs(g))

        γ_tmp = (θ/s)^2 - (gx/s)*(g/s) #no /s cause it seems senseless
        γ = s*sqrt(max(0.0, γ_tmp))
        
        if(step < stx)
            γ = -γ
        end

        p = (γ - gx) + θ
        q = ((γ - gx) + γ) + g
        r = p/q
        stpc = stx + r*(step-stx)
        stpq = stx + ((gx/((fx-f)/(step-stx) + gx))/2.0)*(step-stx)
        if(abs(stpc-stx) < abs(stpq-stx))
            stpf = stpc
        else
            stpf = stpc + (stpq - stpc)/2.0
        end

        brackt = true
    elseif(sgnd < 0.0)

        # println("subtest2")
        θ = 3.0*(fx - f)/(step - stx) + gx + g
        s = max(abs(θ), abs(gx), abs(g))

        γ_tmp = (θ/s)^2 - (gx/s)*(g/s) #no /s cause it seems senseless
        γ = s*sqrt(max(0.0, γ_tmp))

        if(step > stx)
            γ = -γ
        end
     
        p = (γ - g) + θ
        q = ((γ - g) + γ) + gx
        r = p/q

        stpc = step + r*(stx-step)
        stpq = step + (g/(g-gx))*(stx-step)

        if(abs(stpc-step) > abs(stpq-step))
            stpf = stpc
        else
            stpf = stpq
        end
        brackt = true
    elseif(abs(g) < abs(gx))
        
        # println("subtest3")
        θ = 3.0*(fx - f)/(step - stx) + gx + g
        s = max(abs(θ), abs(gx), abs(g))

        γ_tmp = (θ/s)^2 - (gx/s)*(g/s) #no /s cause it seems senseless
        γ = s*sqrt(max(0.0, γ_tmp))

        if(step > stx)
            γ = -γ
        end
     
        p = (γ - g) + θ
        q = (γ + (gx-g)) + γ
        r = p/q

        if(r < 0.0 && γ != 0.0)
            stpc = step + r*(stx-step)
        elseif(step > stx)
            stpc = stepmax
        else
            stpc = stepmin
        end

        stpq = step + (g/(g-gx))*(stx-step)

        if(brackt)
            if(abs(stpc-step) < abs(stpq-step))
                stpf = stpc
            else
                stpf = stpq
            end

            if(step > stx)
                stpf = min(step+0.66*(sty-step), stpf)
            else
                stpf = max(step+0.66*(sty-step), stpf)
            end
        else
            if(abs(stpc-step) > abs(stpq-step))
                stpf = stpc
            else
                stpf = stpq
            end

            stpf = min(stepmax, stpf)
            stpf = max(stepmin, stpf)
        end
        
    else
        # println("subtest4")
        if(brackt)
            θ = 3.0*(fy - f)/(step - sty) + gy + g
            s = max(abs(θ), abs(gy), abs(g))
            γ_tmp = (θ/s)^2 - (gy/s)*(g/s)
            γ = s*sqrt(γ_tmp)

            if(step > sty)
                γ = -γ
            end

            p = (γ - g) + θ
            q = ((γ - g) + γ) + gy
            r = p/q

            stpc = step + r*(sty-step)
            stpf = stpc
        elseif(step > stx)
            stpf = stepmax
        else
            stpf = stepmin
        end
    end

    if(f > fx)
        sty = step
        fy = f
        gy = g
    else
        if(sgnd < 0.0)
            sty = stx
            fy = fx
            gy = gx
        end
        stx = step
        fx = f
        gx = g
    end

    step = stpf

    return stx, fx, gx, sty, fy, gy, step, brackt

end