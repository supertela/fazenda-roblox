local ServerStorage = game:GetService("ServerStorage")
local function generateBushCluster(origin: Vector3, bushCount: number, clusterRadius: number, minSpacing: number)
	local bushModel = ServerStorage:FindFirstChild("PlantStages"):FindFirstChild("Raspberry"):FindFirstChild("Bush")
	if not bushModel then
		error("Bush model not found at game.ServerStorage.PlantStages.Raspberry.Bush")
		return
	end

	local placedBushes = {}
	local parent = script.Parent.Parent

	local firstBush = bushModel:Clone()
	firstBush.Position = origin
	firstBush.Transparency = 0
	firstBush.Parent = parent
	table.insert(placedBushes, firstBush)

	for i = 2, bushCount do
		local attempts = 0
		local maxAttempts = 50
		local newBush

		while attempts < maxAttempts do
			local angle = math.random() * 2 * math.pi
			local distance = math.random() * clusterRadius
			local offset = Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
			local newPosition = origin + offset

			local validPosition = true
			for _, bush in ipairs(placedBushes) do
				local distanceToBush = (bush.Position - newPosition).Magnitude
				if distanceToBush < minSpacing then
					validPosition = false
					break
				end
			end

			if validPosition then
				newBush = bushModel:Clone()
				newBush.Position = newPosition
				newBush.Transparency = 0
				newBush.Parent = parent
				table.insert(placedBushes, newBush)
				break
			end

			attempts += 1
		end

		if not newBush then
			warn("Could not place bush " .. i .. " within max attempts. Stopping cluster generation.")
			break
		end
	end

	return placedBushes
end

local origin = script.Parent.Parent:GetPrimaryPartCFrame().Position
local bushCount = math.random(3, 6)
local clusterRadius = 2
local minSpacing = 1
generateBushCluster(origin, bushCount, clusterRadius, minSpacing)