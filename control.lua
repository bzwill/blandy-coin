--[[
    Blandy Coin, by Blair & Andy
   
    Some concepts and inital code taken from Multiplayer Trading by Luke Perkin, who in turn states "Some concepts taken from Teamwork mod (credit to DragoNFly1) and Diplomacy mod (credit to ZwerOxotnik)"
]]

require "systems/coin"



PAID_ENTITY_TYPES =
{
    "electric-pole",    
    "transport-belt",            
    "straight-rail",
    "curved-rail",
}

function Init()
    global.credits = global.credits or {}
    global.coin_farms = global.coin_farms or {}	
	global.creditsfromenergy = global.creditsfromenergy or {}
	global.creditsfromscience = global.creditsfromscience or {}	
	
	for _, force in pairs(game.forces) do
        ForceCreated({force=force})
    end
    for player_index, player in pairs(game.players) do
        PlayerCreated({player_index=player_index})
    end
end

function PlayerCreated(event)
    local player = GetEventPlayer(event)
    AddCreditsGUI(player)
end

function ForceCreated(event)
    local force = event.force	
    if global.credits[force.name] == nil then
        global.credits[force.name] = settings.global['starting-credits'].value
    end
	
	if global.creditsfromenergy[force.name] == nil then
        global.creditsfromenergy[force.name] = 0
    end
	
	if global.creditsfromscience[force.name] == nil then
        global.creditsfromscience[force.name] = 0
    end
end

function ModConfigurationChanged(event)
    for _, player in pairs(game.players) do
        AddCreditsGUI(player)
    end
end

function AddCreditsGUI(player)
    --if player.gui.left['credits'] then
    --    player.gui.left['credits'].destroy()
    --end

    if not player.gui.top['credits'] then
        player.gui.top.add{type = "label", name = "credits", caption = {"blandy-coin.gui.credits"}, style = "caption_label"}
    end
	if not player.gui.top['creditsfromenergy'] then
        player.gui.top.add{type = "label", name = "creditsfromenergy", caption = {"blandy-coin.gui.creditsfromenergy"}, style = "caption_label"}
    end
	if not player.gui.top['creditsfromscience'] then
        player.gui.top.add{type = "label", name = "creditsfromscience", caption = {"blandy-coin.gui.creditsfromscience"}, style = "caption_label"}
    end
end

function PrintAll(text)
    for _, player in pairs(game.players) do
        player.print(text)
    end
end

function GetEventPlayer(event)
    if event.player_index then
        return game.players[event.player_index]
    else
        return nil
    end
end

function GetEventForce(event)
    if event.player_index then
        return GetEventPlayer(event).force
    elseif event.robot then
        return event.robot.force
    else
        return nil
    end
end

function Area(position, radius)
    return {
        {position.x - radius, position.y - radius},
        {position.x + radius, position.y + radius}
    }
end

function HandleEntityBuild(event)	

    local player = GetEventPlayer(event)
    local entity = event.created_entity

    if not entity.valid then return end
	    
    if entity.name == "coin-farm" then
        table.insert(global.coin_farms, {
            ['entity'] = entity,
            ['progress'] = 0
        })
    end
    
    if settings.global['expansion-cost'].value then
        if(Contains(PAID_ENTITY_TYPES, entity.type)) then         
            BuildPaidEntity(entity)                
		end
    end

end

function OnTick(event)
	if global.creditsfromenergy == nil then
		Init()
	end	
		

    for _, player in pairs(game.connected_players) do
        player.gui.top['credits'].caption = {"", {"blandy-coin.gui.credits"}, {"colon"}, math.floor(global.credits[player.force.name], "c")}
	end
	for _, player in pairs(game.connected_players) do
         player.gui.top['creditsfromenergy'].caption = {"", {"blandy-coin.gui.creditsfromenergy"}, {"colon"}, math.floor(global.creditsfromenergy[player.force.name], "c")}
    end
	for _, player in pairs(game.connected_players) do
        player.gui.top['creditsfromscience'].caption = {"", {"blandy-coin.gui.creditsfromscience"}, {"colon"}, math.floor(global.creditsfromscience[player.force.name], "c")}
    end

    for i=#global.coin_farms, 1, -1 do
        if not global.coin_farms[i].entity.valid then
            table.remove( global.coin_farms, i )
        end
    end

    local farmingspeed = settings.global['coin-farm-speed'].value
    
    --extra production when using science	
    for i, coin_farm in pairs(global.coin_farms) do
		local progress = coin_farm.entity.crafting_progress
		local force = coin_farm.entity.force
        --game.print(coin_farm.entity.name)
	    if progress >= 1 then
		    local sciencevalue = settings.global['science-coin-value'].value
			--force.item_production_statistics.on_flow("Coin from Science", amount)
			global.creditsfromscience[coin_farm.entity.force.name] = global.creditsfromscience[coin_farm.entity.force.name] + sciencevalue
		    AddCredits(coin_farm.entity.force, sciencevalue)
		end		
    end
end

function CanTransferCredits(control, amount)
    local credits = global.credits[control.force.name]
    if credits >= amount then
        return true
    end
    return false
end

function AddCredits(force, amount)
    global.credits[force.name] = global.credits[force.name] + amount
    force.item_production_statistics.on_flow("coin", amount)
end

script.on_nth_tick(60, function(event)
    --base production of coins from power

    for i, coin_farm in pairs(global.coin_farms) do
		local force = coin_farm.entity.force
		local basecoinrate = settings.global['coin-farm-speed'].value
		local energy = coin_farm.entity.energy / coin_farm.entity.electric_buffer_size
		local coinrate = energy * basecoinrate
		--force.item_production_statistics.on_flow("Coin from Energy", amount)
		global.creditsfromenergy[coin_farm.entity.force.name] = global.creditsfromenergy[coin_farm.entity.force.name] + coinrate
		AddCredits(coin_farm.entity.force,coinrate)		
	end

end)		

script.on_init(Init)
script.on_load(OnLoad)
script.on_configuration_changed(ModConfigurationChanged)
script.on_event(defines.events.on_tick, OnTick)
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, function(event)
    local can_build = true
    if settings.global['expansion-cost'].value then
        can_build = DestroyInvalidEntities(event)
    end
    if can_build then        
        HandleEntityBuild(event)
    end
end)

script.on_event({defines.events.on_entity_died, defines.events.on_player_mined_entity}, HandleEntityDied)
script.on_event(defines.events.on_player_created, PlayerCreated)
script.on_event(defines.events.on_force_created, ForceCreated)


remote.add_interface("blandy-coin", {
    ["add-money"] = function(force, amount)
        AddCredits(force, amount)
    end,
    ["get-money"] = function(force)
        return global.credits[force.name]
    end
})

function Contains (table, value)
    for index, value in ipairs(table) do
        if value == value then
            return true
        end
    end
    return false
end

