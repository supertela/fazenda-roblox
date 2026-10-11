-- WeatherService.lua
-- ServerScriptService.Modules

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local GameEvents        = ReplicatedStorage:WaitForChild("GameEvents")
local SeedModels        = ReplicatedStorage:WaitForChild("Seed_Models")

local Weathers = {
	{ name = "Rain",         eventLength = 300, weight = 40, attribute = "RainEvent",        mutations = { ["Wet"] = 10 } },
	{ name = "Frost",        eventLength = 300, weight = 30, attribute = "FrostEvent",       mutations = { ["Frozen"] = 5, ["Chilled"] = 15 } },
	{ name = "Thunderstorm", eventLength = 300, weight = 20, attribute = "Thunderstorm",     mutations = { ["Shocked"] = 10 } },
	{ name = "MeteorShower", eventLength = 300, weight = 20, attribute = "MeteorShower",     mutations = { ["Celestial"] = 10 } },
	{ name = "Moonlit",      eventLength = 250, weight = 30, attribute = "Moonlit",           mutations = { ["Moonlit"] = 30 } },
	{ name = "BeeStorm",     eventLength = 250, weight = 30, attribute = "BeeStorm",          mutations = { ["Pollinated"] = 5 } },
	{ name = "Disco",        eventLength = 300, weight = 0,  attribute = "DiscoEvent",        mutations = { ["Disco"] = 5 } }, -- Not random
}

local WeatherService = {
	activeEvents = {},
	randomEnabled = true
}

-- Get total weight
local function totalWeight()
	local sum = 0
	for _, w in ipairs(Weathers) do
		sum = sum + w.weight
	end
	return sum
end

-- Get a random weather (excluding Disco by weight)
function WeatherService:getRandomWeather()
	local roll, acc = math.random() * totalWeight(), 0
	for _, w in ipairs(Weathers) do
		acc = acc + w.weight
		if roll <= acc then
			return table.clone(w)
		end
	end
	return table.clone(Weathers[1])
end

-- Start a specific weather manually
function WeatherService:startCustomWeather(name, duration)
	for _, w in ipairs(Weathers) do
		if w.name:lower() == name:lower() then
			local ev = table.clone(w)
			ev.eventLength = duration
			ev.startTime = workspace:GetServerTimeNow()

			for _, ex in ipairs(self.activeEvents) do
				if ex.name == ev.name then
					ex.startTime = ev.startTime
					ex.eventLength = ev.eventLength
					workspace:SetAttribute(ev.attribute, true)
					GameEvents.WeatherEventStarted:FireAllClients(ev.name, ev.eventLength)
					return
				end
			end

			table.insert(self.activeEvents, ev)
			workspace:SetAttribute(ev.attribute, true)
			GameEvents.WeatherEventStarted:FireAllClients(ev.name, ev.eventLength)

			-- Handle Disco bonus
			if ev.name == "Disco" then
				local seedModel = SeedModels:FindFirstChild("Candy Blossom")
				if seedModel then
					for _, player in pairs(Players:GetPlayers()) do
						local clone = seedModel:Clone()
						clone.Parent = player:WaitForChild("Backpack")
						GameEvents.Notification:FireClient(player, "You have received a seed from the lords", true)
					end
				end
			end
			return
		end
	end
	warn("[WeatherService] Unknown weather type: " .. name)
end

-- Start a random weather event
function WeatherService:startRandomWeather()
	local ev = self:getRandomWeather()
	ev.startTime = workspace:GetServerTimeNow()
	table.insert(self.activeEvents, ev)
	workspace:SetAttribute(ev.attribute, true)
	GameEvents.WeatherEventStarted:FireAllClients(ev.name, ev.eventLength)
end

-- Stop a weather event
function WeatherService:stopWeather(name)
	for i = #self.activeEvents, 1, -1 do
		if self.activeEvents[i].name == name then
			local ev = table.remove(self.activeEvents, i)
			workspace:SetAttribute(ev.attribute, false)
			ev.eventLength = 0
			GameEvents.SendClientWeatherEvents:FireAllClients(ev, ev.name, ev.startTime)
		end
	end
end

-- Get all active weather events
function WeatherService:getActiveWeathers()
	return self.activeEvents
end

-- Weather update loop
task.spawn(function()
	local lastTime, gap = 0, 600
	while task.wait(1) do
		local now = workspace:GetServerTimeNow()

		for _, ev in ipairs(WeatherService.activeEvents) do
			if now - ev.startTime >= ev.eventLength then
				WeatherService:stopWeather(ev.name)
			end
		end

		if WeatherService.randomEnabled and #WeatherService.activeEvents == 0 and now - lastTime >= gap then
			lastTime = now
			WeatherService:startRandomWeather()
		end
	end
end)

return WeatherService