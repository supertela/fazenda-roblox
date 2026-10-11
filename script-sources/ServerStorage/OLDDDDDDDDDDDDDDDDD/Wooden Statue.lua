local WoodenStatue = {}
WoodenStatue.__index = WoodenStatue

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Plants = require(ServerStorage.Plants)

local VariantVisuals = require(Modules:WaitForChild("VariantVisuals"))
local Maid = require(Modules:WaitForChild("Maid"))

local CalWeight = require(ReplicatedStorage.Calculate_Weight)
local Item_Module = require(ReplicatedStorage.Item_Module)
local TurnToTool = require(ServerStorage.TurnToTool)

function RandomNumber(Seed, Min, Max)
	local Rand = Random.new(Seed)
	if not Min or not Max then
		return Rand:NextNumber()
	else
		return Rand:NextNumber(Min, Max)
	end
end

function WoodenStatue.new(uuid, origin, owner, model, lastUpd)
	if not Plants[owner] then
		return
	end
	
	local self = setmetatable({}, WoodenStatue)
	self.owner = owner
	self.model = model
	self.grow = self.model.Grow; self.growOrigin = origin
	
	self.seed = self.model.Item_Seed.Value
	self.weight = CalWeight.Calculate_Weight(self.seed, script.Name)
	self.maxage = 25
	self.plantdown = 0.25
	
	local data = Item_Module.Return_Data(script.Name);
	self.data = data;

	local scale_divisor = data[2];
	local value_per = data[3];
	local chance_to_grow_huge = 1/data[4];

	self.scale = self.weight / scale_divisor;
	self.model:ScaleTo(self.scale)
	
	self.gtt = NumberRange.new(0.8, 1.2)
	self.grm = 1
	
	self.maid = Maid.new()
	self.lastUpd = lastUpd or os.time()
	self.lastWaitTime = 0
	self.lastTick = 0
	self.progress = 0
	self.uuid = uuid or HttpService:GenerateGUID(true)
	
	self.isGrowing = false
	
	Plants[self.owner].Plants[self.uuid] = self
	self.model:SetAttribute("MaxAge", self.maxage)
	
	for _, part: BasePart in model:GetChildren() do
		if part:IsA("BasePart") then
			part:SetAttribute("id", HttpService:GenerateGUID(true))
		end
	end

	self.model.Weight.Value = self.weight
	if self.model.Variant.Value ~= "Normal" then
		VariantVisuals:SetVisuals(self.model, {DoEpicRainbow = false})	
	end
	
	self.maid:GiveTask(self.model.Variant.Changed:Connect(function(value: string) 
		VariantVisuals:SetVisuals(self.model, {DoEpicRainbow = false})	
	end))
	
	self.maid:GiveTask(self.model.Destroying:Connect(function()
		self:CleanUp()
	end))
	
	--// Offline grow
	local now = os.time()
	local elapsed = now - self.lastUpd

	local avgTickTime = (self.gtt.Min + self.gtt.Max) / 2 * self.grm
	local ticksElapsed = math.floor((elapsed / avgTickTime) * 0.4)

	local growthPerTick = self.grow.Grow_Rate.Value * self.grow.Item_Speed_Mult.Value
	local offlineGrowth = ticksElapsed * growthPerTick

	self.grow.Age.Value = math.clamp(self.grow.Age.Value + offlineGrowth, 0, growthPerTick * math.ceil(self.maxage / growthPerTick))
	self.age = self.grow.Age.Value
	
	local _model = self.model:Clone()
	_model:MoveTo(_model:GetPrimaryPartCFrame().Position - Vector3.new(0, self.plantdown * 2, 0))

	for _, part: BasePart in model:GetChildren() do
		if part:IsA("BasePart") and tonumber(part.Name) then
			local otherPart
			for _, prt in _model:GetChildren() do
				if prt:IsA("BasePart") and prt:GetAttribute("id") == part:GetAttribute("id") then
					otherPart = prt
					break
				end
			end

			part:SetAttribute("CanCollide", part.CanCollide)
			part:SetAttribute("CFrame", otherPart.CFrame);
			part:SetAttribute("Size", part.Size);

			part.CanCollide = false
			part.Transparency = 1;
			--if part.Name == "3" then
			--	part.CFrame *= CFrame.new(0, -3, 0)
			--else
			part.Position = Vector3.new(part.Position.X, part.Position.Y - (part.Size.Y / 2), part.Position.Z)
			part.Size = Vector3.new(part.Size.X, 0, part.Size.Z);
			--end

			if self.age > self.maxage then
				part:SetAttribute("DoneGrowing", true);
			else
				part:SetAttribute("DoneGrowing", nil);
			end
		end
	end

	_model:Destroy()
	model:AddTag("PlantGenerated")
	self:GrowStart()
	return self
