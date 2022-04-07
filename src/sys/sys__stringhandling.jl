function deletecomments(buffer::String)
    index = findfirst(isequal('#'), buffer)
    if index === nothing
        return buffer
    else
        return buffer[1:index-1]
    end
end