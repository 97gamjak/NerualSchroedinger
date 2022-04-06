function FileNotFound(file::String)
    @error "No such file: \"" * file * "\"!"
end