end

function WoodenStatue:ShowGrowProcess()
	local age = math.min(math.ceil(self.age), self.maxage)
	--warn(self.progress, age, self.age)

	for _, part in self.model:GetChildren() do
		if tonumber(part.Name) and part:IsA("BasePart") then
			if part.Name == tostring(age) then
				part.CanCollide = part:GetAttribute("CanCollide")
				part.Transparency = part:GetAttribute("OG_Transparency")
				--if age >= self.maxage then
				--	part.CFrame = part.CFrame:Lerp(part:GetAttribute("CFrame"), 0.5)
					
				--	if part.CFrame == part:GetAttribute("CFrame") then
				--		part:SetAttribute("DoneGrowing", true)
				--	end
				--else
					--warn(1 / math.ceil(1 / (self.grow.Grow_Rate.Value * self.grow.Item_Speed_Mult.Value)))
				part.Size = part.Size:Lerp(part:GetAttribute("Size"), math.min(self.progress, 1))
				part.CFrame = part.CFrame:Lerp(part:GetAttribute("CFrame"), math.min(self.progress, 1))
				--print(age, self.age, self.progress, self.maxage, part.Size.Y / part:GetAttribute("Size").Y)
				
				if self.progress >= 1 then
					part:SetAttribute("DoneGrowing", true)
				end
				--end
			elseif tonumber(part.Name) <= age and part.Size ~= part:GetAttribute("Size") then
				--warn('set part', part.Name, 'to max size')
				self.progress = 0.2
				part.Size = part.Size:Lerp(part:GetAttribute("Size"), 1)
				part.CFrame = part.CFrame:Lerp(part:GetAttribute("CFrame"), 1)
				
				part.CanCollide = part:GetAttribute("CanCollide")
				part.Transparency = part:GetAttribute("OG_Transparency")
				part:SetAttribute("DoneGrowing", true)
			end
		end
	end
end

function WoodenStatue:GrowStart()
	if self.isGrowing then
		return
	end
	self.isGrowing = true
	
	local taskId; taskId = self.maid:GiveTask(RunService.Heartbeat:Connect(function(dt: value)
		if not (tick() - self.lastTick >= self.lastWaitTime) then
			return
		end
		
		self.lastTick = tick()
		self.lastWaitTime = RandomNumber(self.seed, self.gtt.Min, self.gtt.Max) * self.grm

		local newValue = math.max(self.grow.Age.Value + self.grow.Grow_Rate.Value * self.grow.Item_Speed_Mult.Value, 0)
		self.age = newValue
		self.grow.Age.Value = newValue
		
		if self.progress < 1 then
			self.progress += self.grow.Grow_Rate.Value * self.grow.Item_Speed_Mult.Value
		else
			self.progress = 0.2
		end
		self:ShowGrowProcess()
		self.lastUpd = os.time()
		
		local partCount = 0
		local doneGrowing = 0
		for _, part in self.model:GetChildren() do
			if part:IsA("BasePart") and part:GetAttribute("CFrame") then
				partCount = partCount + 1
				if part:GetAttribute("DoneGrowing") then
					doneGrowing = doneGrowing + 1
				end
			end
		end
		
		if self.age >= self.maxage and partCount == doneGrowing then
			self.isGrowing = false
			self:GrowFinish()
			
			local task = self.maid._tasks[taskId]
			task:Disconnect()
			self.maid._tasks[taskId] = nil
			return
		end
	end))
end

function WoodenStatue:Collect(playerWhoTriggered, uuid)
	if playerWhoTriggered ~= self.owner then
		return
	end

	local VariantVal = self.model:FindFirstChild("Variant")
	local Variant = VariantVal and VariantVal.Value or "Normal"

	local tool = TurnToTool(self.model, Variant, self.weight, nil, uuid)
	if tool then
		tool.Parent = playerWhoTriggered.Backpack
		self.model:Destroy()
	end
end

function WoodenStatue:GrowFinish()
	for _, part in self.model:GetChildren() do
		if tonumber(part.Name) and part:IsA("BasePart") then
			part.Size = part.Size:Lerp(part:GetAttribute("Size"), 1)
			part.CFrame = part.CFrame:Lerp(part:GetAttribute("CFrame"), 1)

			part.CanCollide = part:GetAttribute("CanCollide")
			part.Transparency = part:GetAttribute("OG_Transparency")

			part:SetAttribute("DoneGrowing", true)
		end
	end
	
	local prompt = self.model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		prompt.Enabled = true
		self.maid:GiveTask(prompt.Triggered:Connect(function(playerWhoTriggered: Player)
			
		end))
	end
end

function WoodenStatue:CleanUp()
	self.maid:DoCleaning()
	Plants[self.owner].Plants[self.uuid] = nil
end

return WoodenStatue