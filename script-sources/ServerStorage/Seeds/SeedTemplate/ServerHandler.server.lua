while script.Parent.Name == "SeedTemplate" do
	task.wait()
end

local SeedModel = game.ReplicatedStorage.Seed_Models:FindFirstChild(script.Parent:GetAttribute("ItemName") or "Carrot") 
if SeedModel then
	local clone = SeedModel:Clone()
	clone.Parent = script.Parent
	clone.Name = "Handle"
end