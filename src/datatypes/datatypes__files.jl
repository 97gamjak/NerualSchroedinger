#################################################
#                                               #
# struct to store all filenames and filepointer #
#                                               #
#################################################
mutable struct Files

    ##############
    #            #
    # file names #
    #            #
    ##############

    inputfile_name          ::String
    potential_inputfile_name::String
    eigenvaluefile_name     ::String
    eigenvectorfile_name    ::String

    ################
    #              #
    # file pointer #
    #              #
    ################

    inputfile          ::IOStream
    potential_inputfile::IOStream
    eigenvaluefile     ::IOStream
    eigenvectorfile    ::IOStream

    Files() = new()
end