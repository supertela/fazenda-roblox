local PlayersService=game:GetService('Players')
local Player=PlayersService.LocalPlayer
--[[]]--
local ReplicatedStorage=game:GetService('ReplicatedStorage')
local PanelUI=script.Parent
--[[]]--
local ButtonDebounce=false
local CurrentSelection=""
--[[]]--
local Assistant=require(script:WaitForChild("Assistant"))
local Keynames,Arguments,Layout
local Commands,Rank,Colours
ReplicatedStorage.AdminRemotes.AdminAccess.OnClientEvent:Connect(function(cmds,rank,colours,arguments,layout)
	Commands=cmds Rank=rank Colours=colours Arguments=arguments Layout=layout
	Keynames=Assistant:ReturnKeyNames(cmds)
	delay(5,function()
		Assistant:CreateAlert(PanelUI,"Press F4 or Type " .. [["/"]] .. " Panel in Chat to Open the Admin Panel")
	end)
end)
--[[]]--
local InfoArray={
	TweenInfo.new(.7,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0);
	TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0);
	TweenInfo.new(1.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0);
	TweenInfo.new(.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0);
}
repeat wait() until Commands~=nil
--[[]]--
local PanelStatus="Closed"
local UserInputService=game:GetService('UserInputService')
local function RefreshPanelAppearance()
	PanelUI.Frame.Home.PlayerInfo.Frame.PlayerName.Text=Player.DisplayName
end
local function TweenArrays(Labels,Images,Frames,Info)
	for a, b in pairs(Labels) do 
		b[1].TextTransparency=b[3] or 1
		game.TweenService:Create(b[1],Info,{TextTransparency=b[2]}):Play()
	end
	for a, b in pairs(Frames) do 
		b[1].BackgroundTransparency=b[3] or 1
		game.TweenService:Create(b[1],Info,{BackgroundTransparency=b[2]}):Play()
	end
	for a, b in pairs(Images) do 
		b[1].ImageTransparency=b[3] or 1
		game.TweenService:Create(b[1],Info,{ImageTransparency=b[2]}):Play()
	end
end
local function TweenOutFolder(Folder,closing)
	local Labels={};
	local Frames={};
	local Images={};
	local Functions={
		['Bans']=function()
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA("TextButton") then
					table.insert(Frames,{b.Unban,1,0})
					table.insert(Frames,{b.Unban.Frame,1,0.1})
					table.insert(Labels,{b.Unban.Instruction,1,0})
					table.insert(Labels,{b.Unban.Frame.Instruction,1,0})
					table.insert(Images,{b.Unban.Frame.ImageLabel,1,0})
					table.insert(Images,{b.PlayerInfo.ImageLabel,1,0})
					table.insert(Labels,{b.PlayerInfo.TextLabel,1,0})
				end
			end
			delay(0.3,function()
				for a, b in pairs(Folder:GetChildren()) do 
					b.Visible=false
				end
			end)
		end,
		['Home']=function()
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA('TextButton') then
					table.insert(Labels,{b.TextLabel,1,0})
					table.insert(Images,{b.ImageLabel,1,0})
				end
			end
			for a, b in pairs(Folder.PlayerInfo:GetChildren()) do 
				if b:IsA('ImageLabel') then
					table.insert(Images,{b,1,0})
				elseif b:IsA('Frame') then
					table.insert(Labels,{b.Welcome,1,0})
				end
			end
			if closing then
				table.insert(Images,{Folder.Parent.ImageLabel,1,0})
				table.insert(Images,{Folder.Parent.Topbar.Close,1,0})
				table.insert(Images,{Folder.Parent.Topbar.ImageLabel,1,0})
				table.insert(Labels,{Folder.Parent.Topbar.TextLabel,1,0})
			end
			local Info=TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)
			local PlayerName=Folder.PlayerInfo.Frame.PlayerName
			game.TweenService:Create(Folder.PlayerInfo.Frame.Welcome,Info,{TextTransparency=1}):Play()
			local Tween=game.TweenService:Create(PlayerName,Info,{TextTransparency=1})
			Tween:Play()
			Tween.Completed:Connect(function()
				for a, b in pairs(Folder:GetChildren()) do 
					b.Visible=false
				end
			end)
		end,
		['Commands']=function()
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA('TextButton') then
					table.insert(Frames,{b.Execute,1,0})
					table.insert(Frames,{b.Execute.Frame,1,0.1})
					table.insert(Labels,{b.Execute.Frame.Instruction,1,0})
					table.insert(Images,{b.Execute.Frame.ImageLabel,1,0})
					table.insert(Labels,{b.Execute.Instruction,1,0})
					table.insert(Labels,{b.CmdInfo.TextLabel,1,0})
					table.insert(Images,{b.CmdInfo.ImageLabel,1,0})
					for c, d in pairs(b.Interact:GetChildren()) do
						if d:IsA("Frame") and d.Name~="Frame" then
							table.insert(Frames,{d,1,0})
							table.insert(Labels,{d.Instruction,1,0})
						end
					end
				end
			end
			delay(0.3,function()
				for a, b in pairs(Folder:GetChildren()) do 
					b.Visible=false
				end
			end)
		end,
	}
	Functions[CurrentSelection]()
	TweenArrays(Labels,Images,Frames,InfoArray[4])
