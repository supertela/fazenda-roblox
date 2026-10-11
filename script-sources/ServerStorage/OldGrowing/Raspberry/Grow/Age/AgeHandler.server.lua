--!native

local Fruit = game.ReplicatedStorage.Fruit_Spawn.Raspberry

local GrowRate = script.Parent.Parent:WaitForChild("Grow_Rate")
local ItemSpeedMult = script.Parent.Parent:WaitForChild("Item_Speed_Mult")
local Plant = script:FindFirstAncestorOfClass("Model");
local GrowTickTime = Plant:GetAttribute("GrowTickTime");
local GrowRateMulti = Plant:GetAttribute("GrowRateMulti")

local MaxAge = Plant:GetAttribute("MaxAge")

local RunService = game:GetService("RunService")
while true do
	local newValue = math.clamp(script.Parent.Value + GrowRate.Value * ItemSpeedMult.Value, 0, MaxAge)
	script.Parent.Value = newValue
	if script.Parent.Value == MaxAge then
		break
	end
	
	local waitTime = Random.new():NextNumber(GrowTickTime.Min, GrowTickTime.Max) * GrowRateMulti
	task.wait(waitTime)
end

-- fruit thing
while true do
	for i, v in Plant:GetChildren() do
		if v.Name == "Bush" then
			local x, y, z = 
				v.Position.X + math.random(-v.Size.X/1.5, v.Size.X/1.5),
				v.Position.Y + math.random(-v.Size.Y/1.5, v.Size.Y/1.5),
				v.Position.Z + math.random(-v.Size.Z/1.5, v.Size.Z/1.5)

			--// cannot have more than 4 fruits (MAKE IT 8 CUS ITS MODDED BOIII)
			if #Plant.Fruits:GetChildren() < 16 then
				local newFruit = Fruit:Clone()
				newFruit:SetAttribute("Owner", Plant:GetAttribute("Owner"))
				newFruit:SetPrimaryPartCFrame(CFrame.new(x, y, z) * CFrame.Angles(math.random() * 360, math.random() * 360, math.random() * 360))
				newFruit.Parent = Plant.Fruits
			else
				continue
			end
		end
	end
	
	-- normally 5 to 8 seconds
	task.wait(Random.new():NextNumber(2, 4))
end