--[[
	// Authors: @incognito.tab, @hookfunction > Discord
	// Time: 2024/02/18 - 1:52 AM
	// Description: Friend requested this, decided to release it.
]]

local Library 													= loadstring(game:HttpGet("https://raw.githubusercontent.com/lncoognito/Linoria/main/Library.lua"))()
Library.AccentColor											= Color3.fromRGB(255, 146, 197)

game.Workspace.DescendantAdded:Connect(function(Object)
	game.RunService.Stepped:Wait()

	if not string.find(Object.Name, "BarrierFor") then return end

	local Original 												= Object.CFrame
	local GSubbed 												= string.gsub(Object.Name, "BarrierFor", "")

	Object.CFrame												  = CFrame.new(9e9, 9e9, 9e9)
	
	local Visual												  = Instance.new("Part")
	local Mesh   												  = Instance.new("SpecialMesh")

	-- // Decoration
	do
		Visual.Anchored											= true
		Visual.CanCollide										= false
		Visual.CastShadow 									= false
		Visual.Transparency									= 0
		Visual.Material											= Enum.Material.ForceField
		Visual.Parent											  = workspace
		Visual.CFrame											  = Original
		Visual.Name												  = string.format("%s-Visual", GSubbed)

		Mesh.Scale											  	= Vector3.new(40, 25, 15)
		Mesh.Parent												  = Visual
		Mesh.MeshType											  = Enum.MeshType.Brick
		Mesh.TextureId											= "rbxassetid://5101923607"
		Mesh.VertexColor										= Vector3.new(1, 0.5, 0.5)
	end

	Object.Destroying:Connect(function()
		Mesh:Destroy()
		Visual:Destroy()
		Library:Notify(string.format("You got unblocked by %s", GSubbed), 5)
	end)

	Library:Notify(string.format("You got blocked by %s", GSubbed), 5)
end)
