-- Integra o ciclo de sementes do Place1 usando os menus originais do Grow a Garden.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remote = ReplicatedStorage:WaitForChild("GardenEvent")

local crops = {
	{name = "Cenoura", price = 5, color = Color3.fromRGB(211, 133, 66)},
	{name = "Morango", price = 15, color = Color3.fromRGB(119, 83, 49)},
	{name = "Tomate", price = 25, color = Color3.fromRGB(154, 115, 61)},
}
local cards = {}
local currentState = {coins = 0, seeds = {}, fruits = {}, selected = "Cenoura"}

local seedShop = playerGui:WaitForChild("Seed_Shop", 20)
local hud = playerGui:WaitForChild("Hud_UI", 20)
local moneyGui = playerGui:WaitForChild("Sheckles_UI", 20)
if not seedShop then
	warn("Place1: Seed_Shop original do Grow não foi encontrado.")
	return
end

local root = seedShop:WaitForChild("Frame", 10)
local scrolling = root and root:WaitForChild("ScrollingFrame", 10)
local template = scrolling and scrolling:WaitForChild("ItemFrame", 10)
if not template then
	warn("Place1: o modelo de item do Seed_Shop não foi encontrado.")
	return
end

local function addStudPreview(parent, cropName, position, size)
	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "Place1StudPreview"
	viewport.Position = position
	viewport.Size = size
	viewport.BackgroundTransparency = 1
	viewport.BorderSizePixel = 0
	viewport.Active = false
	viewport.Parent = parent

	local world = Instance.new("WorldModel")
	world.Parent = viewport
	local camera = Instance.new("Camera")
	camera.FieldOfView = 32
	camera.CFrame = CFrame.lookAt(Vector3.new(1.7, 1.5, 2.6), Vector3.new(0, 0.2, 0))
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	local data
	for _, crop in ipairs(crops) do
		if crop.name == cropName then data = crop break end
	end
	local seed = Instance.new("Part")
	seed.Name = "Semente"
	seed.Size = Vector3.new(0.62, 0.42, 0.48)
	seed.Color = data and data.color or Color3.fromRGB(128, 97, 58)
	seed.Material = Enum.Material.Plastic
	seed.Anchored = true
	seed.CanCollide = false
	seed.CFrame = CFrame.new(0, 0.15, 0) * CFrame.Angles(math.rad(-18), math.rad(28), math.rad(12))
	seed.Parent = world

	local texture = Instance.new("Texture")
	texture.Name = "Studs"
	texture.Texture = "rbxassetid://1508034221"
	texture.Face = Enum.NormalId.Top
	texture.StudsPerTileU = 2
	texture.StudsPerTileV = 2
	texture.Transparency = 0.1
	texture.Parent = seed

	local sprout = Instance.new("Part")
	sprout.Name = "Broto"
	sprout.Size = Vector3.new(0.18, 0.42, 0.18)
	sprout.Color = Color3.fromRGB(75, 164, 63)
	sprout.Material = Enum.Material.Plastic
	sprout.Anchored = true
	sprout.CanCollide = false
	sprout.CFrame = CFrame.new(0.05, 0.48, 0)
	sprout.Parent = world
	return viewport
end

local function setText(parent, name, value)
	local label = parent and parent:FindFirstChild(name, true)
	if label and (label:IsA("TextLabel") or label:IsA("TextButton")) then
		label.Text = value
	end
end

