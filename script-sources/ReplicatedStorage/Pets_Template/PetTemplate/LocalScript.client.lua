local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game.ReplicatedStorage
local Players = game.Players
local Workspace = game.Workspace

-- Change this to your pet spawn remote event
local petSpawnRemoteEvent = ReplicatedStorage.GameEvents.PetSpawn_RE 

local tool = script.Parent
local localPlayer = Players.LocalPlayer

local isEquipped = false
local canSpawn = true -- renamed from canPlant

tool.Equipped:Connect(function()
	isEquipped = true
end)

tool.Unequipped:Connect(function()
	isEquipped = false
end)

if UserInputService.TouchEnabled then
	local currentCamera = Workspace.CurrentCamera
	local notificationModule = require(ReplicatedStorage.Modules.Notification)

	local function onTouchTap(touchPosition, gameProcessedEvent)
		if gameProcessedEvent then
			return
		end

		local cameraRay = currentCamera:ViewportPointToRay(touchPosition.X, touchPosition.Y)
		local worldRay = Ray.new(cameraRay.Origin, cameraRay.Direction * 500)
		local hitPart, hitPosition = Workspace:FindPartOnRay(worldRay)

		-- Check if the target is valid for pet spawning
		if hitPart and hitPart.Name:find("Can_SummonPet") then 
			local areaModel = hitPart.Parent.Parent -- adjust based on your game hierarchy
			local areaOwner = areaModel.Data.Owner.Value

			if areaOwner == localPlayer.Name then
				if isEquipped and tool:GetAttribute("Quantity") >= 1 and canSpawn then
					canSpawn = false
					-- Clean up any old click points if you want (optional)
					for _, clickPoint in pairs(Workspace.Click_Points:GetChildren()) do
						clickPoint:Destroy()
					end
					-- Fire the pet spawn remote event
					petSpawnRemoteEvent:FireServer(hitPosition, tool:GetAttribute("PetName"), hitPart.Name)
					task.wait()
					canSpawn = true
				end
			elseif isEquipped then
				notificationModule:CreateNotification("This isn't your area to summon pets!")
			end
		end
	end

	UserInputService.TouchTapInWorld:Connect(onTouchTap)
else
	local mouse = localPlayer:GetMouse()
	local notificationModule = require(ReplicatedStorage.Modules.Notification)

	mouse.Button1Down:Connect(function()
		local targetPart = mouse.Target
		if targetPart and targetPart.Name:find("Can_SummonPet") and isEquipped and tool:GetAttribute("Quantity") >= 1 and canSpawn then
			canSpawn = false
			local areaModel = targetPart.Parent.Parent -- adjust based on your game hierarchy
			local areaOwner = areaModel.Data.Owner.Value

			if areaOwner == localPlayer.Name then
				for _, clickPoint in pairs(Workspace.Click_Points:GetChildren()) do
					clickPoint:Destroy()
				end
				petSpawnRemoteEvent:FireServer(mouse.Hit.Position, tool:GetAttribute("PetName"), targetPart.Name)
			else
				notificationModule:CreateNotification("This isn't your area to summon pets!")
			end

			task.wait()
			canSpawn = true
		end
	end)
end
