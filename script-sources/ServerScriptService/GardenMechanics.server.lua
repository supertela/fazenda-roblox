-- Ciclo de jardinagem do Place1: comprar, plantar, crescer, colher e vender.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local DataStoreService = game:GetService("DataStoreService")
local storeAvailable, GardenStore = pcall(function()
 return DataStoreService:GetDataStore("Place1Garden_v1")
end)
if not storeAvailable then GardenStore = nil end

local map = Workspace:WaitForChild("MapaGrowAGarden")
local plotsFolder = map:WaitForChild("Canteiros")
local stall = map:WaitForChild("Construcoes"):WaitForChild("Barraca")

local remote = ReplicatedStorage:FindFirstChild("GardenEvent")
if not remote then
 remote = Instance.new("RemoteEvent")
 remote.Name = "GardenEvent"
 remote.Parent = ReplicatedStorage
end

local CROPS = {
 Cenoura = {price = 5, value = 14, growTime = 24, stem = Color3.fromRGB(58, 145, 50), fruit = Color3.fromRGB(242, 126, 40)},
 Morango = {price = 15, value = 38, growTime = 36, stem = Color3.fromRGB(48, 138, 54), fruit = Color3.fromRGB(225, 44, 58)},
 Tomate = {price = 25, value = 58, growTime = 45, stem = Color3.fromRGB(53, 130, 50), fruit = Color3.fromRGB(215, 48, 42)},
}
local CROP_ORDER = {"Cenoura", "Morango", "Tomate"}
local plotsByPlayer = {}
local seedsByPlayer = {}
local harvestByPlayer = {}
local selectedByPlayer = {}
local plantsByCell = {}

local function getMoney(player)
 local stats = player:FindFirstChild("leaderstats")
 if not stats then
  stats = Instance.new("Folder")
  stats.Name = "leaderstats"
  stats.Parent = player
 end
 local money = stats:FindFirstChild("Moedas")
 if not money then
  money = Instance.new("IntValue")
  money.Name = "Moedas"
  money.Value = 100
  money.Parent = stats
 elseif money.Value == 0 and player:GetAttribute("GardenJoined") ~= true then
  money.Value = 100
 end
 local harvests = stats:FindFirstChild("Colheitas")
 if not harvests then
  harvests = Instance.new("IntValue")
  harvests.Name = "Colheitas"
  harvests.Value = 0
  harvests.Parent = stats
 end
 player:SetAttribute("GardenJoined", true)
 return money, harvests
end

local function sendState(player)
 local money = getMoney(player)
 local seedState = {}
 local fruitState = {}
 for _, cropName in ipairs(CROP_ORDER) do
  seedState[cropName] = (seedsByPlayer[player] and seedsByPlayer[player][cropName]) or 0
  fruitState[cropName] = (harvestByPlayer[player] and harvestByPlayer[player][cropName]) or 0
 end
 remote:FireClient(player, "State", {
  coins = money.Value,
  seeds = seedState,
  fruits = fruitState,
  selected = selectedByPlayer[player] or "Cenoura",
 })
end

local function notify(player, message)
 remote:FireClient(player, "Notice", message)
end

local function setSign(plot, text)
 local sign = plot:FindFirstChild("Placa")
 if not sign then return end
 for _, item in ipairs(sign:GetDescendants()) do
  if item:IsA("TextLabel") then
   item.Text = text
  end
 end
end

local function createCell(plot, soil, panelIndex, cellIndex, ownerId)
 local folder = plot:FindFirstChild("GardenCells")
 if not folder then
  folder = Instance.new("Folder")
  folder.Name = "GardenCells"
  folder.Parent = plot
 end
 local name = ("Cell_%d_%d"):format(panelIndex, cellIndex)
 local cell = folder:FindFirstChild(name)
 if not cell then
  cell = Instance.new("Part")
  cell.Name = name
  cell.Anchored = true
  cell.CanCollide = false
  cell.CanTouch = false
  cell.CanQuery = false
  cell.Transparency = 1
  cell.Size = Vector3.new(4.5, 0.2, 4.5)
  local length = soil.Size.Z / 4
  local localZ = -soil.Size.Z/2 + length * (cellIndex - 0.5)
  cell.CFrame = soil.CFrame * CFrame.new(0, soil.Size.Y/2 + 0.08, localZ)
  cell.Parent = folder
  local prompt = Instance.new("ProximityPrompt")
  prompt.Name = "PlantPrompt"
  prompt.ActionText = "Plantar"
  prompt.ObjectText = "Canteiro"
  prompt.HoldDuration = 0.15
  prompt.MaxActivationDistance = 10
  prompt.RequiresLineOfSight = false
  prompt.Parent = cell
 end
 cell:SetAttribute("OwnerUserId", ownerId)
 return cell
