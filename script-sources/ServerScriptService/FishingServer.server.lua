-- Sistema de pesca nos lagos (servidor)
-- Fluxo: ProximityPrompt no lago -> lancar -> espera aleatoria -> peixe fisga -> jogador puxa a tempo -> recompensa

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local FishingEvent = ReplicatedStorage:WaitForChild("FishingEvent")

local CONFIG = {
	MinWait = 3,          -- segundos minimos ate o peixe fisgar
	MaxWait = 8,          -- segundos maximos
	BiteWindow = 1.6,     -- tempo que o jogador tem para puxar
	Latency = 0.6,        -- tolerancia de rede no servidor
	Cooldown = 1.0,       -- espera entre uma pesca e outra
	PromptExtraDistance = 10, -- alcance do prompt alem da borda do lago
	LeaveExtraDistance = 8,   -- distancia extra antes de cancelar por afastamento
}

-- Peixes: weight = chance relativa, value = moedas
local FISH = {
	{ name = "Lambari",                rarity = "Comum",    weight = 50,  value = 5,   kg = {0.1, 0.4} },
	{ name = "Tilápia",                rarity = "Comum",    weight = 28,  value = 10,  kg = {0.5, 2} },
	{ name = "Tucunaré",               rarity = "Incomum",  weight = 12,  value = 25,  kg = {1, 5} },
	{ name = "Dourado",                rarity = "Raro",     weight = 6,   value = 60,  kg = {3, 12} },
	{ name = "Pirarucu",               rarity = "Épico",    weight = 3.5, value = 150, kg = {10, 60} },
	{ name = "Peixe Dourado Lendário", rarity = "Lendário", weight = 0.5, value = 600, kg = {1, 3} },
}

local totalWeight = 0
for _, f in ipairs(FISH) do totalWeight += f.weight end

local function rollFish()
	local r = math.random() * totalWeight
	for _, f in ipairs(FISH) do
		r -= f.weight
		if r <= 0 then return f end
	end
	return FISH[1]
end

-- leaderstats
local function setupStats(player)
	local ls = player:FindFirstChild("leaderstats")
	if not ls then
		ls = Instance.new("Folder")
		ls.Name = "leaderstats"
		ls.Parent = player
	end
	if not ls:FindFirstChild("Peixes") then
		local v = Instance.new("IntValue")
		v.Name = "Peixes"
		v.Parent = ls
	end
	if not ls:FindFirstChild("Moedas") then
		local v = Instance.new("IntValue")
		v.Name = "Moedas"
		v.Parent = ls
	end
end
Players.PlayerAdded:Connect(setupStats)
for _, p in ipairs(Players:GetPlayers()) do setupStats(p) end

-- Sessoes de pesca
local sessions = {}   -- [player] = { state, bobber, biteTime }
local cooldowns = {}  -- [player] = os.clock() liberado

local bobberFolder = workspace:FindFirstChild("BoiasDePesca")
if not bobberFolder then
	bobberFolder = Instance.new("Folder")
	bobberFolder.Name = "BoiasDePesca"
	bobberFolder.Parent = workspace
end

local function endSession(player, session)
	if session.bobber then
		session.bobber:Destroy()
		session.bobber = nil
	end
	if sessions[player] == session then
		sessions[player] = nil
	end
	cooldowns[player] = os.clock() + CONFIG.Cooldown
end

local function lakeInfo(agua)
	-- cilindro deitado: Size.X e a espessura, Size.Y o diametro
	local radius = agua.Size.Y / 2
	local topY = agua.Position.Y + agua.Size.X / 2
	return agua.Position, radius, topY
end

local function isNear(player, center, radius)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return false end
	local dx, dz = hrp.Position.X - center.X, hrp.Position.Z - center.Z
	return math.sqrt(dx * dx + dz * dz) <= radius + CONFIG.PromptExtraDistance + CONFIG.LeaveExtraDistance
end

