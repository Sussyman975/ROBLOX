--[[
	// Author: @incognito.tab > Discord
	// Description: I dont know, i dont know, i dont know, i dont know, i dont know.

	// Time: 03/10/2024 4:48 AM
	// Extra: Discord.gg/PfXgy5Nq34
]]

-- // If you put multiple of them in the table it will be randomly generated.
-- // For example lets say you did "Clothed" and "Naked" it will randomly selected one of them as the mode.
-- // For example lets say you did "Female", "Male", "Femboy" it will randomly selected one of them as the gender.

local Game                          			= game
local Method 						= request
local Services                      			= setmetatable({}, {
    __index = function(Self, Service)
		local Cache    				= Game.GetService(Game, Service)

		rawset(Self, Service, Cache)

		return Cache
    end
})

local Success, Result               			= pcall(Method, {
	Url                            			= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/Main.lua",
	Method                          		= "GET"
})

if not Success then return end
if not Result.Body then return end

request({
	Url             				= "http://127.0.0.1:6463/rpc?v=1",
	Method              				= "POST",

	Headers = {
		["Content-Type"]			= "application/json",
		["Origin"]      			= "https://discord.com"
	},

	Body 						= Services.HttpService:JSONEncode({
		cmd             			= "INVITE_BROWSER",
		args            			= { code = "PfXgy5Nq34" },
		nonce           			= Services.HttpService:GenerateGUID(false)
	}),
})

loadstring(Result.Body)({
	Debug 						= false,
	Smoke 						= true,
	Physics 					= true,

	Data						= {
		Boobs 					= { 0.125, 0.8, 15, 0, 5 },
		Dick 					= { 0.075, 1, 15, 0, 5 },
		Ass 					= { 0.125, 0.75, 15, 0, 0 },
	},

	Mode 						= { "Clothed" }, -- // Naked, Clothed
	Gender 						= { "Female", "Futa" }, -- // Female, Male, Femboy, Futa
})