end

local function addStudSurface(part)
 local studTexture = "rbxassetid://1508034221"
 for _, face in ipairs({
  Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left,
  Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back,
 }) do
  local texture = Instance.new("Texture")
  texture.Name = "Studs_" .. face.Name
  texture.Texture = studTexture
  texture.Face = face
  texture.StudsPerTileU = 2
  texture.StudsPerTileV = 2
  texture.Transparency = 0.18
  texture.Parent = part
 end
end

local function createPlantModel(cropName, position)
 local data = CROPS[cropName]
 local model = Instance.new("Model")
 model.Name = cropName .. "_Plant"
 local root = Instance.new("Part")
 root.Name = "Raiz"
 root.Size = Vector3.new(0.2, 0.2, 0.2)
 root.Transparency = 1
 root.Anchored = true
 root.CanCollide = false
 root.CanTouch = false
 root.CanQuery = false
 root.Material = Enum.Material.Plastic
 root.Position = position
 root.Parent = model
 model.PrimaryPart = root

 local function part(name, size, offset, color, shape)
  local p = Instance.new("Part")
  p.Name = name
  p.Shape = shape or Enum.PartType.Ball
  p.Size = size
  p.CFrame = CFrame.new(position + offset)
  p.Color = color
  p.Material = Enum.Material.Plastic
  p.Anchored = true
  p.CanCollide = false
  p.CanTouch = false
  p.Parent = model
  addStudSurface(p)
  return p
 end

 part("Caule", Vector3.new(0.24, 1.25, 0.24), Vector3.new(0, 0.8, 0), data.stem, Enum.PartType.Cylinder)
 if cropName == "Cenoura" then
  part("RaizLaranja", Vector3.new(0.78, 0.9, 0.78), Vector3.new(0, 0.45, 0), data.fruit)
  part("Folha1", Vector3.new(0.45, 0.95, 0.45), Vector3.new(-0.28, 1.65, 0), data.stem)
  part("Folha2", Vector3.new(0.45, 1.05, 0.45), Vector3.new(0.28, 1.7, 0.05), data.stem)
  part("Folha3", Vector3.new(0.42, 0.85, 0.42), Vector3.new(0, 1.85, -0.26), Color3.fromRGB(83, 175, 57))
 elseif cropName == "Morango" then
  part("Morango1", Vector3.new(0.48, 0.52, 0.48), Vector3.new(-0.32, 0.75, 0), data.fruit)
  part("Morango2", Vector3.new(0.48, 0.52, 0.48), Vector3.new(0.32, 0.75, 0.03), data.fruit)
  part("Morango3", Vector3.new(0.45, 0.5, 0.45), Vector3.new(0, 0.55, 0.32), data.fruit)
  part("Folha1", Vector3.new(0.55, 0.35, 0.55), Vector3.new(0, 1.45, 0), data.stem)
  part("Folha2", Vector3.new(0.42, 0.6, 0.42), Vector3.new(-0.35, 1.55, 0), Color3.fromRGB(79, 163, 58))
  part("Folha3", Vector3.new(0.42, 0.6, 0.42), Vector3.new(0.35, 1.55, 0), Color3.fromRGB(79, 163, 58))
 else
  part("Tomate1", Vector3.new(0.7, 0.7, 0.7), Vector3.new(-0.35, 0.95, 0), data.fruit)
  part("Tomate2", Vector3.new(0.7, 0.7, 0.7), Vector3.new(0.35, 0.95, 0), data.fruit)
  part("Tomate3", Vector3.new(0.62, 0.62, 0.62), Vector3.new(0, 1.3, 0.28), Color3.fromRGB(235, 68, 48))
  part("Folha1", Vector3.new(0.6, 0.45, 0.6), Vector3.new(0, 1.75, 0), data.stem)
  part("Folha2", Vector3.new(0.45, 0.6, 0.45), Vector3.new(-0.38, 1.55, 0), Color3.fromRGB(83, 175, 57))
  part("Folha3", Vector3.new(0.45, 0.6, 0.45), Vector3.new(0.38, 1.55, 0), Color3.fromRGB(83, 175, 57))
 end
 return model
