local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Lighting = game.Lighting

local TweenInfoFast = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local danceAnimations = {
	"rbxassetid://182435998", -- Dance1
	"rbxassetid://182491037", -- Dance2
	"rbxassetid://182491065", -- Dance3
	"rbxassetid://182436842", -- Dance4
	"rbxassetid://182491248", -- Dance5
	"rbxassetid://182491277", -- Dance6
	"rbxassetid://182436935", -- Dance7
	"rbxassetid://182491368", -- Dance8
	"rbxassetid://182491423", -- Dance9
}

local musicSoundId = "rbxassetid://142376088"

local discoMusic = workspace:FindFirstChild("DiscoMusic")
if not discoMusic then
	discoMusic = Instance.new("Sound")
	discoMusic.Name = "DiscoMusic"
	discoMusic.SoundId = musicSoundId
	discoMusic.Looped = true
	discoMusic.Volume = 0.5
	discoMusic.Parent = workspace
end

local function applyDanceAnimation(character, animationId)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local danceAnim = Instance.new("Animation")
		danceAnim.AnimationId = animationId
		humanoid:LoadAnimation(danceAnim):Play()
	end
end

local function startDiscoLighting()
	TweenService:Create(Lighting.ColorCorrection, TweenInfoFast, { Saturation = 0.3 }):Play()
end

local function stopDiscoLighting()
	TweenService:Create(Lighting.ColorCorrection, TweenInfoFast, { Saturation = 0 }):Play()
	task.delay(1.5, function()
		TweenService:Create(Lighting, TweenInfoFast, { ColorShift_Top = Color3.fromRGB(0, 0, 0) }):Play()
	end)
end

workspace:GetAttributeChangedSignal("DiscoEvent"):Connect(function()
	local isActive = workspace:GetAttribute("DiscoEvent")
	if isActive then
		local randomDanceId = danceAnimations[math.random(1, #danceAnimations)]
		discoMusic:Play()
		for _, player in pairs(game.Players:GetPlayers()) do
			applyDanceAnimation(player, randomDanceId)
		end
		startDiscoLighting()
	else
		discoMusic:Stop()
		stopDiscoLighting()
	end
end)