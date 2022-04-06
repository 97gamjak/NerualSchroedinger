function readfile(filename::String)
    try
        return open(filename, "r")
    catch
        FileNotFound(filename)
    end
end