end

local function startGrowth(cell,prompt,record,initialProgress)
 local data=CROPS[record.crop]
 local progress=math.clamp(initialProgress or 0,0,1)
 if progress>=1 then
  record.matured=true
  prompt.ActionText="Colher"
  prompt.ObjectText=record.crop.." pronto"
  return
 end
 local remaining=data.growTime*(1-progress)
 local steps=math.max(1,math.ceil((1-progress)*10))
 task.spawn(function()
  for step=1,steps do
   task.wait(remaining/steps)
   if plantsByCell[cell]~=record or not record.model.Parent then return end
   progress=(initialProgress or 0)+(1-(initialProgress or 0))*(step/steps)
   record.model:ScaleTo(0.3+progress*0.7)
   record.model:SetAttribute("Growth",progress)
  end
  if plantsByCell[cell]==record then
   record.matured=true
   prompt.ActionText="Colher"
   prompt.ObjectText=record.crop.." pronto"
   notify(record.player,record.crop.." está pronto para colher!")
  end
 end)
end

local function connectCell(player, plot, cell)
 local prompt = cell:FindFirstChild("PlantPrompt")
 if not prompt or prompt:GetAttribute("Connected") then return end
 prompt:SetAttribute("Connected", true)
 prompt.Triggered:Connect(function(triggeringPlayer)
  if triggeringPlayer ~= player then return end
  if player:GetAttribute("GardenDataLoaded")~=true then
   notify(player,"Carregando seus dados da horta...")
   return
  end
  if cell:GetAttribute("OwnerUserId") ~= player.UserId then return end
  local record = plantsByCell[cell]
  if record then
   if not record.matured then
    local remaining = math.max(1, math.ceil(record.readyAt - os.clock()))
    notify(player, record.crop .. " ainda está crescendo (" .. remaining .. "s).")
    return
   end
   local fruits = harvestByPlayer[player]
   fruits[record.crop] = (fruits[record.crop] or 0) + 1
   local _, harvests = getMoney(player)
   harvests.Value += 1
   record.model:Destroy()
   plantsByCell[cell] = nil
   prompt.ActionText = "Plantar"
   prompt.ObjectText = "Canteiro"
   notify(player, record.crop .. " colhido! Leve à barraca para vender.")
   sendState(player)
   return
  end

  local cropName = selectedByPlayer[player] or "Cenoura"
  local inventory = seedsByPlayer[player]
  if not CROPS[cropName] or not inventory or (inventory[cropName] or 0) <= 0 then
   notify(player, "Você não tem essa semente. Compre mais na barraca.")
   return
  end

  inventory[cropName] -= 1
  local plantFolder = plot:FindFirstChild("GardenPlants")
  if not plantFolder then
   plantFolder = Instance.new("Folder")
   plantFolder.Name = "GardenPlants"
   plantFolder.Parent = plot
  end
  local ground = cell.Position + Vector3.new(0, 0.12, 0)
  local model = createPlantModel(cropName, ground)
  model:SetAttribute("OwnerUserId", player.UserId)
  model:SetAttribute("CropName", cropName)
  model:SetAttribute("Growth", 0)
  model.Parent = plantFolder
  model:PivotTo(CFrame.new(ground))
  model:ScaleTo(0.3)
  local data = CROPS[cropName]
  local record = {
   player = player,
   crop = cropName,
   model = model,
   matured = false,
   readyAt = os.clock() + data.growTime,
   plantedAt = os.time(),
  }
  plantsByCell[cell] = record
  prompt.ActionText = "Crescendo..."
  prompt.ObjectText = cropName
  notify(player, cropName .. " plantado. Vai crescer em " .. data.growTime .. "s.")
  sendState(player)

  startGrowth(cell,prompt,record,0)
 end)
