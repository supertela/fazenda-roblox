local Beanstalk = {}
Beanstalk.__index = Beanstalk

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

function Beanstalk.new(uuid, origin, owner, model, lastUpd, lastFruit)
	if not Plants[owner] then
		return
	end
	
	local self = setmetatable({}, Beanstalk)
	self.owner = owner
	self.model = model
	self.grow = self.model.Grow; self.growOrigin = origin
	
	self.seed = self.model.Item_Seed.Value
	self.weight = CalWeight.Calculate_Weight(self.seed, script.Name)
	self.maxage = 60
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
	
	self.fruitProduce = NumberRange.new(10, 15)
	self.maxProduction = 9
	self.fruit = ReplicatedStorage.Fruit_Spawn.Beanstalk
	
	self.maid = Maid.new()
	self.lastUpd = lastUpd or os.time()
	self.lastWaitTime = 0
	self.lastTick = 0
	self.lastWaitTimeFruit = 0
	self.lastTickFruit = 0
	self.progress = 0
	self.uuid = uuid or HttpService:GenerateGUID(true)
	self.model:SetAttribute("uuid", self.uuid)
	
	self.isGrowing = false
	self.growFruit = false
	
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
	
	--// Offline fruits
	self.toProduce = 0
	self.lastFruit = lastFruit or os.time()

	local AverageCycleTime = (self.fruitProduce.Min + self.fruitProduce.Max) / 2

	local elapsed = now - self.lastFruit
	local fruitsToProduce = math.floor(elapsed / AverageCycleTime)

	self.toProduce = math.min(fruitsToProduce, self.maxProduction)
	
	local _model = self.model:Clone()
	
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
			
			part.Position = (
				part.CFrame *
				CFrame.new(0, -(part.Size.Y / 2), 0)
			).Position
			
			part.Size = Vector3.new(part.Size.X, 0, part.Size.Z);

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

function Beanstalk:ShowGrowProcess()
	local age = math.min(math.ceil(self.age), self.maxage)

	for _, part in self.model:GetChildren() do
		if tonumber(part.Name) and part:IsA("BasePart") then
			if part.Name == tostring(age) then
				part.CanCollide = part:GetAttribute("CanCollide")
				part.Transparency = part:GetAttribute("OG_Transparency")
				part.Size = part.Size:Lerp(part:GetAttribute("Size"), math.min(self.progress, 1))
				part.CFrame = part.CFrame:Lerp(part:GetAttribute("CFrame"), math.min(self.progress, 1))

				if self.progress >= 1 then
					part:SetAttribute("DoneGrowing", true)
				end
			elseif tonumber(part.Name) <= age and part.Size ~= part:GetAttribute("Size") then
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

function Beanstalk:Produce(num, isOffline)
	self.lastFruit = os.time() 
	for i = 1, num do
		local random = self.model.Fruit_Spawn:GetChildren()[math.random(1, #self.model.Fruit_Spawn:GetChildren())]
		if #self.model.Fruits:GetChildren() < self.maxProduction then
			local newFruit = self.fruit:Clone()
			newFruit:SetAttribute("Owner", self.owner.Name)
			newFruit:SetPrimaryPartCFrame(random.CFrame)
			require(script.FruitHandler).new(nil, self.owner, newFruit, isOffline and 0 or nil, self.model.Item_Seed.Value, self.weight, self.uuid)
			newFruit.Parent = self.model.Fruits
		else
			break
		end
	end
end

function Beanstalk:StartFruitGrowing()
	if self.growFruit then
		return
	end
	self.growFruit = true
	
	if self.toProduce >= 1 then
		self:Produce(self.toProduce, true)
	end
	
	self.maid:GiveTask(RunService.Heartbeat:Connect(function(dt: value)
		if not (tick() - self.lastTickFruit >= self.lastWaitTimeFruit) then
			return
		end
		
		self:Produce(1)

		self.lastTickFruit = tick()
		self.lastWaitTimeFruit = RandomNumber(self.seed, self.fruitProduce.Min, self.fruitProduce.Max)
	end))
end

function Beanstalk:GrowStart()
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
		
		if (self.age / self.maxage) >= 0.5 and not self.growFruit then
			self:StartFruitGrowing()
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

function Beanstalk:GrowFinish()
	local prompt = self.model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		prompt.Enabled = true
		self.maid:GiveTask(prompt.Triggered:Connect(function(playerWhoTriggered: Player)
			if playerWhoTriggered ~= self.owner then
				return
			end
			
			local VariantVal = self.model:FindFirstChild("Variant")
			local Variant = VariantVal and VariantVal.Value or "Normal"
			
			local tool = TurnToTool(self.model, Variant, self.weight, nil, uuid)
			if tool then
				prompt.Enabled = false
				tool.Parent = playerWhoTriggered.Backpack
				self.model:Destroy()
			end
		end))
	end
end

function Beanstalk:CleanUp()
	self.maid:DoCleaning()
	Plants[self.owner].Plants[self.uuid] = nil
end

return Beanstalk