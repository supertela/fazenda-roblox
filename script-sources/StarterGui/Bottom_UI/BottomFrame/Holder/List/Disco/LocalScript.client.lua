workspace:GetAttributeChangedSignal("DiscoEvent"):Connect(function()
	if workspace:GetAttribute("DiscoEvent") then
		script.Parent.Visible = true
	else
		script.Parent.Visible = false
	end
end)