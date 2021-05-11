function GetClaimCost(entity)

    if entity.type == "electric-pole" then
		local supply_area = entity.prototype.supply_area_distance
        local cost = supply_area * supply_area * settings.global['cost-per-tile-for-energy'].value
        return {cost = cost, can_afford = CanTransferCredits(entity, cost)}

    elseif entity.type == "straight-rail" or entity.type == "curved-rail" then
	    game.print(entity.type)
        local cost = settings.global['rail-cost'].value		
        return {cost = cost, can_afford = CanTransferCredits(entity, cost)}  

    elseif entity.type == "transport-belt" then         
        local cost = settings.global['fast-belt-cost'].value	
		local belttype = entity.prototype.name		

		if belttype == "transport-belt" then
			cost = settings.global['belt-cost'].value
			return {cost = cost, can_afford = CanTransferCredits(entity, cost)}			
			
				elseif belttype == "fast-transport-belt" then
				cost = settings.global['fast-belt-cost'].value
				return {cost = cost, can_afford = CanTransferCredits(entity, cost)}	
			
				elseif belttype == "express-transport-belt" then
				cost = settings.global['express-belt-cost'].value 
				return {cost = cost, can_afford = CanTransferCredits(entity, cost)}	
			
			else
						
			cost = settings.global['belt-cost'].value 
		
		return {cost = cost, can_afford = CanTransferCredits(entity, cost)}				
		end				
	end
    return {cost = false}	
end

function BuildPaidEntity(entity)
    local claim = GetClaimCost(entity)
	if claim.cost then
        global.credits[entity.force.name] = global.credits[entity.force.name] - claim.cost		
    end
end

function DestroyInvalidEntities(event)    
    
    local entity = event.created_entity
    local player = GetEventPlayer(event)    
    local claimCost = GetClaimCost(entity)

    local noBuildDueToExpense = (claimCost.cost and not claimCost.can_afford)
                
    if noBuildDueToExpense then
        player.print{"message.cannot-claim"}
    end        

    if noBuildDueToExpense then
        if player then
            player.mine_entity(entity, true)
        else
            entity.destroy()
        end
        return false
    end

    return true    
end