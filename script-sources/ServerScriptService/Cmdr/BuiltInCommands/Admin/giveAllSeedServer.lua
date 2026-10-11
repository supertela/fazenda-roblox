return function(context, player: Player, quantity: number)
	local ServerStorage = game:GetService("ServerStorage")
	local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
	local HttpService = game:GetService("HttpService")

	local seedTypes = {
		"Purple Cabbage", "Coconut", "Cactus", "Eggplant", "Dragon Fruit", 
		"Mango", "Grape", "Mushroom", "Peach", "Raspberry", "Pineapple", 
		"Papaya", "Banana", "Passionfruit", "Soul Fruit", "Cursed Fruit", 
		"Cranberry", "Durian","Venus Fly Trap", "Candy Blossom", 
		"Cherry Blossom", "Lemon", "Pear", "Beanstalk", "Pepper" -- Add more as needed
	}

	if not PlayerData[player] then
		return "Error: Player data not found"
	end

	PlayerData[player]["Data"] = PlayerData[player]["Data"] or {}
	PlayerData[player]["Data"]["InventoryData"] = PlayerData[player]["Data"]["InventoryData"] or {}

	local itemTemplate = ServerStorage:WaitForChild("Seeds"):FindFirstChild("SeedTemplate")
	if not itemTemplate then
		return "Error: SeedTemplate not found in ServerStorage.Seeds"
	end

	for _, seedName in ipairs(seedTypes) do
		local isCandyBlossom = seedName:lower() == "candy blossom"
		local isFruit = seedName:lower():find("fruit$") ~= nil or isCandyBlossom

		local baseName = seedName
		local itemSuffix = isFruit and " Fruit" or " Seed"
		local fullItemName = baseName .. itemSuffix

		local itemUUID = HttpService:GenerateGUID(true)

		local itemTypeForData = isFruit and not isCandyBlossom and "Fruit" or "Seed"

		PlayerData[player]["Data"]["InventoryData"][itemUUID] = {
			ItemData = {
				ItemName = baseName,
				Quantity = quantity or 1,
				Variant = "Rainbow",
			},
			ItemType = itemTypeForData
		}

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
		itemTool:SetAttribute("Variant", "Rainbow")
		itemTool:SetAttribute("CanPlant", true)
	end

	return string.format("Gave %dx of each seed to %s", quantity or 1, player.Name)
end
