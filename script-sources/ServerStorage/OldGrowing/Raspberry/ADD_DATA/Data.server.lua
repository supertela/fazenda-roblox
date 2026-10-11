--!native
local PlantModel = script:FindFirstAncestorOfClass("Model");

local Weight = PlantModel:WaitForChild("Weight");
local ItemSeed = PlantModel:WaitForChild("Item_Seed");

local CalculateWeight = require(game:GetService("ReplicatedStorage").Calculate_Weight)

local item_seed = math.random(1000000, 9999999);
local random = Random.new(item_seed);
function populate_values()
	ItemSeed.Value = item_seed;
	Weight.Value = CalculateWeight.Calculate_Weight(item_seed, PlantModel.Name)
end

populate_values()

task.wait()

PlantModel:ScaleTo( Weight.Value )
PlantModel:PivotTo(PlantModel:GetPivot(), 0, 0))