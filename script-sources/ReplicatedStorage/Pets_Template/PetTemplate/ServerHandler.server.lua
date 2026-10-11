while script.Parent.Name == "PetTemplate" do
	task.wait()
end

local PetModel = game.ReplicatedStorage.Pets:FindFirstChild(script.Parent:GetAttribute("ItemName") or "Raccoon") 
if PetModel then
	local clone = PetModel:Clone()
	clone.Parent = script.Parent
	clone.Name = "Handle"
end