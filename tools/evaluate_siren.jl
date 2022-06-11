function evaluate_siren()
    if(length(ARGS) != 4)
        #print error
    end

    param_a_file_name = ARGS[1]
    param_b_file_name = ARGS[2]
    param_c_file_name = ARGS[3]

    x_value = parse(Float64, ARGS[4])

    param_a_file = open(param_a_file_name, "r")
    param_b_file = open(param_b_file_name, "r")
    param_c_file = open(param_c_file_name, "r")

    filestream_a = readlines(param_a_file)
    filestream_b = readlines(param_b_file)
    filestream_c = readlines(param_c_file)

    vec_a = Vector{Float64}()
    vec_b = Vector{Float64}()
    vec_c = Vector{Float64}()

    for i in 1:length(filestream_a)

        line_a = filestream_a[i]
        line_b = filestream_b[i]
        line_c = filestream_c[i]

        value_a = split(line_a)[1]
        value_b = split(line_b)[1]
        value_c = split(line_c)[1]

        push!(vec_a, parse(Float64, value_a))
        push!(vec_b, parse(Float64, value_b))
        push!(vec_c, parse(Float64, value_c))

    end

    println(x_value, "   ", sum(vec_a.*sin.(vec_b*x_value .+ vec_c)))

end

evaluate_siren()