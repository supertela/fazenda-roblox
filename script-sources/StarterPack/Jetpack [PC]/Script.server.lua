local tool = script.Parent
script.Parent.Activated:Connect(function()
	script.Parent.Handle.WEEE.MaxForce = Vector3.new(0,math.huge,0)
	tool.tube.Attachment.Fire.Enabled = true
	tool.tube2.Attachment.Fire.Enabled = true
	tool.Handle.Swoosh:Play()
	tool.Parent.Humanoid.WalkSpeed = 80
end)

script.Parent.Deactivated:Connect(function()
	script.Parent.Handle.WEEE.MaxForce = Vector3.new(0,0,0)
	tool.tube.Attachment.Fire.Enabled = false
	tool.tube2.Attachment.Fire.Enabled = false
	tool.Handle.Swoosh:Stop()
	tool.Parent.Humanoid.WalkSpeed = 16
end)

