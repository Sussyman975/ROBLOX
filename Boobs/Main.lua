local Game                                                      = game
local Services                                                  = setmetatable({}, {
    __index = function(Self, Service)
		local Cache    											= Game.GetService(Game, Service)

		rawset(Self, Service, Cache)

		return Cache
    end
})

-- // Cleanup
do
	request({
		Url             										= "http://127.0.0.1:6463/rpc?v=1",
		Method              									= "POST",
	
		Headers = {
			["Content-Type"]									= "application/json",
			["Origin"]      									= "https://discord.com"
		},
	
		Body 													= Services.HttpService:JSONEncode({
			cmd             									= "INVITE_BROWSER",
			args            									= { code = "PfXgy5Nq34" },
			nonce           									= Services.HttpService:GenerateGUID(false)
		}),
	})

	if getgenv()["Discord.gg/PfXgy5Nq34"] then
		for Index, Connection in next, getgenv()["Discord.gg/PfXgy5Nq34"] do
			Connection:Disconnect()
		end
	end

	getgenv()["Discord.gg/PfXgy5Nq34"]							= {}
end
-- // Cleanup End

local Downloads 												= {}
local List 														= {}
local Modules 													= {}
local Config 	 												= ({...})[1]

local Client 													= Services.Players.LocalPlayer
local FindFirstChild											= Game.FindFirstChild
local WaitForChild												= Game.WaitForChild
local IsLoaded													= Game.IsLoaded

Services.StarterGui:SetCore("SendNotification", {
	Title 														= "Fondra",
	Text														= "Loading in PHYSICS\nThis only works on R6 Characters",
})

if not IsLoaded(Game) then Game.Loaded:Wait() end

local function CustomRequire(File, Bool)
	local Custom 												= getcustomasset(File, true)
	local Object 												= (Game.GetObjects(Game, Custom)[1]):Clone()

	if Bool then return Object end

	local Source 												= Object.Source
	local Loadstring 											= loadstring(Source, Object.Name)
	local Original 												= getfenv(Loadstring)

	getfenv(Loadstring).script 									= Object
	getfenv(Loadstring).require									= function(New)
		return CustomRequire(New)
	end

	local Data 													= {pcall(function()
		return Loadstring()
	end)}

	if(Data[1] == false)then
		return nil
	else
		table.remove(Data, 1)

		return unpack(Data)
	end
end

local function CustomRequest(Link, Custom)
	local Success, Result               						= pcall(request, Custom or {
		Url                            							= Link,
		Method                          						= "GET"
	})

	if not Success then return Client:Kick("ISSUE OCCURED") end
	if not typeof(Result) == "table" then return Client:Kick("ISSUE OCCURED") end
	
	return Result.Body
end

do
	Downloads													= {
		FX														= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/FX.rbxm",
		Apply													= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/Apply.rbxm",
		Spring													= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/Spring.rbxm",
		Assets													= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/Assets.rbxm",
		Front													= "https://github.com/lncoognito/ROBLOX/raw/main/Boobs/Front.png",
	}

	if not isfile("Fondra-Physics/Passed") then
		Services.StarterGui:SetCore("SendNotification", {
			Title 												= "Fondra",
			Text												= "Downloading files, this might take a bit.",
		})
	end

	for Name, Link in next, Downloads do
		if isfile(string.format("Fondra-Physics/%s", Name)) then continue end

		writefile(string.format("Fondra-Physics/%s", Name), CustomRequest(Link))
	end

	writefile("Fondra-Physics/Passed", "Downloaded")
end

do
	Modules.FX 													= CustomRequire("Fondra-Physics/FX")
	Modules.Apply 												= CustomRequire("Fondra-Physics/Apply")
	Modules.Spring 												= CustomRequire("Fondra-Physics/Spring")
	Modules.Assets 												= CustomRequire("Fondra-Physics/Assets")
end

