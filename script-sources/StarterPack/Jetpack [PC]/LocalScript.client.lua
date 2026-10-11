local tool = script.Parent
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Only run this for mobile users
if UserInputService.TouchEnabled then return end
local mobilejet = script.Parent.Parent["Jetpack [MOBILE]"]
mobilejet:Destroy()