end
local function TweenInFolder(Folder)
	CurrentSelection=Folder.Name
	for a, b in pairs(Folder:GetChildren()) do 
		b.Visible=true
	end
	local Labels={};
	local Frames={};
	local Images={};
	local Functions={
		['Bans']=function()
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA("TextButton") then
					table.insert(Frames,{b.Unban,0,1})
					table.insert(Frames,{b.Unban.Frame,0.1,1})
					table.insert(Labels,{b.Unban.Instruction,0,1})
					table.insert(Labels,{b.Unban.Frame.Instruction,0,1})
					table.insert(Images,{b.Unban.Frame.ImageLabel,0,1})
					table.insert(Images,{b.PlayerInfo.ImageLabel,0,1})
					table.insert(Labels,{b.PlayerInfo.TextLabel,0,1})
				end
			end
			table.insert(Images,{Folder.Parent.Topbar.Close,0})
			table.insert(Images,{Folder.Parent.Topbar.ImageLabel,0})
			table.insert(Labels,{Folder.Parent.Topbar.TextLabel,0})
			local Info=TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)
			spawn(function()
				Folder.Parent.Topbar.TextLabel.Text=""
				Folder.Parent.Topbar.TextLabel.TextTransparency=1
				local TargetText="Admin Panel"
				for i=1,#TargetText do 
					Folder.Parent.Topbar.TextLabel.Text=Folder.Parent.Topbar.TextLabel.Text..string.sub(TargetText,i,i)
					task.wait(0.015)
				end
				task.wait(0.5)
				if PanelStatus~="Closed" then
					game.TweenService:Create(Folder.Parent.Topbar.TextLabel,Info,{TextTransparency=0}):Play()
				end
			end)
		end,
		['Home']=function()
			local delayedimages={}
			local delyaedtexts={}
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA('TextButton') then
					b.TextLabel.TextTransparency=1
					b.ImageLabel.ImageTransparency=1
					table.insert(delyaedtexts,{b.TextLabel,0})
					table.insert(delayedimages,{b.ImageLabel,0})
				end
			end
			for a, b in pairs(Folder.PlayerInfo:GetChildren()) do 
				if b:IsA('ImageLabel') then
					table.insert(Images,{b,0})
				elseif b:IsA('Frame') then
					table.insert(Labels,{b.Welcome,0})
				end
			end
			delay(0.75,function()
				for a, b in pairs(delayedimages) do
					game.TweenService:Create(b[1],InfoArray[3],{ImageTransparency=b[2]}):Play()
				end
				for a, b in pairs(delyaedtexts) do 
					game.TweenService:Create(b[1],InfoArray[3],{TextTransparency=b[2]}):Play()
				end
			end)
			table.insert(Images,{Folder.Parent.ImageLabel,0,0.5})
			table.insert(Images,{Folder.Parent.Topbar.Close,0})
			table.insert(Images,{Folder.Parent.Topbar.ImageLabel,0})
			table.insert(Labels,{Folder.Parent.Topbar.TextLabel,0})
			local Info=TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)
			local PlayerName=Folder.PlayerInfo.Frame.PlayerName
			local x1=game.TweenService:Create(PlayerName,Info,{TextTransparency=1})
			spawn(function()
				Folder.Parent.Topbar.TextLabel.Text=""
				Folder.Parent.Topbar.TextLabel.TextTransparency=1
				local TargetText="Admin Panel"
				for i=1,#TargetText do 
					Folder.Parent.Topbar.TextLabel.Text=Folder.Parent.Topbar.TextLabel.Text..string.sub(TargetText,i,i)
					task.wait(0.015)
				end
				task.wait(0.5)
				if PanelStatus~="Closed" then
					game.TweenService:Create(Folder.Parent.Topbar.TextLabel,Info,{TextTransparency=0}):Play()
				end
			end)
			x1.Completed:Connect(function()
				delay(0.5,function()
					if PanelStatus=="Closed" or CurrentSelection~="Home" then
						return
					end
					PlayerName.Text="["..Rank.."]"
					local x2=game.TweenService:Create(PlayerName,Info,{TextTransparency=0,TextColor3=Colours[Rank]})
					x2.Completed:Connect(function()
						delay(1.5,function()
							if PanelStatus=="Closed" or CurrentSelection~="Home" then
								return
							end
							local x3=game.TweenService:Create(PlayerName,Info,{TextTransparency=1})
							x3.Completed:Connect(function()
								PlayerName.TextColor3=Color3.fromRGB(255,255,255)
								PlayerName.Text=Player.DisplayName
								game.TweenService:Create(PlayerName,Info,{TextTransparency=0}):Play()
							end)	
							x3:Play()
						end)
					end)
					x2:Play()
				end)
			end)
			x1:Play()
		end,
		['Commands']=function()
			local delayedimages={}
			local delyaedtexts={}
			for a, b in pairs(Folder.Actions:GetChildren()) do 
				if b:IsA('TextButton') then
					table.insert(Frames,{b.Execute,0,1})
					table.insert(Frames,{b.Execute.Frame,0.1,1})
					table.insert(Labels,{b.Execute.Frame.Instruction,0,1})
					table.insert(Images,{b.Execute.Frame.ImageLabel,0,1})
					table.insert(Labels,{b.Execute.Instruction,0,1})
					table.insert(Labels,{b.CmdInfo.TextLabel,0,1})
					table.insert(Images,{b.CmdInfo.ImageLabel,0,1})
					for c, d in pairs(b.Interact:GetChildren()) do
						if d:IsA("Frame") and d.Name~="Frame" then
							d.TextBox.Text=""
							d.Instruction.Visible=true
							d.Instruction.TextTransparency=1
							table.insert(Frames,{d,0,1})
							table.insert(delyaedtexts,{d.Instruction,0})
						end
					end
				end
			end
			delay(0.75,function()
				for a, b in pairs(delayedimages) do
					game.TweenService:Create(b[1],InfoArray[3],{ImageTransparency=b[2]}):Play()
				end
				for a, b in pairs(delyaedtexts) do 
					game.TweenService:Create(b[1],InfoArray[3],{TextTransparency=b[2]}):Play()
				end
			end)
			table.insert(Images,{Folder.Parent.Topbar.Close,0})
			table.insert(Images,{Folder.Parent.Topbar.ImageLabel,0})
			table.insert(Labels,{Folder.Parent.Topbar.TextLabel,0})
			local Info=TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)
			spawn(function()
				Folder.Parent.Topbar.TextLabel.Text=""
				Folder.Parent.Topbar.TextLabel.TextTransparency=1
				local TargetText="Admin Panel"
				for i=1,#TargetText do 
					Folder.Parent.Topbar.TextLabel.Text=Folder.Parent.Topbar.TextLabel.Text..string.sub(TargetText,i,i)
					task.wait(0.015)
				end
				task.wait(0.5)
				if PanelStatus~="Closed" then
					game.TweenService:Create(Folder.Parent.Topbar.TextLabel,Info,{TextTransparency=0}):Play()
				end
			end)
		end,
	}
	Functions[Folder.Name]()
	TweenArrays(Labels,Images,Frames,InfoArray[1])
