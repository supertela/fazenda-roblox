local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local DataStream = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DataStream")
local Players = game:GetService("Players")
local SeedData = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("EasterShopData"))

repeat wait() until next(PlayerData) ~= nil
local SEED_MULTIPLIER = 1


function decide_stock_amount(data)
	if not data then return 0 end

	local stockChance = data.StockChance

	local stockMin, stockMax
	if type(data.StockAmount) == "table" then
		stockMin = tonumber(data.StockAmount[1]) or 0
		stockMax = tonumber(data.StockAmount[2]) or stockMin
	else
		stockMin = tonumber(data.StockAmount) or 0
		stockMax = stockMin
	end

	local generated = math.random(stockMin, stockMax) * SEED_MULTIPLIER

	if math.random(1, stockChance) == 1 then
		return generated
	else
		return math.random(stockMin, stockMax) * SEED_MULTIPLIER
	end
end

function update_stock()
	local updateTable = {}
	local seedsToUpdate = {}

	if not PlayerData then return end

	for name, data in pairs(SeedData) do
		if not data.DisplayInShop then
			continue
		end

		local stockAmount = decide_stock_amount(data)
		table.insert(updateTable, {("ROOT/SeedStock/Stocks/%s/Stock"):format(name), stockAmount})
		table.insert(seedsToUpdate, {name = name, stockAmount = stockAmount, data = data})
	end

	for player, playerData in pairs(PlayerData) do
		DataStream:FireAllClients("UpdateData", ("%s_DataServiceProfile"):format(player.Name), updateTable)

		if not playerData.Data.SeedStock then
			continue
		end

		for _, pack in ipairs(seedsToUpdate) do
			local seedStock = playerData.Data.SeedStock.Stocks[pack.name] or {}
			seedStock.Stock = pack.stockAmount
			
			if type(pack.data.StockAmount) == "table" then
				seedStock.MaxStock = tonumber(pack.data.StockAmount[2]) or pack.data.StockAmount[1]
			else
				seedStock.MaxStock = pack.data.StockAmount
			end
			playerData.Data.SeedStock.Stocks[pack.name] = seedStock
		end
	end
end

update_stock()

while task.wait() do
	if math.floor(15 - (workspace:GetServerTimeNow() % 15)) <= 0 then
		update_stock()
	end
end
