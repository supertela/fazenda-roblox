return function(context)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

	local Weathers = {
		{
			name = "BloodMoon",
			eventLength = 900,
			attribute = "BloodMoonEvent",
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

		-- Get or initialize active events
		local activeEvents = {} --workspace:GetAttribute("ActiveWeatherEvents") or {}
		local activeEventsMap = {}
		for _, event in ipairs(activeEvents) do
			activeEventsMap[event.name] = event
		end

		if activeEventsMap[name] then

			local event = activeEventsMap[name]
			event.eventLength = (event.eventLength or 0) + eventLength
			GameEvents.WeatherEventStarted:FireAllClients(name, event.eventLength)
			return `Extended duration of {name} by {eventLength} seconds`
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
			return `Started weather event: {name} for {eventLength} seconds`
		end
	end
	
	return startWeather(getWeatherByName(("BloodMoon"):lower()))
end