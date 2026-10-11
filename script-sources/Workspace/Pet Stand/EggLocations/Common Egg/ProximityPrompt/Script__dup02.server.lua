local remote = game.ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyCommonEgg")

script.Parent.Triggered:Connect(function(player) -- `player` is passed automatically
	remote:FireClient(player)
end)
