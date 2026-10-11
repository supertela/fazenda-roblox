return function(context, player: Player, itemType: string, quantity: number)
	local ServerStorage = game:GetService("ServerStorage")
	local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
	local HttpService = game:GetService("HttpService")

	local isCandyBlossom = itemType:lower() == "candy blossom"
	local isFruit = itemType:lower():find("fruit$") ~= nil or isCandyBlossom

	local baseName
	local itemSuffix

	if isCandyBlossom then
		baseName = "Candy Blossom"
		itemSuffix = ""
	else
		baseName = itemType:gsub("%s*[sS]eed$", ""):gsub("%s*[fF]ruit$", "")
		itemSuffix = isFruit and " Fruit" or " Seed"
	end

	local fullItemName = baseName .. itemSuffix

	if not PlayerData[player] then
		return "Error: Player data not found"
	end

	if not PlayerData[player]["Data"] then
		PlayerData[player]["Data"] = {}
	end

	if not PlayerData[player]["Data"]["InventoryData"] then
		PlayerData[player]["Data"]["InventoryData"] = {}
	end

	local itemUUID = HttpService:GenerateGUID(true)

	local itemTypeForData = "Seed" -- Default to Seed for planting
	if isFruit and not isCandyBlossom then
		itemTypeForData = "Fruit"
	end

	PlayerData[player]["Data"]["InventoryData"][itemUUID] = { 
		ItemData = {
			ItemName = baseName,
			Quantity = quantity or 1,
			Variant = "Normal",
		},
		ItemType = itemTypeForData
	}

	local itemTemplate = ServerStorage:WaitForChild("Seeds"):FindFirstChild("SeedTemplate")
	if not itemTemplate then
		return "Error: SeedTemplate not found in ServerStorage.Seeds"
	end

	local itemTool = itemTemplate:Clone()
	itemTool.Parent = player.Backpack
	itemTool.Name = fullItemName .. " X" .. tostring(quantity or 1)

	itemTool:SetAttribute("ITEM_TYPE", "Seed") 
	itemTool:SetAttribute("ITEM_UUID", itemUUID)
	itemTool:SetAttribute("ItemName", baseName)
	itemTool:SetAttribute("ItemType", "Seed")  
	itemTool:SetAttribute("OWNER", player.UserId)
	itemTool:SetAttribute("Quantity", quantity or 1)
	itemTool:SetAttribute("Seed", baseName)    
	itemTool:SetAttribute("Variant", "Normal")


	itemTool:SetAttribute("CanPlant", true)

	return string.format("Gave %dx %s to %s (Type: %s)", 
		quantity or 1, 
		fullItemName, 
		player.Name,
		itemTypeForData
	)
end