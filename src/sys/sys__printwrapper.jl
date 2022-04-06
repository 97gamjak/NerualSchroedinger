function printerror(message::String)
    println("")
    printstyled("ERROR:   "; color = :red)
    println(message)
end

function printwarning(message::String)
    println("")
    printstyled("WARNING: "; color = :yellow)
    println(message)
end

function printempty(message::String)
    printstyled("         ")
    println(message)
end

function printcenter(message::String, consolewidth::Int64)
    lenmes       = length(message)%2 == 0 ? length(message)/2 : (length(message)+1)/2
    nwhitespaces = consolewidth - lenmes
    
    for i in 1:nwhitespaces
        printstyled(" ")
    end
    println(message)
end