end

local function claimPlot(player)
 for _, plot in ipairs(plotsFolder:GetChildren()) do
  if plot:IsA("Model") and not plot:GetAttribute("OwnerUserId") then
   plot:SetAttribute("OwnerUserId", player.UserId)
   plot:SetAttribute("OwnerName", player.Name)
   plotsByPlayer[player] = plot
   setSign(plot, player.DisplayName .. "'s Jardim")
   local cells = {}
   for panelIndex, soilName in ipairs({"Solo_Esquerdo", "Solo_Direito"}) do
    local soil = plot:FindFirstChild(soilName)
    if soil and soil:IsA("BasePart") then
     for cellIndex = 1, 4 do
      local cell = createCell(plot, soil, panelIndex, cellIndex, player.UserId)
      table.insert(cells, cell)
     end
    end
   end
   for _, cell in ipairs(cells) do connectCell(player, plot, cell) end
   local function moveCharacter(character)
    local spawnPart = plot:FindFirstChild("PontoSpawn")
    local root = character:WaitForChild("HumanoidRootPart", 10)
    if spawnPart and root then
     character:PivotTo(spawnPart.CFrame * CFrame.new(0, 4, 0))
    end
   end
   player.CharacterAdded:Connect(moveCharacter)
   if player.Character then task.spawn(moveCharacter, player.Character) end
   return plot
  end
 end
 return nil
end

local shopPart = stall:FindFirstChild("GardenShopAnchor")
if not shopPart then
 local box,size=stall:GetBoundingBox()
 shopPart=Instance.new("Part")
 shopPart.Name="GardenShopAnchor"
 shopPart.Size=Vector3.new(1,1,1)
 shopPart.CFrame=box*CFrame.new(0,size.Y/2+1,0)
 shopPart.Anchored=true
 shopPart.Transparency=1
 shopPart.CanCollide=false
 shopPart.CanTouch=false
 shopPart.CanQuery=false
 shopPart.Parent=stall
end
local shopPrompt=shopPart:FindFirstChild("GardenShopPrompt")
if not shopPrompt then
 shopPrompt=Instance.new("ProximityPrompt")
 shopPrompt.Name="GardenShopPrompt"
 shopPrompt.ActionText="Comprar sementes"
 shopPrompt.ObjectText="Barraca da Horta"
 shopPrompt.HoldDuration=0.2
 shopPrompt.MaxActivationDistance=12
 shopPrompt.RequiresLineOfSight=false
 shopPrompt.Parent=shopPart
end
shopPrompt.Triggered:Connect(function(player)
 remote:FireClient(player,"ShopOpen")
end)

local function restorePlants(player,plot,savedPlants)
 local cells=plot:FindFirstChild("GardenCells")
 local plantFolder=plot:FindFirstChild("GardenPlants")
 if not cells then return end
 if not plantFolder then
  plantFolder=Instance.new("Folder")
  plantFolder.Name="GardenPlants"
  plantFolder.Parent=plot
 end
 for _,saved in ipairs(savedPlants or {}) do
  local cell=cells:FindFirstChild(saved.cell)
  local cropName=saved.crop
  if cell and CROPS[cropName] and not plantsByCell[cell] then
   local plantedAt=tonumber(saved.plantedAt) or os.time()
   local elapsed=math.max(0,os.time()-plantedAt)
   local data=CROPS[cropName]
   local progress=math.clamp(elapsed/data.growTime,0,1)
   local ground=cell.Position+Vector3.new(0,0.12,0)
   local model=createPlantModel(cropName,ground)
   model:SetAttribute("OwnerUserId",player.UserId)
   model:SetAttribute("CropName",cropName)
   model:SetAttribute("Growth",progress)
   model.Parent=plantFolder
   model:PivotTo(CFrame.new(ground))
   model:ScaleTo(0.3+progress*0.7)
   local record={
    player=player,
    crop=cropName,
    model=model,
    matured=progress>=1,
    readyAt=os.clock()+math.max(0,data.growTime-elapsed),
    plantedAt=plantedAt,
   }
   plantsByCell[cell]=record
   local prompt=cell:FindFirstChild("PlantPrompt")
   if prompt then
    prompt.ActionText=record.matured and "Colher" or "Crescendo..."
    prompt.ObjectText=record.matured and (cropName.." pronto") or cropName
    if not record.matured then startGrowth(cell,prompt,record,progress) end
   end
  end
 end
