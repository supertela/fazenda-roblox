local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Template = ReplicatedStorage.PlantTemplates.TemplateGear
local Scale = require(ReplicatedStorage.Scale_Module)
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler)
local VariantVisual = require(ReplicatedStorage.Modules.VariantVisuals)
local Plants = require(script.Parent.Plants)

return function(model, variant, weight, c0, uuid)
	if not model then
		return false
	else
		local seed = model:FindFirstChild("Item_Seed")
		if seed then
			seed = seed.Value
		else
			local seedFound
			for player, objects in Plants do
				for id, plant in objects.Plants do
					if id == uuid then
						seedFound = plant.seed
					end
				end
				
				for id, fruit in objects.Fruits do
					if id == uuid then
						seedFound = fruit.seed
					end
				end
			end
			
			seed = seedFound
		end
		local model = model:Clone()
		local primaryPart = model.PrimaryPart
		
		weight *= 100
		weight = math.floor(weight)
		weight = weight / 100
		
		local newTemplate = Template:Clone()
		newTemplate.Variant.Value = variant
		newTemplate.Weight.Value = weight
		newTemplate.Item_String.Value = model.Name
		newTemplate:SetAttribute("UUID", uuid or game:GetService("HttpService"):GenerateGUID(true))
		newTemplate.Parent = ReplicatedStorage
		
		for _,v in model:GetChildren() do
			if v:IsA("BasePart") then
				v.Transparency = v:GetAttribute("OG_Transparency") or 1
				if v ~= primaryPart then
					local weld = Instance.new("WeldConstraint")
					weld.Part0 = primaryPart
					weld.Part1 = v
					weld.Parent = primaryPart
				end

				v.CanCollide = false
				v.Anchored = false
				v.Massless = true

				v.Parent = newTemplate.PlantModel
				
				if v:FindFirstChild("ProximityPrompt") then
					v.ProximityPrompt:Destroy()
				end
			end
		end
		
		local weld = Instance.new("Weld")
		weld.Part0 = newTemplate.Handle
		weld.Part1 = primaryPart
		weld.Parent = primaryPart
		
		if c0 then
			weld.C0 = c0
		end
		
		local mutations = MutationHandler:GetPlantMutations(model)
		for i, mutation in mutations do
			newTemplate:SetAttribute(mutation.Name, true)
		end
		
		local Connection = newTemplate.Equipped:Connect(function()
			local isFrozen = newTemplate:GetAttribute("Frozen")
			if isFrozen then
				newTemplate:SetAttribute("Frozen", false)
				newTemplate:SetAttribute("Frozen", true)
			end
		end)
		
		local Destroy; Destroy = newTemplate.Destroying:Connect(function()
			Connection:Disconnect()
			Destroy:Disconnect()
		end)
		
		if VariantVisual.functions[variant] then
			VariantVisual.functions[variant](newTemplate.PlantModel)
		end
		
		newTemplate:SetAttribute("Seed", seed)
		return newTemplate
	end
end