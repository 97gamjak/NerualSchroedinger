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
    paramfile_name          ::String #TODO: parse
    paramfile_a_name        ::String #TODO: parse 
    paramfile_b_name        ::String #TODO: parse
    paramfile_c_name        ::String #TODO: parse

    ################
    #              #
    # file pointer #
    #              #
    ################

    inputfile          ::IOStream
    potential_inputfile::IOStream
    eigenvaluefile     ::IOStream
    eigenvectorfile    ::IOStream
    paramfile_a        ::IOStream
    paramfile_b        ::IOStream
    paramfile_c        ::IOStream

    ####################
    # output directory #
    ####################

    directory::String

    Files() = new()
end