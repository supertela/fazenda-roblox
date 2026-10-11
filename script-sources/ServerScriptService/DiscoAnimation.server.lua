local danceAnimations = {
	"rbxassetid://182491037", -- Dance1
	"rbxassetid://182491248", -- Dance2
	"rbxassetid://182491368", -- Dance3
}

local function toggleDefaultAnimations(character, val)
	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Enabled = val
	end
end

local function stopAllAnimations(humanoid)
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end
end

local function applyDanceOnly(character, animationId)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		toggleDefaultAnimations(character, false)
		stopAllAnimations(humanoid)

		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end

		local anim = Instance.new("Animation")
		anim.AnimationId = animationId

		local track = animator:LoadAnimation(anim)
		track.Looped = true
		track:Play()
	end
end

-- Disco animation trigger
workspace:GetAttributeChangedSignal("DiscoEvent"):Connect(function()
	if workspace:GetAttribute("DiscoEvent") then
		local randomDanceId = danceAnimations[math.random(1, #danceAnimations)]
		for _, plr in ipairs(game.Players:GetPlayers()) do
			local char = plr.Character
			if char then
				applyDanceOnly(char, randomDanceId)
			end
		end
	else
		for _, plr in ipairs(game.Players:GetPlayers()) do
			local char = plr.Character
			if char then
				toggleDefaultAnimations(char, true)
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					stopAllAnimations(hum)
				end
			end
		end
	end
end)

-- Stop all events when Cmdr triggers StopAllEvents
workspace:GetAttributeChangedSignal("stopallevents"):Connect(function()
	if workspace:GetAttribute("stopallevents") == true then
		-- Reset all characters
		for _, plr in ipairs(game.Players:GetPlayers()) do
			local char = plr.Character
			if char then
				toggleDefaultAnimations(char, true)
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					stopAllAnimations(hum)
				end
			end
		end
		-- Also clear the DiscoEvent if it’s still active
		workspace:SetAttribute("DiscoEvent", false)
	end
end)
