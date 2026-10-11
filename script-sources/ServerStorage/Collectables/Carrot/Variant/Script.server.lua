local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local VariantVisuals = require(Modules:WaitForChild("VariantVisuals"))
local Plant = script:FindFirstAncestorWhichIsA("Model")

script.Parent.Changed:Connect(function(value: string) 
	VariantVisuals:SetVisuals(Plant, {DoEpicRainbow = false})	
end)