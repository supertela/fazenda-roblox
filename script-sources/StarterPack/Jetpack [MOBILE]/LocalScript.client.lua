local tool = script.Parent
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Only run this for mobile users
if not UserInputService.TouchEnabled then return end
local pcjet = script.Parent.Parent["Jetpack [PC]"]
pcjet:Destroy()

local function onEquipped()
	local gui = player:WaitForChild("PlayerGui"):FindFirstChild("MobileClickTool")
	if gui then
		gui.Enabled = true
	end
end

local function onUnequipped()
	local gui = player:WaitForChild("PlayerGui"):FindFirstChild("MobileClickTool")
	if gui then
		gui.Enabled = false
	end
end

tool.Equipped:Connect(onEquipped)
tool.Unequipped:Connect(onUnequipped)
