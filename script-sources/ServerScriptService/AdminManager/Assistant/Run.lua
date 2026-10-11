local module = {}
local UserService = game:GetService("UserService")
module['Ban']=function(args,admin,bandatastore)
	local PlayerName,Reason=args.Player,args.Reason;
	local AdminName="Server"
	if admin then
		AdminName=admin.Name
	end
	if PlayerName==AdminName then
		return "You Cannot Ban Yourself"
	end
	local BannedUsers
	local Success,Errormsg=pcall(function()
		BannedUsers=bandatastore:GetAsync("banned")
	end)
	local Message
	local function Ban()
		if not BannedUsers then BannedUsers={} end
		local BannedUser,Failed=pcall(function()
			table.insert(BannedUsers,PlayerName)
			bandatastore:SetAsync("banned",BannedUsers)
		end)
		if BannedUser then
			local ExistingPlayer
			for a, b in pairs(game.Players:GetPlayers()) do 
				if b.Name==PlayerName or b.DisplayName==PlayerName then
					b:Kick(Reason)
					break
				end
			end
			if not BannedUsers then BannedUsers={} end
			game.ReplicatedStorage.AdminRemotes.Utility.BannedUsers:FireAllClients(BannedUsers)
			Message="Command Executed Successfully"
		else 
			warn(Failed)
			Message="An Error Occured"
		end
	end
	if Success and BannedUsers then
		local Found=false
		local success, result = pcall(function()
			return UserService:GetUserInfosByUserIdsAsync({80000})
		end)
		if success then
			for _, userInfo in ipairs(result) do
				if table.find(BannedUsers,userInfo.DisplayName) then
					Found=true
					break
				end
			end
		else return "An Error Occured"
		end
		if table.find(BannedUsers,PlayerName) or Found==true then
			return "User Already Banned"
		else Ban()
		end
	else
		Ban()
	end
	return Message
end
module['Unban']=function(args,admin,bandatastore)
	local PlayerName=args.Player;
	local BannedUsers
	local Success,Errormsg=pcall(function()
		BannedUsers=bandatastore:GetAsync("banned")
	end)
	local function Update(Array)
		bandatastore:SetAsync("banned",Array)
	end
	if Success and BannedUsers then
		if table.find(BannedUsers,PlayerName) then
			local Removed=false
			for a, b in pairs(BannedUsers) do 
				if b==PlayerName then
					Removed=true
					table.remove(BannedUsers,a)
					break
				end
			end
			if Removed==true then
				Update(BannedUsers)
				if not BannedUsers then BannedUsers={} end
				game.ReplicatedStorage.AdminRemotes.Utility.BannedUsers:FireAllClients(BannedUsers,PlayerName)
				return "Command Executed Successfully"
			else
				return "An Error Occured"
			end
		else
			local Found
			local success, result = pcall(function()
				return UserService:GetUserInfosByUserIdsAsync({80000})
			end)
			if success then
				for _, userInfo in ipairs(result) do
					if table.find(BannedUsers,userInfo.DisplayName) then
						Found=userInfo.DisplayName
						break
					end
				end
			end
			if Found then
				local Removed=false
				for a, b in pairs(BannedUsers) do 
					if b==Found then
						Removed=true
						table.remove(BannedUsers,a)
						break
					end
				end
				if Removed==true then
					Update(BannedUsers)
					if not BannedUsers then BannedUsers={} end
					game.ReplicatedStorage.AdminRemotes.Utility.BannedUsers:FireAllClients(BannedUsers,PlayerName)
					return "Command Executed Successfully"
				else
					return "An Error Occured"
				end
			else
				return "An Error Occured"
			end
		end
	else
		return "An Error Occured"
	end
