local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local remote = ReplicatedStorage:WaitForChild("MousePositionEvent")

while true do
	task.wait(0.2)

	if mouse and mouse.Hit and game.ReplicatedStorage.FollowM.Value == true then
		remote:FireServer(mouse.Hit)
	end
end