template.Visible = false
scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
for index, crop in ipairs(crops) do
	local card = template:Clone()
	card.Name = "Place1_" .. crop.name
	card.LayoutOrder = index
	card.Visible = true
	card.Parent = scrolling

	local main = card:FindFirstChild("Main_Frame")
	if main then
		main.AnchorPoint = Vector2.new(0, 0)
		main.Position = UDim2.fromScale(0, 0)
		main.Size = UDim2.fromScale(1, 1)
		setText(main, "Seed_Text", crop.name .. " Seed")
		setText(main, "Seed_Text_Shadow", crop.name .. " Seed")
		setText(main, "Description_Text", "Plante no canteiro e colha quando crescer.")
		setText(main, "Rarity_Text", "STUDS")
		setText(main, "Cost_Text", tostring(crop.price) .. "¢")
		setText(main, "Stock_Text", "Na mochila: 0")

		local function placeLabel(name, pos, size)
			local label = main:FindFirstChild(name, true)
			if label and label:IsA("GuiObject") then
				label.AnchorPoint = Vector2.new(0, 0)
				label.Position = pos
				label.Size = size
				label.ZIndex = main.ZIndex + 2
			end
		end
		placeLabel("Seed_Text", UDim2.new(0.30, 0, 0.06, 0), UDim2.new(0.65, 0, 0.20, 0))
		placeLabel("Seed_Text_Shadow", UDim2.new(0.30, 0, 0.08, 0), UDim2.new(0.65, 0, 0.20, 0))
		placeLabel("Description_Text", UDim2.new(0.30, 0, 0.30, 0), UDim2.new(0.65, 0, 0.18, 0))
		placeLabel("Stock_Text", UDim2.new(0.30, 0, 0.52, 0), UDim2.new(0.36, 0, 0.16, 0))
		placeLabel("Cost_Text", UDim2.new(0.67, 0, 0.52, 0), UDim2.new(0.14, 0, 0.16, 0))
		placeLabel("Rarity_BG", UDim2.new(0.81, 0, 0.50, 0), UDim2.new(0.17, 0, 0.20, 0))
		placeLabel("Rarity_Text", UDim2.new(0.81, 0, 0.50, 0), UDim2.new(0.17, 0, 0.20, 0))

		local oldPreview = main:FindFirstChild("ViewportFrame")
		if oldPreview then oldPreview:Destroy() end
		local preview = addStudPreview(main, crop.name, UDim2.new(0.03, 0, 0.15, 0), UDim2.new(0.23, 0, 0.70, 0))
		preview.ZIndex = main.ZIndex + 1

		if main:IsA("GuiButton") then
			main.Activated:Connect(function()
				remote:FireServer("Select", crop.name)
			end)
		end
	end

	local buyPanel = card:FindFirstChild("Frame")
	local buy = buyPanel and buyPanel:FindFirstChild("Sheckles_Buy")
	if buyPanel and buy then
		buyPanel.AnchorPoint = Vector2.new(0, 0)
		buyPanel.Visible = true
		buyPanel.Position = UDim2.new(0.70, 0, 0.74, 0)
		buyPanel.Size = UDim2.new(0.27, 0, 0.22, 0)
		if buyPanel:IsA("ImageLabel") then buyPanel.ImageTransparency = 1 end
		buyPanel.BackgroundTransparency = 1
		buyPanel.ZIndex = 5
		buy.AnchorPoint = Vector2.new(0, 0)
		buy.Position = UDim2.fromScale(0, 0)
		buy.Size = UDim2.fromScale(1, 1)
		buy.ZIndex = 6
		local inStock = buy:FindFirstChild("In_Stock")
		local noStock = buy:FindFirstChild("No_Stock")
		if inStock then
			inStock.Visible = true
			inStock.ZIndex = 7
			local cost = inStock:FindFirstChild("Cost_Text")
			if cost and cost:IsA("TextLabel") then cost.Text = tostring(crop.price) .. "¢"; cost.ZIndex = 8 end
		end
		if noStock then noStock.Visible = false end
		for _, extra in ipairs({card:FindFirstChild("Frame") and card.Frame:FindFirstChild("Robux_Buy"), card:FindFirstChild("Frame") and card.Frame:FindFirstChild("Gift")}) do
			if extra then extra.Visible = false end
		end
		if buy:IsA("GuiButton") then
			buy.Activated:Connect(function()
				remote:FireServer("Buy", crop.name)
			end)
		end
	end
	cards[crop.name] = card
end

local header = root:FindFirstChild("Frame")
local closeButton = header and header:FindFirstChild("ExitButton")
if closeButton and closeButton:IsA("GuiButton") then
	closeButton.Activated:Connect(function() seedShop.Enabled = false end)
end

local function openSeedShop()
	seedShop.Enabled = true
end

local function update(state)
	currentState = state
	for _, crop in ipairs(crops) do
		local card = cards[crop.name]
		local count = (state.seeds and state.seeds[crop.name]) or 0
		if card then
			setText(card, "Stock_Text", "Na mochila: " .. tostring(count))
			setText(card, "Cost_Text", tostring(crop.price) .. "¢")
			local main = card:FindFirstChild("Main_Frame")
			if main then
				main:SetAttribute("Selected", state.selected == crop.name)
			end
		end
	end
	local moneyLabel = moneyGui and moneyGui:FindFirstChild("Money")
	if moneyLabel and moneyLabel:IsA("TextLabel") then
		moneyLabel.Text = tostring(state.coins or 0) .. "¢"
		local value = moneyLabel:FindFirstChild("val")
		if value and value:IsA("NumberValue") then value.Value = state.coins or 0 end
	end
end

remote.OnClientEvent:Connect(function(action, payload)
	if action == "State" and typeof(payload) == "table" then
		update(payload)
	elseif action == "ShopOpen" then
		openSeedShop()
	elseif action == "GearShopOpen" then
		local gearShop = playerGui:FindFirstChild("Gear_Shop")
		if gearShop then gearShop.Enabled = true end
	elseif action == "Notice" and header then
		local timer = header:FindFirstChild("Timer")
		if timer and timer:IsA("TextLabel") then timer.Text = tostring(payload) end
	end
end)

seedShop.Enabled = false