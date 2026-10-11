local tool = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FlyEvent = ReplicatedStorage:WaitForChild("FlyEvent")

local function startFly(character)
	character.Handle.WEEE.MaxForce = Vector3.new(0, math.huge, 0)
	character.tube.Attachment.Fire.Enabled = true
	character.tube2.Attachment.Fire.Enabled = true
	character.Handle.Swoosh:Play()
	character.Parent.Humanoid.WalkSpeed = 80
end

local function stopFly(character)
	character.Handle.WEEE.MaxForce = Vector3.new(0, 0, 0)
	character.tube.Attachment.Fire.Enabled = false
	character.tube2.Attachment.Fire.Enabled = false
	character.Handle.Swoosh:Stop()
	character.Parent.Humanoid.WalkSpeed = 16
end

FlyEvent.OnServerEvent:Connect(function(player, isFlying)
	local character = player.Character
	if character and character:FindFirstChild("Humanoid") then
		if isFlying then
			startFly(tool)
		else
			stopFly(tool)
		end
	end
end)
