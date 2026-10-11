
local remote = game.ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyCommonEgg")
local gui = script.Parent

-- Ensure GUI is initially disabled (optional)
gui.Enabled = false

-- When the remote is fired from the server, enable the GUI
remote.OnClientEvent:Connect(function()
	gui.Enabled = true
end)
