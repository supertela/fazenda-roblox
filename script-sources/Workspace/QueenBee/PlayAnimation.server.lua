local hum = script.Parent:WaitForChild("Humanoid")

local idleAnim = Instance.new("Animation")
idleAnim.AnimationId = "rbxassetid://75034512546401"

local spinAnim = Instance.new("Animation")
spinAnim.AnimationId = "rbxassetid://102060143249380"

local idleTrack = hum:LoadAnimation(idleAnim)
local spinTrack = hum:LoadAnimation(spinAnim)

idleTrack.Looped = true
idleTrack:Play()

while true do
	wait(math.random(5, 15))

	idleTrack:Stop()

	spinTrack.Looped = false
	spinTrack:Play()

	spinTrack.Stopped:Wait()

	idleTrack:Play()
end