function init()
    
    storage              = Storage()
    storage.files        = Files()
    storage.inputkeys    = Inputkeys()
    storage.potential    = Potential()
    
    inputcontrol = Dict() 

    for key in fieldnames(typeof(Inputkeys()))
        push!(inputcontrol, getfield(storage.inputkeys, key) => 0)
    end

    storage.inputcontrol = inputcontrol

    println(storage.inputcontrol)

    return storage
    
end