local function makeBobber(center, radius, topY, playerPos)
	local flat = Vector3.new(playerPos.X - center.X, 0, playerPos.Z - center.Z)
	local dir = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(1, 0, 0)
	local pos = Vector3.new(center.X, topY + 0.2, center.Z) + dir * (radius * 0.55)

	local b = Instance.new("Part")
	b.Name = "Boia"
	b.Shape = Enum.PartType.Ball
	b.Size = Vector3.new(1.2, 1.2, 1.2)
	b.Color = Color3.fromRGB(230, 50, 50)
	b.Material = Enum.Material.SmoothPlastic
	b.Anchored = true
	b.CanCollide = false
	b.CanQuery = false
	b.CanTouch = false
	b.Position = pos
	b.Parent = bobberFolder
	return b
end

local function startFishing(player, agua)
	if sessions[player] then return end
	if cooldowns[player] and os.clock() < cooldowns[player] then return end

	local center, radius, topY = lakeInfo(agua)
	if not isNear(player, center, radius) then return end

	local hrp = player.Character.HumanoidRootPart
	local session = { state = "casting" }
	sessions[player] = session
	session.bobber = makeBobber(center, radius, topY, hrp.Position)
	FishingEvent:FireClient(player, "Cast")

	task.spawn(function()
		local waitTime = CONFIG.MinWait + math.random() * (CONFIG.MaxWait - CONFIG.MinWait)
		local elapsed = 0
		while elapsed < waitTime do
			task.wait(0.25)
			elapsed += 0.25
			if sessions[player] ~= session then return end -- cancelado ou puxou cedo
			if not isNear(player, center, radius) then
				FishingEvent:FireClient(player, "Result", false, "Você se afastou do lago.")
				endSession(player, session)
				return
			end
		end
		if sessions[player] ~= session then return end

		-- peixe fisgou
		session.state = "bite"
		session.biteTime = os.clock()
		if session.bobber then
			local b = session.bobber
			TweenService:Create(
				b,
				TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 5, true),
				{ Position = b.Position - Vector3.new(0, 0.7, 0) }
			):Play()
		end
		FishingEvent:FireClient(player, "Bite", CONFIG.BiteWindow)

		task.wait(CONFIG.BiteWindow + CONFIG.Latency)
		if sessions[player] == session and session.state == "bite" then
			FishingEvent:FireClient(player, "Result", false, "O peixe escapou!")
			endSession(player, session)
		end
	end)
end

FishingEvent.OnServerEvent:Connect(function(player, action)
	if action ~= "Reel" and action ~= "Cancel" then return end
	local session = sessions[player]
	if not session then return end

	if action == "Cancel" then
		endSession(player, session)
		return
	end

	if session.state == "casting" then
		FishingEvent:FireClient(player, "Result", false, "Você puxou cedo demais!")
		endSession(player, session)
	elseif session.state == "bite" then
		if os.clock() - session.biteTime <= CONFIG.BiteWindow + CONFIG.Latency then
			session.state = "done"
			local fish = rollFish()
			local kg = math.floor((fish.kg[1] + math.random() * (fish.kg[2] - fish.kg[1])) * 100 + 0.5) / 100

			setupStats(player)
			local ls = player.leaderstats
			ls.Peixes.Value += 1
			ls.Moedas.Value += fish.value

			FishingEvent:FireClient(player, "Result", true, {
				name = fish.name, rarity = fish.rarity, kg = kg, value = fish.value,
			})
			endSession(player, session)
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	local s = sessions[player]
	if s then endSession(player, s) end
	sessions[player] = nil
	cooldowns[player] = nil
end)

-- Cria o prompt de pesca em cada lago
local lagos = workspace:WaitForChild("MapaGrowAGarden"):WaitForChild("Lagos")
for _, lago in ipairs(lagos:GetChildren()) do
	local agua = lago:FindFirstChild("Agua", true)
	if agua and agua:IsA("BasePart") then
		local _, radius = lakeInfo(agua)
		local prompt = Instance.new("ProximityPrompt")
		prompt.Name = "PromptPesca"
		prompt.ActionText = "Pescar"
		prompt.ObjectText = "Lago"
		prompt.HoldDuration = 0.3
		prompt.RequiresLineOfSight = false
		prompt.MaxActivationDistance = radius + CONFIG.PromptExtraDistance
		prompt.Parent = agua
		CollectionService:AddTag(agua, "LagoPesca")
		prompt.Triggered:Connect(function(player)
			startFishing(player, agua)
		end)
	end
end