end

local function onPlayerAdded(player)
 player:SetAttribute("GardenDataLoaded",false)
 local money=getMoney(player)
 if money.Value==0 then money.Value=100 end
 seedsByPlayer[player]={Cenoura=3,Morango=1,Tomate=0}
 harvestByPlayer[player]={Cenoura=0,Morango=0,Tomate=0}
 selectedByPlayer[player]="Cenoura"
 local plot=claimPlot(player)
 if not plot then
  notify(player,"Todos os canteiros estão ocupados. Tente novamente mais tarde.")
 end
 local ok,saved=false,nil
 if GardenStore then
  ok,saved=pcall(function()
   return GardenStore:GetAsync(tostring(player.UserId))
  end)
 end
 if ok and typeof(saved)=="table" then
  if typeof(saved.coins)=="number" then money.Value=math.max(0,math.floor(saved.coins)) end
  for _,cropName in ipairs(CROP_ORDER) do
   if typeof(saved.seeds)=="table" and typeof(saved.seeds[cropName])=="number" then
    seedsByPlayer[player][cropName]=math.max(0,math.floor(saved.seeds[cropName]))
   end
   if typeof(saved.fruits)=="table" and typeof(saved.fruits[cropName])=="number" then
    harvestByPlayer[player][cropName]=math.max(0,math.floor(saved.fruits[cropName]))
   end
  end
  if CROPS[saved.selected] then selectedByPlayer[player]=saved.selected end
  if plot then restorePlants(player,plot,saved.plants) end
 end
 player:SetAttribute("GardenDataLoaded",true)
 sendState(player)
end

local function savePlayer(player)
 local money=getMoney(player)
 local planted={}
 local plot=plotsByPlayer[player]
 if plot then
  for cell,record in pairs(plantsByCell) do
   if cell and cell.Parent and cell:IsDescendantOf(plot) then
    table.insert(planted,{cell=cell.Name,crop=record.crop,plantedAt=record.plantedAt or os.time()})
   end
  end
 end
 local data={
  coins=money.Value,
  seeds=seedsByPlayer[player] or {Cenoura=3,Morango=1,Tomate=0},
  fruits=harvestByPlayer[player] or {Cenoura=0,Morango=0,Tomate=0},
  selected=selectedByPlayer[player] or "Cenoura",
  plants=planted,
 }
 if GardenStore then
  pcall(function()
   GardenStore:SetAsync(tostring(player.UserId),data)
  end)
 end
end

local function makeVendorPrompt(group, promptName, actionText, objectText, onTriggered)
	local anchor = group:FindFirstChild("Place1_" .. promptName .. "Anchor")
	if not anchor then
		local box, size = group:GetBoundingBox()
		anchor = Instance.new("Part")
		anchor.Name = "Place1_" .. promptName .. "Anchor"
		anchor.Size = Vector3.new(1, 1, 1)
		anchor.CFrame = box * CFrame.new(0, size.Y / 2 + 1, 0)
		anchor.Anchored = true
		anchor.Transparency = 1
		anchor.CanCollide = false
		anchor.CanTouch = false
		anchor.CanQuery = false
		anchor.Parent = group
	end
	local prompt = anchor:FindFirstChild(promptName)
	if not prompt then
		prompt = Instance.new("ProximityPrompt")
		prompt.Name = promptName
		prompt.ActionText = actionText
		prompt.ObjectText = objectText
		prompt.HoldDuration = 0.15
		prompt.MaxActivationDistance = 12
		prompt.RequiresLineOfSight = false
		prompt.Parent = anchor
	end
	if not prompt:GetAttribute("Place1Connected") then
		prompt:SetAttribute("Place1Connected", true)
		prompt.Triggered:Connect(onTriggered)
	end
