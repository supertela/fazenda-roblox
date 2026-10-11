local button = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FlyEvent = ReplicatedStorage:WaitForChild("FlyEvent")

local flying = false

button.MouseButton1Down:Connect(function()
	flying = true
	FlyEvent:FireServer(true) -- Start flying
end)

button.MouseButton1Up:Connect(function()
	flying = false
	FlyEvent:FireServer(false) -- Stop flying
end)
