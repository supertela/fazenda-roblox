return function(context, player: Player, mutationName: string)
	local validMutations = {
		Shocked = true,
		Wet = true,
		Evil = true,
		Chilled = true,
		Frozen = true,
		Choc = true,
		Blackhole = true,
		Windstruck = true,
		Downbound = true,
		Twisted = true,
		Voidtouched = true,
		Disco = true,
		Plasma = true,
		Heavenly = true,
		Burnt = true,
		Moonlit = true,
		Bloodlit = true,
		Zombified = true,
		Celestial = true,
		HoneyGlazed = true,
		Pollinated = true,
		Watermelonin = true
	}
	
	local mutationHandler = require(game:GetService("ReplicatedStorage").Modules.MutationHandler)

	if not player then
		return "Error: Player not found"
	end

	local character = player.Character
	if not character then
		return "Error: Player character not found"
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return "Error: Humanoid not found"
	end

	local function isFruit(tool)
		if tool:FindFirstChild("Item_String") then
			local itemName = tool.Item_String.Value:lower()
			
			local fruitKeywords = {
				"mushroom", "candy", "blossom",
				"berry", "fruit", "carrot", "apple",
				"banana", "coconut", "dragon", "daffodil",
				"durian", "eden", "easter", "eggplant", 
				"plant", "egg", "mango", "papaya",
				"orange", "peach", "pear", "pepper",
				"pineapple", "beanstalk", "pumpkin", 
				"raspberry","red", "lollipop", "straw", 
				"tomato", "walking", "shark", 
				"watermelon", "wooden", "statue"
			}
			
			for _, keyword in ipairs(fruitKeywords) do
				if itemName:find(keyword) then
					return true
				end
			end
		end
		return false
	end

	local tool = nil
	for _, item in ipairs(character:GetChildren()) do
		if item:IsA("Tool") and isFruit(item) then
			tool = item
			break
		end
	end

	if not tool and player:FindFirstChild("Backpack") then
		for _, item in ipairs(player.Backpack:GetChildren()) do
			if item:IsA("Tool") and isFruit(item) then
				tool = item
				break
			end
		end
	end

	if not tool then
		return "Error: No fruit found in player's hand or backpack"
	end

	mutationName = mutationName:gsub("^%l", string.upper)
	if not validMutations[mutationName] then
		return string.format("Error: Invalid mutation name. Valid mutations are: %s", table.concat(table.keys(validMutations), ", "))
	end

	game:GetService("CollectionService"):AddTag(tool, "Mutatable")

	local mutation = {Name = mutationName, ValueMulti = 1}
	mutationHandler:AddMutation(tool, mutation)
	mutationHandler:SetToolName(tool)

	return string.format("Added %s mutation to %s's %s", mutationName, player.Name, tool.Name)
end