end

local seedStands = Workspace:FindFirstChild("NPCS") and Workspace.NPCS:FindFirstChild("Seed Stands")
local sellStands = Workspace:FindFirstChild("NPCS") and Workspace.NPCS:FindFirstChild("Sell Stands")
local gearStands = Workspace:FindFirstChild("NPCS") and Workspace.NPCS:FindFirstChild("Gear Stands")
if seedStands then
	makeVendorPrompt(seedStands, "Place1SeedPrompt", "Comprar sementes", "Loja de sementes", function(player)
		remote:FireClient(player, "ShopOpen")
	end)
end
if sellStands then
	makeVendorPrompt(sellStands, "Place1SellPrompt", "Vender colheitas", "Celeiro / Inventário", function(player)
		local fruits = harvestByPlayer[player]
		if not fruits then return end
		local total = 0
		for name, count in pairs(fruits) do
			total += count * (CROPS[name] and CROPS[name].value or 0)
			fruits[name] = 0
		end
		if total <= 0 then
			notify(player, "Você ainda não tem colheitas para vender.")
			return
		end
		local money = getMoney(player)
		money.Value += total
		notify(player, "Colheitas vendidas por " .. total .. " moedas.")
		sendState(player)
	end)
end
if gearStands then
	makeVendorPrompt(gearStands, "Place1GearPrompt", "Ver ferramentas", "Loja de ferramentas", function(player)
		remote:FireClient(player, "GearShopOpen")
	end)
end

remote.OnServerEvent:Connect(function(player, action, cropName)
 if action~="RequestState" and player:GetAttribute("GardenDataLoaded")~=true then
  notify(player,"Carregando seus dados da horta...")
  return
 end
 if action=="RequestState" then
  sendState(player)
 elseif action=="Select" then
  if CROPS[cropName] and seedsByPlayer[player] and (seedsByPlayer[player][cropName] or 0)>0 then
   selectedByPlayer[player]=cropName
   sendState(player)
  else
   notify(player,"Compre essa semente antes de selecioná-la.")
  end
 elseif action=="Buy" then
  local crop=CROPS[cropName]
  if not crop or not seedsByPlayer[player] then return end
  local money=getMoney(player)
  if money.Value<crop.price then
   notify(player,"Você precisa de mais moedas para comprar essa semente.")
   return
  end
  money.Value-=crop.price
  seedsByPlayer[player][cropName]=(seedsByPlayer[player][cropName] or 0)+1
  selectedByPlayer[player]=cropName
  notify(player,"Você comprou 1 semente de "..cropName..".")
  sendState(player)
 elseif action=="SellAll" then
  local fruits=harvestByPlayer[player]
  if not fruits then return end
  local total=0
  for name,count in pairs(fruits) do
   total+=count*(CROPS[name] and CROPS[name].value or 0)
   fruits[name]=0
  end
  if total<=0 then
   notify(player,"Você ainda não tem colheitas para vender.")
   return
  end
  local money=getMoney(player)
  money.Value+=total
  notify(player,"Colheitas vendidas por "..total.." moedas.")
  sendState(player)
 end
end)

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
 savePlayer(player)
 local plot=plotsByPlayer[player]
 if plot then
  local plants=plot:FindFirstChild("GardenPlants")
  if plants then plants:Destroy() end
  for cell,record in pairs(plantsByCell) do
   if cell and cell.Parent and cell:IsDescendantOf(plot) then plantsByCell[cell]=nil end
  end
  local cells=plot:FindFirstChild("GardenCells")
  if cells then cells:Destroy() end
  plot:SetAttribute("OwnerUserId",nil)
  plot:SetAttribute("OwnerName",nil)
  setSign(plot,plot.Name:gsub("Canteiro","Canteiro "))
 end
 plotsByPlayer[player]=nil
 seedsByPlayer[player]=nil
 harvestByPlayer[player]=nil
 selectedByPlayer[player]=nil
end)

game:BindToClose(function()
 for _,player in ipairs(Players:GetPlayers()) do
  savePlayer(player)
 end
end)

for _,player in ipairs(Players:GetPlayers()) do
 task.spawn(onPlayerAdded,player)
end
