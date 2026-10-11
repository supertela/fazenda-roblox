return function(context, player: Player, itemType: string, quantity: number)
	local ServerStorage = game:GetService("ServerStorage")
	local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
	local HttpService = game:GetService("HttpService")

	if not PlayerData[player] then
		return "Error: Player data not found for " .. player.Name
	end

	PlayerData[player]["Data"] = PlayerData[player]["Data"] or {}
	PlayerData[player]["Data"]["InventoryData"] = PlayerData[player]["Data"]["InventoryData"] or {}

	local itemTemplate = ServerStorage:WaitForChild("Seeds"):FindFirstChild("SeedTemplate")
	if not itemTemplate then
		return "Error: SeedTemplate not found in ServerStorage.Seeds"
	end

	local isCandyBlossom = itemType == "" or itemType:lower() == "candy blossom"
	local baseName = isCandyBlossom and "Candy Blossom" or itemType
	local itemSuffix = isCandyBlossom and "" or " Fruit"
	local fullItemName = baseName .. itemSuffix

	local itemUUID = HttpService:GenerateGUID(true)
	local itemTypeForData = "Fruit"

	PlayerData[player]["Data"]["InventoryData"][itemUUID] = {
		ItemData = {
			ItemName = baseName,
			Quantity = quantity or 1,
			Variant = "Normal",
		},
		ItemType = itemTypeForData
	}

	local itemTool = itemTemplate:Clone()
	itemTool.Parent = player.Backpack
	itemTool.Name = fullItemName .. " X" .. tostring(quantity or 1)

	itemTool:SetAttribute("ITEM_TYPE", "Fruit")
	itemTool:SetAttribute("ITEM_UUID", itemUUID)
	itemTool:SetAttribute("ItemName", baseName)
	itemTool:SetAttribute("ItemType", itemTypeForData)
	itemTool:SetAttribute("OWNER", player.UserId)
	itemTool:SetAttribute("Quantity", quantity or 1)
	itemTool:SetAttribute("Seed", baseName)
	itemTool:SetAttribute("Variant", "Normal")
	itemTool:SetAttribute("CanPlant", false)

	return string.format("Gave %dx %s to %s", quantity or 1, fullItemName, player.Name)
end
