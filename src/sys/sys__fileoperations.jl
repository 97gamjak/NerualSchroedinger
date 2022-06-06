#########################################
#                                       #
# simple wrapper for opening filestream #
# returns error if file is not found!   #
#                                       #
#########################################
function readfile(filename::String)
    try
        return open(filename, "r")
    catch
        FileNotFound(filename)
    end
end