end
module['Shutdown Server']=function(args,admin)
	if script['Shutdown'].Value==true then return "An Error Occured" end
	local Success,Errormsg=pcall(function()
		script['Shutdown'].Value=true
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			b:Kick("Server Shutting Down");
		end
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Kick']=function(args,admin)
	local PlayerName,Reason=args.Player,args.Reason
	if PlayerName==admin.Name or PlayerName==admin.DisplayName then
		return "You Cannot Kick Yourself"
	end
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
				break
			end
		end
		Player:Kick(Reason)
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Explode']=function(args,admin)
	local PlayerName=args.Player
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
				break
			end
		end
		local Sound=script["Explosion"]:Clone()
		Sound.Parent=Player.Character.HumanoidRootPart
		Sound:Play()
		local Explosion=Instance.new("Explosion")
		Explosion.BlastRadius=1;
		Explosion.BlastPressure=2000;
		Explosion.ExplosionType=Enum.ExplosionType.NoCraters
		Explosion.DestroyJointRadiusPercent=1
		Explosion.Position=Player.Character.HumanoidRootPart.Position
		Explosion.Parent=Player.Character.HumanoidRootPart
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Freeze']=function(args,admin)
	local PlayerName=args.Player
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
				break
			end
		end
		Player.Character.HumanoidRootPart.Anchored=true
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['UnFreeze']=function(args,admin)
	local PlayerName=args.Player
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
				break
			end
		end
		Player.Character.HumanoidRootPart.Anchored=false
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Teleport']=function(args,admin)
	local PlayerName,ToName=args.Player,args.To
	local Success,Errormsg=pcall(function()
		local PlayerOne,PlayerTwo
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				PlayerOne=b
			end
			if b.Name==ToName or b.DisplayName==ToName then
				PlayerTwo=b
			end
		end
		PlayerOne.Character.HumanoidRootPart.CFrame=PlayerTwo.Character.HumanoidRootPart.CFrame
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Fly']=function(args,admin)
end
module['Unfly']=function(args,admin)
end
module['Kill']=function(args,admin)
	local PlayerName=args.Player
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		Player.Character.Humanoid.Health=0
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Health']=function(args,admin)
	local PlayerName,Value=args.Player,args.Value
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		Player.Character.Humanoid.MaxHealth=Value
		Player.Character.Humanoid.Health=Value
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Invisible']=function(args,admin)
	local PlayerName=args.Player
	local Success,Errormsg=pcall(function()
		local Player
		if not script.Parent['Accessories']:FindFirstChild(PlayerName) then
			local Folder=Instance.new('Folder')
			Folder.Name=PlayerName
			Folder.Parent=script.Parent['Accessories']
		end
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		for a, b in pairs(Player.Character:GetChildren()) do 
			if b:IsA("BasePart") and b.Name~="HumanoidRootPart" then
				b.Transparency=1
			end
			if b:IsA("Accessory") then
				b.Parent=script.Parent['Accessories'][PlayerName]
			end
			for c, d in pairs(b:GetChildren()) do 
				if d:IsA("Decal") then
					d.Transparency=1
				end
			end
		end
		Player.Character.Humanoid.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Announce']=function(args,admin)
	local Message=args.Message
	local Success,Errormsg=pcall(function()
		local Remote=game:GetService('ReplicatedStorage').AdminRemotes.Utility.Announcement
		Remote:FireAllClients(Message)
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Speed']=function(args,admin)
	local PlayerName,Value=args.Player,args.Value
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		Player.Character.Humanoid.WalkSpeed=tonumber(Value)
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Jump']=function(args,admin)
	local PlayerName,Value=args.Player,args.Value
	local Success,Errormsg=pcall(function()
		local Player
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		if Player.Character.Humanoid.UseJumpPower==true then
			Player.Character.Humanoid.JumpPower=tonumber(Value)
		else Player.Character.Humanoid.JumpHeight=tonumber(Value)
		end
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Give Tool']=function(args,admin)
	local PlayerName,ToolId=args.Player,args.ToolID
	local Success,Errormsg=pcall(function()
		local Player
		ToolId=tonumber(ToolId)
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		local x=game:GetService("InsertService"):LoadAsset(ToolId)
		x.Parent=script
		x:FindFirstChildWhichIsA("Tool").Parent=Player.Backpack
		x:Destroy()
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
module['Give Currency']=function(args,admin)
	local PlayerName,CurrencyName,Amount=args.Player,args.CurrencyName,args.Amount
	local Success,Errormsg=pcall(function()
		local Player
		Amount=tonumber(Amount)
		CurrencyName=string.lower(CurrencyName)
		for a, b in pairs(game:GetService("Players"):GetPlayers()) do 
			if b.Name==PlayerName or b.DisplayName==PlayerName then
				Player=b
			end
		end
		for a, b in pairs(Player:GetDescendants()) do 
			if string.lower(b.Name)==CurrencyName then
				b.Value+=Amount
			end
		end
	end)
	if Success then
		return "Command Executed Successfully"
	else return "An Error Occured"
	end
end
return module