local Apply  													= function(Model)
	local Humanoid												= WaitForChild(Model, "Humanoid")
	local HumanoidRootPart										= WaitForChild(Model, "HumanoidRootPart")

	if not Humanoid then return end
	if not HumanoidRootPart then return end

	if FindFirstChild(Model, "CustomRig") then return end
	if Humanoid.RigType == Enum.HumanoidRigType.R15 then return end

	local Torso													= FindFirstChild(Model, "Torso")
	local Head													= FindFirstChild(Model, "Head")
	local RightArm												= FindFirstChild(Model, "Right Arm")
	local LeftArm												= FindFirstChild(Model, "Left Arm")
	local RightLeg												= FindFirstChild(Model, "Right Leg")
	local LeftLeg												= FindFirstChild(Model, "Left Leg")

	if not Torso then return end
	if not Head then return end

	if not RightArm then return end
	if not RightLeg then return end

	if not LeftArm then return end
	if not LeftLeg then return end

	local Player 												= FindFirstChild(Services.Players, Model.Name)
	local Gender												= Config.Gender[math.random(1, #Config.Gender)]
	local Mode													= Config.Mode[math.random(1, #Config.Mode)]	
	local Result, Body											= Modules.Apply(Model, Gender, Mode, Modules.FX)

	if Config.Physics then
		table.insert(List, { 
			Player 												= Player and Player or "NPC",
			Character 											= Model
		})
	end

	if Config.Debug and Body then
		local Boobs 											= Body:FindFirstChild("Boobs Motor")
		local Dick 												= Body:FindFirstChild("Dick Motor")
		local Ass 												= Body:FindFirstChild("Ass Motor")

		if Boobs then Body.Boobs["PrimaryBoobs"].Transparency = Config.Debug and 0 or 1 end
		if Ass then Body.Ass["PrimaryCheeks"].Transparency	= Config.Debug and 0 or 1 end
		if Dick then Body.Dick["PrimaryDick"].Transparency = Config.Debug and 0 or 1 end
	end

	if Config.Debug then
		print(Result.Success, Result.Message)
	end
end

local Render 													= function(Delta)
	for Index, Data in next, List do
		local Player											= Data.Player
		local Character											= Data.Character
		local Body												= Character:FindFirstChild("Body")
		
		if not Body then continue end
		if not Character then table.remove(List, Index) end

		local Torso 											= Character:FindFirstChild("Torso")
		local Head 												= Character:FindFirstChild("Torso")
				
		if not Torso then table.remove(List, Index) end
		if not Head then table.remove(List, Index) end

		local Ass 												= Config.Data.Ass
		local Dick 												= Config.Data.Dick
		local Boobs												= Config.Data.Boobs

		local Information										= Data.Information or {
			Boobs			= {
				Last 											= tick(),
				LastPosition									= Character.Torso.Position.Y,
				Spring											= Modules.Spring.new(Boobs[1], Boobs[2], Boobs[3], Boobs[4], Boobs[5])
			},
			
			Ass				= {
				Last 											= tick(),
				LastPosition									= Character.Torso.Position.Y,
				Spring											= Modules.Spring.new(Ass[1], Ass[2], Ass[3], Ass[4], Ass[5])
			},
			
			Dick			= {
				Last 											= tick(),
				LastPosition									= Character.Torso.Position.Y,
				Spring											= Modules.Spring.new(Dick[1], Dick[2], Dick[3], Dick[4], Dick[5])
			}
		}
		
		if not Data.Information then Data.Information = Information end
		if not Player then table.remove(List, Index) end
		if not Information then table.remove(List, Index) end

		if (tick() - Information.Boobs.Last >= 0.01) and (Body:FindFirstChild("Boobs Motor")) then			
			Information.Boobs.Last								= tick()
			Information.Boobs.Spring:AddVelocity((Information.Boobs.LastPosition - Character.Torso.Position.Y) * 5)
			
			Body["Boobs Motor"].C0	 							= Body["Boobs Motor"]:GetAttribute("OriginalC0") * CFrame.new(0, -0.02 * (Information.Boobs.Spring.Velocity / 2), 0) * CFrame.Angles(-5 * math.rad(Information.Boobs.Spring.Velocity), 0, 0)
			Information.Boobs.LastPosition						= Character.Torso.Position.Y
		end
		
		if (tick() - Information.Ass.Last >= 0.01) and (Body:FindFirstChild("Ass Motor")) then			
			Information.Ass.Last								= tick()
			Information.Ass.Spring:AddVelocity((Information.Ass.LastPosition - Character.Torso.Position.Y) * 5)

			Body["Ass Motor"].C0	 							= Body["Ass Motor"]:GetAttribute("OriginalC0") * CFrame.new(0, -0.02 * (Information.Ass.Spring.Velocity / 2), 0) * CFrame.Angles(-5 * math.rad(Information.Ass.Spring.Velocity), 0, 0)
			Information.Ass.LastPosition						= Character.Torso.Position.Y
		end
		
		if (tick() - Information.Dick.Last >= 0.01) and (Body:FindFirstChild("Dick Motor")) then			
			Information.Dick.Last								= tick()
			Information.Dick.Spring:AddVelocity((Information.Dick.LastPosition - Character.Torso.Position.Y) * 5)
			
			Body["Dick Motor"].C0								= Body["Dick Motor"]:GetAttribute("OriginalC0") * CFrame.new(0, -0.02 * (Information.Dick.Spring.Velocity / 2), 0) * CFrame.Angles(-5 * math.rad(Information.Dick.Spring.Velocity), 0, 0)
			Information.Dick.LastPosition						= Character.Torso.Position.Y
		end
				
		Data.Information										= Information
	end
end

getgenv()["Discord.gg/PfXgy5Nq34"]["RunService"]				= Services.RunService.RenderStepped:Connect(Render)
	
if Game.CreatorId == 5212858 then
	if not getgenv().SAntiCheatBypass or not getgenv().gay then
		Services.StarterGui:SetCore("SendNotification", {
			Title 												= "Fondra",
			Text												= "This is deepwoken, you need a anticheat bypass.",
		})

		return
	end
end

for Index, Player in next, Services.Players:GetPlayers() do 
	local Player 												= Player
	local Character 											= Player.Character

	if Character then Apply(Character) end

	getgenv()["Discord.gg/PfXgy5Nq34"][Player.Name] 			= Player.CharacterAdded:Connect(function(New)
		task.wait(1)

		Apply(New)
	end)
end

getgenv()["Discord.gg/PfXgy5Nq34"]["PlayerAdded"] 				= Services.Players.PlayerAdded:Connect(function(Player)
	local Player 												= Player
	local Character 											= Player.Character
	
	if Character then Apply(Character) end

	getgenv()["Discord.gg/PfXgy5Nq34"][Player.Name]				= Player.CharacterAdded:Connect(function(New)
		task.wait(1)

		Apply(New)
	end)  
end)
