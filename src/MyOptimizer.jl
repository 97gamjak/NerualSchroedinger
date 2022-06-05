module MyOptimizer

    include("myoptimizer/function.jl")
    include("myoptimizer/linesearch.jl")
    include("myoptimizer/loss.jl")
    include("myoptimizer/basinhopping.jl")
    export grad
    export linesearch
    export bfgs
    export basinhopping
end