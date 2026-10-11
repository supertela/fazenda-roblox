local Module = {}

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local defaultSky = script.Sky
local colorCorrection = Lighting.ColorCorrection:Clone()
colorCorrection.Name = "SunGod"
colorCorrection.Parent = Lighting

local CameraShaker = require(ReplicatedStorage.Code.CameraShaker)
local shaker = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(offset)
	Workspace.CurrentCamera.CFrame *= offset
end)
shaker:Start()

local active = false

local function triggerSunGod()
	active = true
	local sunGod = Workspace.Visuals:WaitForChild("sunGod")
	local originalPivot = sunGod:GetPivot()
	local raisedPivot = originalPivot * CFrame.new(0, 90, 0)

	-- Lighting changes
	TweenService:Create(Lighting, TweenInfo.new(3), {
		GeographicLatitude = 23,
		ClockTime = 17
	}):Play()

	local elapsed = 0
	while elapsed < 3 do
		elapsed += RunService.Heartbeat:Wait()
		local alpha = TweenService:GetValue(elapsed / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		sunGod:PivotTo(originalPivot:Lerp(raisedPivot, alpha))
	end

	shaker:Shake(CameraShaker.Presets.Explosion)

	TweenService:Create(colorCorrection, TweenInfo.new(0.3), {
		TintColor = Color3.fromRGB(255, 227, 89),
		Brightness = 0.5
	}):Play()

	TweenService:Create(Workspace.CurrentCamera, TweenInfo.new(0.5), {
		FieldOfView = 90
	}):Play()
	task.wait(0.3)
	TweenService:Create(Workspace.CurrentCamera, TweenInfo.new(3), {
		FieldOfView = 70
	}):Play()

	defaultSky.Parent = Lighting

	TweenService:Create(Lighting, TweenInfo.new(3), {
		Ambient = Color3.fromRGB(255, 215, 94),
		ExposureCompensation = 0.425,
		Brightness = 0.7
	}):Play()

	TweenService:Create(Lighting.SunRays, TweenInfo.new(1), {
		Intensity = 0.37,
		Spread = 0.033
	}):Play()

	TweenService:Create(colorCorrection, TweenInfo.new(3), {
		Brightness = 0.1,
		TintColor = Color3.fromRGB(245, 229, 149)
	}):Play()

	repeat task.wait() until not active

	defaultSky.Parent = script

	-- Restore original position
	elapsed = 0
	while elapsed < 3 do
		elapsed += RunService.Heartbeat:Wait()
		local alpha = TweenService:GetValue(elapsed / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		sunGod:PivotTo(raisedPivot:Lerp(originalPivot, alpha))
	end

	TweenService:Create(Lighting.SunRays, TweenInfo.new(1), {
		Intensity = 0,
		Spread = 0
	}):Play()

	sunGod:Destroy()

	TweenService:Create(colorCorrection, TweenInfo.new(3), {
		Brightness = 0,
		TintColor = Color3.fromRGB(255, 255, 255)
	}):Play()

	TweenService:Create(Lighting, TweenInfo.new(3), {
		Ambient = Lighting:GetAttribute("DefaultAmbient"),
		ExposureCompensation = Lighting:GetAttribute("DefaultExposure"),
		Brightness = Lighting:GetAttribute("DefaultBrightness"),
		ClockTime = 14,
		GeographicLatitude = 29.475
	}):Play()
end

Workspace:GetAttributeChangedSignal("SunGod"):Connect(function()
	if Workspace:GetAttribute("SunGod") then
		triggerSunGod()
	else
		active = false
	end
end)

if Workspace:GetAttribute("SunGod") then
	task.defer(triggerSunGod)
end

return Module
