--[[
    Credit Management --
    Used to handle all credit functions, 
]]

function GetCredits(force)
    return math.floor(global.credits[force.name])
end

function HasEnoughCredits(entity, amount)    
    return ForceNameHasEnoughCredits(entity.force.name, amount)
end

function ForceNameHasEnoughCredits(force_name, amount)  
    local credits = global.credits[force_name]
    if credits >= amount then
        return true
    end
    return false
end

function AddCredits(force, amount)
    global.credits[force.name] = global.credits[force.name] + amount
    force.item_production_statistics.on_flow("coin", amount)
end

function RemoveCredits(force, amount)
    game.print(force.name)
    global.credits[force.name] = global.credits[force.name] - amount
    force.item_production_statistics.on_flow("coin", -amount)
end

function TransferCredits(give_force, receive_force, amount)
    RemoveCredits(give_force, amount)
    AddCredits(receive_force, amount)
end