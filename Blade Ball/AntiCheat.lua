--[[
	// Author: @incognito.tab > Discord
	// Description: Bypasses the blade ball anticheat.

	// Time: 10/23/2023 7:08 PM
	// Extra: Pwease support me by joining my upcoming scripthub :3 "Discord.gg/fondra"
]]


local Namecall; Namecall                                        = hookmetamethod(game, "__namecall", function(Self, ...)
    local Arguments                                             = {...}
    local Name                                                  = tostring(Self)
    local Method                                                = getnamecallmethod()
    local Calling                                               = getcallingscript()

    if Method == "FireServer" and not checkcaller() then
        if Name == "" then return task.wait(9e9) end
    end

    -- Incase the game updates and adds client kicks
    if Method == "Kick" and not checkcaller() then return task.wait(9e9) end
    if Method == "kick" and not checkcaller() then return task.wait(9e9) end

    return Namecall(Self, unpack(Arguments))
end)

local Hook; Hook						= hookfunction(Instance.new("RemoteEvent").FireServer, function(Self, ...)
    local Arguments                                             = {...}
    local Name                                                  = Self.Name
        
    if not checkcaller() then
        if Name == "" then return end
    end
		
    return Hook(Self, unpack(Arguments))
end)
