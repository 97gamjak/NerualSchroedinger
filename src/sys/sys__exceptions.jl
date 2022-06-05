function FileNotFound(file::String)
    @error "No such file: \"" * file * "\"!"
end

function ToManyArguments(line::Int64, file::String)
    @error "There are to many argumetns in line " * string(line) * " in file \"" * file * "\"!"
end

function NotEnoughArguments(line::Int64, file::String)
    @error "There are to many argumetns in line " * string(line) * " in file \"" * file * "\"!"
end