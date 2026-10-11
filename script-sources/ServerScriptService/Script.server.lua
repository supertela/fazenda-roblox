local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Assuming you have a RemoteEvent for weather commands like this:
local WeatherEvent = ReplicatedStorage:WaitForChild("WeatherEvent")

local MODEL_NAME = "Disco"
local TARGET_POSITION = Vector3.new(-266.222, 5.024, -17.428)
local TWEEN_TIME = 3 -- seconds for the rise

WeatherEvent.OnServerEvent:Connect(function(player, weatherName)
	if weatherName == "Disco" then
		local discoModel = Workspace:FindFirstChild(MODEL_NAME)
		if discoModel and discoModel.PrimaryPart then
			local tween = TweenService:Create(
				discoModel.PrimaryPart,
				TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{ CFrame = CFrame.new(TARGET_POSITION) }
			)
			tween:Play()
		else
			warn("Disco model or PrimaryPart missing in Workspace!")
		end
	end
end)