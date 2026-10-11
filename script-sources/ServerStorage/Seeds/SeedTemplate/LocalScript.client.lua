local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game.ReplicatedStorage
local Players = game.Players
local Workspace = game.Workspace

local plantRemoteEvent = ReplicatedStorage.GameEvents.Plant_RE
local tool = script.Parent
local localPlayer = Players.LocalPlayer
local notificationModule = require(ReplicatedStorage.Modules.Notification)

local isEquipped = false
local canPlant = true

local function isPointInPart(point, part)
	local p = part.CFrame:PointToObjectSpace(point)
	local s = part.Size / 2
	return p.X >= -s.X and p.X <= s.X
		and p.Y >= -1 and p.Y <= 1
		and p.Z >= -s.Z and p.Z <= s.Z
end

local function getPlotAndPlantingZone(hitPart, hitPosition)
	local plot = hitPart and hitPart:FindFirstAncestorOfClass("Model")
	local important = plot and plot:FindFirstChild("Important")
	local data = important and important:FindFirstChild("Data")
	local owner = data and data:FindFirstChild("Owner")
	local locations = plot and plot:FindFirstChild("Plant_Locations", true)
	if not owner or not locations then return plot, owner, nil end

	if hitPart.Name:find("Can_Plant") then
		return plot, owner, hitPart
	end

	if hitPart.Name == "AreaPlantio" then
		for _, zone in ipairs(locations:GetChildren()) do
			if zone.Name:find("Can_Plant") and isPointInPart(hitPosition, zone) then
				return plot, owner, zone
			end
		end
	end
	return plot, owner, nil
end

local function tryPlant(hitPart, hitPosition)
	if not hitPart or not isEquipped or tool:GetAttribute("Quantity") < 1 or not canPlant then
		return
	end

	local _, owner, zone = getPlotAndPlantingZone(hitPart, hitPosition)
	if not owner or not zone then return end
	if owner.Value ~= localPlayer.Name then
		notificationModule:CreateNotification("This isn't your plot!")
		return
	end

	canPlant = false
	for _, clickPoint in ipairs(Workspace.Click_Points:GetChildren()) do
		clickPoint:Destroy()
	end
	plantRemoteEvent:FireServer(hitPosition, tool:GetAttribute("Seed"), zone.Name)
	task.wait()
	canPlant = true
end

tool.Equipped:Connect(function()
	isEquipped = true
end)

tool.Unequipped:Connect(function()
	isEquipped = false
end)

if UserInputService.TouchEnabled then
	local currentCamera = Workspace.CurrentCamera
	local function onTouchTap(touchPosition, gameProcessedEvent)
		if gameProcessedEvent then
			return
		end

		local cameraRay = currentCamera:ViewportPointToRay(touchPosition.X, touchPosition.Y)
		local worldRay = Ray.new(cameraRay.Origin, cameraRay.Direction * 500)
		local hitPart, hitPosition = Workspace:FindPartOnRay(worldRay)

		tryPlant(hitPart, hitPosition)
	end

	UserInputService.TouchTapInWorld:Connect(onTouchTap)
else
	local mouse = localPlayer:GetMouse()
	mouse.Button1Down:Connect(function()
		local targetPart = mouse.Target
		tryPlant(targetPart, mouse.Hit.Position)
	end)
end