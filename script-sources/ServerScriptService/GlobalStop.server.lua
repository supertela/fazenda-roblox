game:GetService("MessagingService"):SubscribeAsync("stopweather", function()
	local events = {
		"Blackhole",
		"BloodMoonEvent",
		"DiscoEvent",
		"DJJhai",
		"FrostEvent",
		"Hell",
		"MeteorShower",
		"RainEvent",
		"Thunderstorm",
		"JandelLazer",
		"Rainbow",
		"SheckleRain",
		"ChocolateRain",
		"BeenadoEvent",
		"Beestorm",
		"Windy",
		"TornadoEvent",
		"Beestorm",
	}

	for _, event in pairs(events) do
		workspace:SetAttribute(event, false)
	end
end)