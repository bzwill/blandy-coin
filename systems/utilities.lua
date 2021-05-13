--[[
    Utilities --
    Utility  and helper functions that don't belong to any major category
]]

function Contains (table, test)
    for index, value in ipairs(table) do
        if value == test then
            return true
        end
    end
    return false
end