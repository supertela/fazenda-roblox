local GrowRate = script.Parent.Parent:WaitForChild("Grow_Rate")
local ItemSpeedMult = script.Parent.Parent:WaitForChild("Item_Speed_Mult")

while task.wait(GrowRate.Value) do
	script.Parent.Value = GrowRate.Value * ItemSpeedMult.Value
end