-- Interface de pesca (cliente)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")

local FishingEvent = ReplicatedStorage:WaitForChild("FishingEvent")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RARITY_COLORS = {
	["Comum"] = Color3.fromRGB(200, 200, 200),
	["Incomum"] = Color3.fromRGB(90, 220, 110),
	["Raro"] = Color3.fromRGB(80, 160, 255),
	["Épico"] = Color3.fromRGB(180, 100, 255),
	["Lendário"] = Color3.fromRGB(255, 200, 50),
}

local gui = Instance.new("ScreenGui")
gui.Name = "FishingGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function round(inst, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 12)
	c.Parent = inst
end

local status = Instance.new("TextLabel")
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.Position = UDim2.fromScale(0.5, 0.72)
status.Size = UDim2.fromOffset(360, 46)
status.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
status.BackgroundTransparency = 0.25
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.GothamBold
status.TextSize = 20
status.Visible = false
status.Parent = gui
round(status)

local reelBtn = Instance.new("TextButton")
reelBtn.AnchorPoint = Vector2.new(0.5, 0.5)
reelBtn.Position = UDim2.fromScale(0.5, 0.62)
reelBtn.Size = UDim2.fromOffset(260, 66)
reelBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 90)
reelBtn.TextColor3 = Color3.new(1, 1, 1)
reelBtn.Font = Enum.Font.GothamBlack
reelBtn.TextSize = 28
reelBtn.Text = "PUXAR! (F)"
reelBtn.Visible = false
reelBtn.Parent = gui
round(reelBtn, 16)

local cancelBtn = Instance.new("TextButton")
cancelBtn.AnchorPoint = Vector2.new(0.5, 0.5)
cancelBtn.Position = UDim2.fromScale(0.5, 0.79)
cancelBtn.Size = UDim2.fromOffset(140, 34)
cancelBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
cancelBtn.TextColor3 = Color3.new(1, 1, 1)
cancelBtn.Font = Enum.Font.GothamBold
cancelBtn.TextSize = 16
cancelBtn.Text = "Cancelar"
cancelBtn.Visible = false
cancelBtn.Parent = gui
round(cancelBtn, 10)

-- painel do peixe pescado
local panel = Instance.new("Frame")
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.Size = UDim2.fromOffset(300, 150)
panel.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
panel.BackgroundTransparency = 0.1
panel.Visible = false
panel.Parent = gui
round(panel, 16)
local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Parent = panel

local function label(text, y, size, font)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position = UDim2.new(0, 0, 0, y)
	l.Size = UDim2.new(1, 0, 0, size + 8)
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = font or Enum.Font.GothamBold
	l.TextSize = size
	l.Text = text
	l.Parent = panel
	return l
end
local titleL = label("Você pescou!", 10, 18)
local nameL = label("", 42, 26, Enum.Font.GothamBlack)
local rarityL = label("", 80, 18)
local infoL = label("", 108, 18)

local state = "idle"
local token = 0

local function say(text, color, seconds)
	token += 1
	local my = token
	status.Text = text
	status.TextColor3 = color or Color3.new(1, 1, 1)
	status.Visible = true
	if seconds then
		task.delay(seconds, function()
			if token == my and state == "idle" then status.Visible = false end
		end)
	end
end

local function unbindReelKey()
	ContextActionService:UnbindAction("FishingReel")
end

local function reel()
	if state ~= "bite" then return end
	state = "waiting"
	reelBtn.Visible = false
	unbindReelKey()
	FishingEvent:FireServer("Reel")
end

reelBtn.Activated:Connect(reel)

cancelBtn.Activated:Connect(function()
	if state ~= "casting" then return end
	state = "idle"
	cancelBtn.Visible = false
	FishingEvent:FireServer("Cancel")
	say("Pesca cancelada.", Color3.fromRGB(220, 220, 220), 2)
end)

local function showCatch(data)
	local color = RARITY_COLORS[data.rarity] or Color3.new(1, 1, 1)
	nameL.Text = data.name
	nameL.TextColor3 = color
	rarityL.Text = data.rarity
	rarityL.TextColor3 = color
	infoL.Text = string.format("%.2f kg  •  +%d moedas", data.kg, data.value)
	stroke.Color = color
	panel.Visible = true
	panel.Size = UDim2.fromOffset(240, 120)
	TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(300, 150) }):Play()
	local my = token
	task.delay(3.5, function()
		if token == my then panel.Visible = false end
	end)
end

FishingEvent.OnClientEvent:Connect(function(action, a, b)
	if action == "Cast" then
		state = "casting"
		panel.Visible = false
		reelBtn.Visible = false
		cancelBtn.Visible = true
		say("🎣 Aguardando o peixe...", Color3.new(1, 1, 1))

	elseif action == "Bite" then
		state = "bite"
		cancelBtn.Visible = false
		reelBtn.Visible = true
		say("Fisgou! Puxe agora!", Color3.fromRGB(255, 230, 90))
		ContextActionService:BindAction("FishingReel", function(_, inputState)
			if inputState == Enum.UserInputState.Begin then reel() end
			return Enum.ContextActionResult.Sink
		end, false, Enum.KeyCode.F)
		TweenService:Create(reelBtn, TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 6, true), { Rotation = 4 }):Play()

	elseif action == "Result" then
		state = "idle"
		reelBtn.Visible = false
		cancelBtn.Visible = false
		reelBtn.Rotation = 0
		unbindReelKey()
		if a == true then
			say("Boa pescaria!", Color3.fromRGB(120, 255, 140), 2)
			showCatch(b)
		else
			say(tostring(b or "A pesca falhou."), Color3.fromRGB(255, 120, 120), 2.5)
		end
	end
end)
