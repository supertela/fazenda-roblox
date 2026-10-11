return function(context, player: Player, gearType: string, quantity: number, uses: number)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerStorage = game:GetService("ServerStorage")
	local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
	local HttpService = game:GetService("HttpService")

	if gearType:lower() == "chocolate sprinker" then
		return "Error: Chocolate Sprinker cannot be given through this command"
	end

	if not PlayerData[player] then
		return "Error: Player data not found"
	end

	if not PlayerData[player]["Data"] then
		PlayerData[player]["Data"] = {}
	end

	if not PlayerData[player]["Data"]["InventoryData"] then
		PlayerData[player]["Data"]["InventoryData"] = {}
	end

	local gearUUID = HttpService:GenerateGUID(true)

	PlayerData[player]["Data"]["InventoryData"][gearUUID] = { 
		ItemData = {
			ItemName = gearType,
			Quantity = quantity or 1,
			UsesLeft = uses or 1,
			Variant = "Normal",
		},
		ItemType = "Gear"
	}

	local gearTemplate = ReplicatedStorage.Gears:FindFirstChild(gearType)
	if not gearTemplate then
		return string.format("Error: Gear template '%s' not found in ReplicatedStorage.Gears", gearType)
	end

	local gearTool = gearTemplate:Clone()
	gearTool.Parent = player.Backpack
	gearTool:SetAttribute("UsesLeft", PlayerData[player]["Data"]["InventoryData"][gearUUID]["ItemData"]["UsesLeft"])
	gearTool.Name = gearType .. " X"..tostring(PlayerData[player]["Data"]["InventoryData"][gearUUID]["ItemData"]["Quantity"])

	gearTool:SetAttribute("ITEM_TYPE", "Gear")
	gearTool:SetAttribute("ITEM_UUID", gearUUID)
	gearTool:SetAttribute("ItemName", gearType)
	gearTool:SetAttribute("ItemType", "Gear")
	gearTool:SetAttribute("OWNER", player.UserId)
	gearTool:SetAttribute("Quantity", quantity or 1)
	gearTool:SetAttribute("Gear", gearType)

	return string.format("Gave %dx %s to %s (Uses: %d)", 
		quantity or 1, 
		gearType, 
		player.Name,
		uses or 1
	)
end
