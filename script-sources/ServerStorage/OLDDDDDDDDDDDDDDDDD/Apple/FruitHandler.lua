local Fruit = {}
Fruit.__index = Fruit

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Plants = require(ServerStorage.Plants)

local VariantVisuals = require(Modules:WaitForChild("VariantVisuals"))
local Maid = require(Modules:WaitForChild("Maid"))

local ItemModule = require(ReplicatedStorage.Item_Module)
local PlayerLuckModule = require(Modules.PlayerLuck)
local CalWeight = require(ReplicatedStorage.Calculate_Weight)
local Item_Module = require(ReplicatedStorage.Item_Module)
local TurnToTool = require(ServerStorage.TurnToTool)

function Fruit.new(uuid, owner, model, lastUpd, seed, parentWeight, parentUUID, fruitSeed)
	if not Plants[owner] then
		return
	end

	local self = setmetatable({}, Fruit)
	self.owner = owner
	self.model = model
	self.grow = self.model.Grow

	self.seed = fruitSeed or seed + math.random(1, 1000000)
	self.weight = forceWeight or CalWeight.Calculate_Weight(self.seed, script.Parent.Name) + (parentWeight / 5)
	self.maxage = 5
	self.plantdown = 0.25

	self.scale = self.weight * 0.05 + (parentWeight / 5)
	self.model:ScaleTo(self.scale)

	self.gtt = NumberRange.new(0.8, 1.2)
	self.grm = 1

	self.maid = Maid.new()
	self.lastUpd = lastUpd or os.time()
	self.lastWaitTime = 0
	self.lastTick = 0
	self.progress = 0
	self.uuid = uuid or HttpService:GenerateGUID(true)
	self.parentUUID = parentUUID
	self.parentWeight = parentWeight

	self.isGrowing = false

	Plants[self.owner].Fruits[self.uuid] = self
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
	
	self.model.Variant.Value = ItemModule.Return_Random_Rarity(PlayerLuckModule.GetLuck(owner, model, "Plant"))

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

	for _, part: BasePart in model:GetChildren() do
		if part:IsA("BasePart") then
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
			
			local _, yRot, _ = part.CFrame:ToOrientation()
			part.Position = (
				part.CFrame
				*
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

function Fruit:ShowGrowProcess()
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

function Fruit:GrowStart()
	if self.isGrowing then
		return
	end
	self.isGrowing = true

	local taskId; taskId = self.maid:GiveTask(RunService.Heartbeat:Connect(function(dt: value)
		if not (tick() - self.lastTick >= self.lastWaitTime) then
			return
		end

		self.lastTick = tick()
		self.lastWaitTime = Random.new(self.seed):NextNumber(self.gtt.Min, self.gtt.Max) * self.grm

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
			if part:IsA("BasePart") and tonumber(part.Name) then
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

function Fruit:Collect(playerWhoTriggered, uuid)
	if playerWhoTriggered ~= self.owner then
		return
	end

	local VariantVal = self.model:FindFirstChild("Variant")
	local Variant = VariantVal and VariantVal.Value or "Normal"

	local tool = TurnToTool(self.model, Variant, self.weight, CFrame.Angles(0, 0, math.rad(180)), uuid)
	if tool then
		tool:SetAttribute("ParentWeight", self.parentWeight)
		tool:SetAttribute("ParentUUID", self.parentUUID)
		tool.Parent = playerWhoTriggered.Backpack
		self.model:Destroy()
	end
end

function Fruit:GrowFinish()
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

function Fruit:CleanUp()
	self.maid:DoCleaning()
	Plants[self.owner].Fruits[self.uuid] = nil
end

return Fruit