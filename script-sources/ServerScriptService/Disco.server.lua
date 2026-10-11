local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local MessagingService = game:GetService("MessagingService")

local JandelTemplate = ReplicatedStorage:WaitForChild("Jandel")
local currentJandelClone = nil

local function removeJandel()
	if currentJandelClone then
		currentJandelClone:Destroy()
		currentJandelClone = nil
		print("Jandel removed.")
	end
end

local function onWeatherMessage(message)
	local data = message.Data
	if typeof(data) ~= "table" or not data.weather then
		return
	end

	local weatherType = tostring(data.weather):lower()

	if weatherType == "disco" then
		if not currentJandelClone then
			currentJandelClone = JandelTemplate:Clone()
			currentJandelClone.Parent = Workspace
			print("Jandel spawned for Disco weather.")
		end
	else
		removeJandel()
	end
end

local function onStopWeatherMessage(message)
	removeJandel()
end

-- Subscribe to the "weather" topic
local success, err = pcall(function()
	MessagingService:SubscribeAsync("weather", onWeatherMessage)
end)

if not success then
	warn("Failed to subscribe to weather messages: " .. tostring(err))
end

-- Subscribe to the "stopweather" topic
local success2, err2 = pcall(function()
	MessagingService:SubscribeAsync("stopweather", onStopWeatherMessage)
end)

if not success2 then
	warn("Failed to subscribe to stopweather messages: " .. tostring(err2))
end