end
local function OpenPanel()
	if PanelStatus=="Open" then
		return 
	end
	PanelStatus="Open"
	RefreshPanelAppearance()
	TweenInFolder(PanelUI.Frame.Home)
	PanelUI.Frame.Position=UDim2.new(0.5,0,.45,0)
	game.TweenService:Create(PanelUI.Frame,InfoArray[2],{Position=UDim2.new(0.5,0,0.5,0)}):Play()
	script['Sounds']['Open']:Play()
	PanelUI.Frame.Visible=true
end
local function ClosePanel()
	local Folder=PanelUI.Frame[CurrentSelection]
	if CurrentSelection=="Home" then
		PanelStatus="Closed"
		TweenOutFolder(Folder,true)
	else TweenOutFolder(Folder)
		TweenInFolder(PanelUI.Frame["Home"])
	end
end
UserInputService.InputBegan:Connect(function(Input,GameProcessed)
	if Input.KeyCode==Enum.KeyCode.F4 then
		OpenPanel()
	end
end)
ReplicatedStorage.AdminRemotes.PanelToggle.OnClientEvent:Connect(function()
	OpenPanel()
end)
PanelUI.Frame.Topbar.Close.Activated:Connect(function()
	if ButtonDebounce==true then return end
	ButtonDebounce=true
	ClosePanel()
	task.wait(0.3) ButtonDebounce=false 
end)
PanelUI.Frame.Home.Actions.Commands.Activated:Connect(function()
	if ButtonDebounce==true then return end
	ButtonDebounce=true
	TweenOutFolder(PanelUI.Frame['Home'])
	TweenInFolder(PanelUI.Frame['Commands'])
	task.wait(0.3) ButtonDebounce=false
end)
PanelUI.Frame.Home.Actions.Bans.Activated:Connect(function()
	if ButtonDebounce==true then return end
	ButtonDebounce=true
	TweenOutFolder(PanelUI.Frame['Home'])
	TweenInFolder(PanelUI.Frame['Bans'])
	task.wait(0.3) ButtonDebounce=false
end)
local function EmptyInput(TextBox)
	local bool
	if TextBox.Text=="" or #TextBox.Text==0 then 
		bool=true
	else
		local safe=false
		for i=1, #TextBox.Text do 
			local char=string.sub(TextBox.Text,i,i)
			if char~=" " and char~="" then
				safe=true
				break
			end
		end
		if not safe then
			bool=true
		end
	end
	return bool
