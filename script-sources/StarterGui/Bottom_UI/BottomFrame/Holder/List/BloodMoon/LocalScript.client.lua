workspace:GetAttributeChangedSignal("BloodMoonEvent"):Connect(function()
	if workspace:GetAttribute("BloodMoonEvent") then
		script.Parent.Visible = true
	else
		script.Parent.Visible = false
	end
end)