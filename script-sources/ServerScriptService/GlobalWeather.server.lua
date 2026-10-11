game:GetService("MessagingService"):SubscribeAsync("weather", function(sentData)
	local data = sentData.Data
	local weatherType = data.weather
	local duration = data.duration
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
	local Players = game:GetService("Players")
    local notification = ReplicatedStorage.GameEvents.Notification

	local Weathers = {
		{
			name = "Rain",
			eventLength = duration or 300,
			attribute = "RainEvent",
			mutations = {["Wet"] = 10}
		},
		{
			name = "Frost",
			eventLength = duration or 300,
			attribute = "FrostEvent",
			mutations = {["Frozen"] = 5, ["Chilled"] = 15}
		},
		{
			name = "Thunderstorm",
			eventLength = duration or 300,
			attribute = "Thunderstorm",
			mutations = {["Wet"] = 10}
		},
		{
			name = "Blackhole",
			eventLength = duration or 300,
			attribute = "Blackhole",
			mutations = {["Voidtouched"] = 10}
		},
		{
			name = "Disco",
			eventLength = duration or 300,
			attribute = "DiscoEvent",
			mutations = {["Disco"] = 5},   
			onStart = function()
				GameEvents.Notification:FireAllClients("🎉 DISCO TIMEEEEE 🎉", true)
                
			end,      
		},
		{
			name = "Night",
			eventLength = duration or 300,
			attribute = "NightEvent",
			mutations = {["Moonlit"] = 5}
		},
		{
			name = "BloodMoon",
			eventLength = duration or 300,
			attribute = "BloodMoonEvent",
			mutations = {["Bloodlit"] = 5}
		},
		{
			name = "MeteorShower",
			eventLength = duration or 300,
			attribute = "MeteorShower",
			mutations = {["Celestial"] = 5}
		},
		{
			name = "Rainbow",
			eventLength = duration or 300,
			attribute = "Rainbow",
			mutations = {["Rainbow"] = 5}
		},
		{
			name = "JandelLazer",
			eventLength = duration or 300,
			attribute = "JandelLazer",
			mutations = {["Plasma"] = 5}
		},
		{
			name = "SheckleRain",
			eventLength = duration or 300,
			attribute = "SheckleRain",
			mutations = {["Wet"] = 5}
		},
		{
			name = "Tornado",
			eventLength = duration or 300,
			attribute = "TornadoEvent",
			mutations = {["Wet"] = 5}
		},
		{
			name = "Windy",
			eventLength = duration or 300,
			attribute = "Windy",
			mutations = {["Chilled"] = 5}
		},
		{
			name = "ChocolateRain",
			eventLength = duration or 300,
			attribute = "ChocolateRain",
			mutations = {["Choc"] = 5}
		},
		{
			name = "BeeNado",
			eventLength = duration or 300,
			attribute = "BeenadoEvent",
			mutations = {["Pollinated"] = 5}
		},
		{
			name = "BeeStorm",
			eventLength = duration or 300,
			attribute = "Beestorm",
			mutations = {["Pollinated"] = 5}
		},
		{
			name = "Hell",
			eventLength = duration or 300,
			attribute = "Hell",
			mutations = {["BloodLit"] = 5}
		},
	}

	local function getWeatherByName(name)
		for _, weather in ipairs(Weathers) do
			if weather.name:lower() == name:lower() then
				return table.clone(weather)
			end
		end
		return nil
	end

	local function startWeather(weather)
		local name = weather.name
		local attribute = weather.attribute
		local eventLength = weather.eventLength
		local startTime = os.time()

		local activeEvents = {}
		local activeEventsMap = {}
		for _, event in ipairs(activeEvents) do
			activeEventsMap[event.name] = event
		end

		if activeEventsMap[name] then
			local event = activeEventsMap[name]
			event.eventLength = (event.eventLength or 0) + eventLength
			GameEvents.WeatherEventStarted:FireAllClients(name, event.eventLength)
		else
			local newEvent = {
				name = name,
				attribute = attribute,
				eventLength = eventLength,
				startTime = startTime,
				mutations = weather.mutations
			}
			table.insert(activeEvents, newEvent)
			workspace:SetAttribute(attribute, true)
			GameEvents.WeatherEventStarted:FireAllClients(name, eventLength)

			if typeof(weather.onStart) == "function" then
				task.spawn(weather.onStart)
			end
		end
	end

	weatherType = (weatherType or "random"):lower()

	if weatherType == "random" then
		local randomWeather = table.clone(Weathers[math.random(1, #Weathers)])
		randomWeather.eventLength = duration or randomWeather.eventLength
		startWeather(randomWeather)
	else
		local weather = getWeatherByName(weatherType)
		if weather then
			weather.eventLength = duration or weather.eventLength
			startWeather(weather)
		end
	end
end)