end
local function SetupArgument(Template)
	local TextBox,Instruction=Template.TextBox,Template.Instruction
	TextBox.Focused:Connect(function()
		Instruction.Visible=false
	end)
	TextBox.FocusLost:Connect(function()
		local Empty=EmptyInput(TextBox)
		if Empty then 
			Instruction.Visible=true
			return 
		end
	end)
end
for a, b in pairs(Keynames) do 
	local args=Arguments[b]
	local template=script['CommandStorage'].Template:Clone()
	template.Name=b
	template.CmdInfo.TextLabel.Text=b
	for i=1, #args do 
		local argtxt=args[i]
		local clone=script['CommandStorage'].ArgumentTemplate:Clone()
		clone.Name="Argument "..i
		clone.Instruction.Text=argtxt.."?"
		local x=1
		if i==2 then x=3
		elseif i==3 then x=5
		end
		clone.LayoutOrder=x
		SetupArgument(clone)
		clone.Parent=template.Interact
	end
	template.LayoutOrder=Layout[b]
	if Commands[b]==true then
		template.Execute.Activated:Connect(function()
			if ButtonDebounce==true then return end
			ButtonDebounce=true
			local ArgumentEmpty,Arguments=false,{};
			for a, x in pairs(template.Interact:GetChildren()) do 
				if x:IsA("Frame") and x.Name~="Frame" and x.Instruction.Text~="???" then
					local Empty=EmptyInput(x.TextBox)
					if Empty then
						ArgumentEmpty=true
						break
					else Arguments[string.sub(x.Instruction.Text,1,#x.Instruction.Text-1)]=x.TextBox.Text
					end
				end
			end
			if ArgumentEmpty==true then
				Assistant:CreateAlert(PanelUI,"Please Fill out all the Arguments to perform this Action")
			else
				if b=="Fly" then
					local Success,Errormsg=pcall(function()
						local speed=250
						pcall(function()
							speed=tonumber(Arguments.Speed)
						end)
						Player.Character.Fly.Speed.Value=speed
						Player.Character.Fly.Flying.Value=true
					end)
					if Success then
						Assistant:CreateAlert(PanelUI,"Command Executed Successfully")
					else Assistant:CreateAlert(PanelUI,"An Error Occured")
					end
				elseif b=="Unfly" then
					local Success,Errormsg=pcall(function()
						Player.Character.Fly.Speed.Value=0
						Player.Character.Fly.Flying.Value=false
					end)
					if Success then
						Assistant:CreateAlert(PanelUI,"Command Executed Successfully")
					else Assistant:CreateAlert(PanelUI,"An Error Occured")
					end
				end
				local Response=ReplicatedStorage.AdminRemotes.CommandUse:InvokeServer(b,Arguments)
				if Response then
					if string.find(Response,"Successfully") then
						for x, y in pairs(template.Interact:GetChildren()) do
							if y:IsA("Frame") and y.Name~="Frame" then
								local box=y.TextBox
								box.Text=""
								y.Instruction.Visible=true
							end
						end
					end
					Assistant:CreateAlert(PanelUI,Response)
				end	
			end
			task.wait(0.3) ButtonDebounce=false
		end)
	else
		template.Execute.Frame.Visible=true
	end
	template.Parent=PanelUI.Frame.Commands.Actions
end
local function OnCharacterAdd(Character)
	local Fly=script:FindFirstChild("Fly"):Clone()
	Fly.Parent=Character
	Fly.Enabled=true
end
if Player.Character then OnCharacterAdd(Player.Character) end
Player.CharacterAdded:Connect(function(Character)
	OnCharacterAdd(Character)
end)
local LabelsQueue={}
local AlreadyScaled={}
local function UpdateTextSize()
	for i, v in pairs(LabelsQueue) do 
		local TextLabel=v[1]
		local Pixels=v[2]
		local ScreenGui=TextLabel:FindFirstAncestorWhichIsA("ScreenGui") or nil
		if TextLabel and ScreenGui then
			local AbsoluteO=ScreenGui['AbsoluteGUISizeX'].Value
			local CurrentO=ScreenGui.AbsoluteSize.X
			TextLabel.TextSize=Pixels*(CurrentO/AbsoluteO)
		else
			table.remove(LabelsQueue,i) 
		end
	end
end
local function OnDescendantAdd(TextLabel)
	if not TextLabel:IsA('TextLabel') then
		if not TextLabel:IsA('TextBox') then return end
	end
	if TextLabel.TextScaled==true then return end
	local ScreenGui=TextLabel:FindFirstAncestorWhichIsA("ScreenGui")
	if ScreenGui:FindFirstChild('AbsoluteGUISizeX') then
		repeat wait() until ScreenGui==nil or not (ScreenGui:FindFirstChild('AbsoluteGUISizeX')) or ScreenGui['AbsoluteGUISizeX'].Value~=0
		local Pixels=TextLabel.TextSize
		if TextLabel:FindFirstChild('Scaled') then
		else
			local O=Instance.new('ObjectValue',TextLabel)
			O.Name="Scaled"
			table.insert(LabelsQueue,
				{
					TextLabel,
					Pixels,
				}
			)
		end
	end
end
for a, b in pairs(PanelUI:GetDescendants()) do 
	OnDescendantAdd(b)
end
game:GetService('RunService').RenderStepped:Connect(function()
	UpdateTextSize()
end)
ReplicatedStorage.AdminRemotes.Utility.BannedUsers.OnClientEvent:Connect(function(Array,Name)
	if not Name then
		for a, b in pairs(PanelUI.Frame.Bans.Actions:GetChildren()) do 
			if b:IsA("TextButton") then 
				b:Destroy()
			end
		end
		for a, b in pairs(Array) do 
			local Template=script["BannedTemplate"]:Clone()
			Template.Name=b
			Template.PlayerInfo.TextLabel.Text=b
			if Commands["Ban"]==true then
				Template.Unban.Activated:Connect(function()
					if ButtonDebounce==true then return end
					ButtonDebounce=true
					local Response=ReplicatedStorage.AdminRemotes.CommandUse:InvokeServer("Unban",{['Player']=b})
					if Response then
						if string.find(Response,"Successfully") then
							Assistant:CreateAlert(PanelUI,"Command Executed Successfully")
							Template:Destroy()
						else
							Assistant:CreateAlert(PanelUI,"An Error Occured")
						end
					end
					task.wait(0.3) ButtonDebounce=false
				end)
			else Template.Unban.Frame.Visible=true
			end
			Template.Parent=PanelUI.Frame.Bans.Actions
		end
	else
		if PanelUI.Frame.Bans.Actions:FindFirstChild(Name) then
			PanelUI.Frame.Bans.Actions[Name]:Destroy()
		end
	end
end)