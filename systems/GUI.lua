function AddNewGUI(player)

    local screen_element = player.gui.screen

    -- destroy and reinitiate
    if screen_element['blandycoin_main_frame'] then
        screen_element['blandycoin_main_frame'].destroy()
    end 
    
    if not screen_element['blandycoin_main_frame'] then

        --main window
        local main_frame = screen_element.add{type="frame", name="blandycoin_main_frame", caption={"blandy-coin.gui.credit-window"}, direction="vertical"}
        main_frame.style.size = {360, 260}
        main_frame.auto_center = true

        --labels for key stats
        local credits = main_frame.add{type = "label", name = "creditdata", caption = "Total Credits: " .. GetCredits(player.force) .. "c"}
        credits.style.font_color = {r=0, g=1, b=1, a=1}
        main_frame.add{type = "label", name = "credit-energy-income", caption = "Energy income: " .. math.floor(global.creditsfromenergy[player.force.name]) .. "c"}
        main_frame.add{type = "label", name = "credit-science-income", caption = "Science income: " .. math.floor(global.creditsfromscience[player.force.name]) .. "c"}
                        
        --content frame for team table
        local content_frame_parent = main_frame.add{type="frame", name="content_frame", direction="vertical"}
        content_frame_parent.add{type="label", name = "header", caption = "Teams:"}    

        local teamTable = content_frame_parent.add{type="table", name="table-time", column_count=3}

        teamTable.style.right_cell_padding = 14
        

        --loop to create rows of teams
        for _, force in pairs(game.forces) do
            if force.name ~= nil and not Contains(INVALID_FORCES, force.name) then 
                
                local forceName = force.name
                local forceCredits = force.name .. 'c'
                local giveforceName = 'give_credit_' .. force.name            
                local forceNameRow = force.name .. 'r'
                
                teamTable.add{type = "label", name = forceName, caption = force.name}                
                teamTable.add{type = "label", name = forceCredits, caption =  GetCredits(force)}    
                if force.name ~= player.force.name then 
                    teamTable.add{type = "button", name = giveforceName, caption = "Give 100"}    
                else
                    teamTable.add{type = "label", name = giveforceName, caption = ""}    
                end
            end
        end        
    end
end

function UpdateGUI()    
    
    for _, player in pairs(game.connected_players) do      
        
        local screen_element = player.gui.screen
        if screen_element['blandycoin_main_frame'] then    
            for _, force in pairs(game.forces) do
                
                screen_element['blandycoin_main_frame']['creditdata'].caption = "Total Credits: " .. GetCredits(player.force) .. "c"
                screen_element['blandycoin_main_frame']['credit-energy-income'].caption = "Energy income: " .. math.floor(global.creditsfromenergy[player.force.name]) .. "c"
                screen_element['blandycoin_main_frame']['credit-science-income'].caption = "Science income: " .. math.floor(global.creditsfromscience[player.force.name]) .. "c"
                                
                local teamTable = screen_element["blandycoin_main_frame"]["content_frame"]["table-time"]

                for _, force in pairs(game.forces) do
                    if force.name ~= nil and not Contains(INVALID_FORCES, force.name) then                         
                        local forceCredits = force.name .. 'c'                                                
                        teamTable[forceCredits].caption = GetCredits(force)                        
                    end
                end        
            end                 
        else
            AddNewGUI(player)
        end
    end    
end

function GUIClicked(guievent)
    
    local element = guievent.element
    local playerThatPressed = GetEventPlayer(guievent)
    
    --check element name to see if this was the transfer credit button pressed
    if(string.find(element.name, "give_credit_")) then        
        if HasEnoughCredits(playerThatPressed, 100) then

            --strip the give_credit_ part of the element name to be left with the force name, which we can then use to get the force credited
            local forceToReceive = string.gsub(element.name, "give_credit_", "")

            TransferCredits(playerThatPressed.force, game.forces[forceToReceive], 100)
            
            --message the relevant players
            playerThatPressed.print("Sent " .. forceToReceive .. " 100 credits")
            for d, receivePlayer in pairs(game.forces[forceToReceive].players) do
                receivePlayer.print("Received 100 credits from " .. playerThatPressed.force.name)
            end

            --force a UI update
            UpdateGUI()
        end        
    end
end

