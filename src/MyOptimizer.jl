module MyOptimizer

    include("myoptimizer/numeric_grad.jl")
    include("myoptimizer/linesearch.jl")
    include("myoptimizer/bfgs.jl")
    export grad
    export linesearch
    export bfgs
end