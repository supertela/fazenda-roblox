script.Parent.MouseButton1Click:Connect(function()
	local amount = 10000
	game.ReplicatedStorage.GameEvents.GimmeMoneyz:FireServer(amount)
end)