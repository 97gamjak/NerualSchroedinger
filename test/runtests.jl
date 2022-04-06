using NeuralSchroedinger
using Test

include("../src/sys/sys__fileoperations.jl")
include("../src/exceptions/exceptions__filenotfound.jl")

@testset "NeuralSchroedinger.jl" begin
    @test typeof(readfile("runtests.jl")) == IOStream
    @test_logs (:error,) typeof(readfile("random.jl"))
end
