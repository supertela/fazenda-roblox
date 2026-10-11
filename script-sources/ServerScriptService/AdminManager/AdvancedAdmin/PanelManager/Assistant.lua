local module = {}
function module:CreateAlert(UI,Alert)
	local Template=script.Parent["AlertTemplate"]:Clone()
	Template.ContentBar.TextLabel.Text=Alert
	Template.LayoutOrder=#UI.Alerts:GetChildren()
	Template.Parent=UI.Alerts
	local Info=TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0)
	game.TweenService:Create(Template,Info,{BackgroundTransparency=0.1}):Play()
	game.TweenService:Create(Template.ContentBar.Icon,Info,{ImageTransparency=0}):Play()
	game.TweenService:Create(Template.ContentBar.TextLabel,Info,{TextTransparency=0}):Play()
	delay(10,function()
		local Tween=game.TweenService:Create(Template,Info,{BackgroundTransparency=1})
		Tween.Completed:Connect(function()
			Template:Destroy()
		end)
		game.TweenService:Create(Template.ContentBar.Icon,Info,{ImageTransparency=1}):Play()
		game.TweenService:Create(Template.ContentBar.TextLabel,Info,{TextTransparency=1}):Play()
		Tween:Play()
	end)
end
function module:ReturnKeyNames(cmds)
	local keynames={}
	for a, b in pairs(cmds) do 
		table.insert(keynames,a)
	end
	return keynames
end
return module
