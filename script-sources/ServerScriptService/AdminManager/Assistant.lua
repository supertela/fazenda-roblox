local module = {}
local access={}
local run=require(script:WaitForChild("Run"))
local Colours
local function CheckAccess(Player)
	local Response
	for a, b in pairs(access) do 
		if b[1]==Player.Name then
			Response=b[2];
			break;
		end
	end
	return Response;	
end
function module:RemoveAccess(PlayerName)
	for a, b in pairs(access) do 
		if b[1]==PlayerName then
			table.remove(access,a);
			access[a]=nil;
			break;
		end
	end
end
local function GrantAccess(Player,args)
	table.insert(access,{
		Player.Name,args
	})
end
local function GetBannedArray(BanDataStore)
	local Array
	local Success,Failed=pcall(function()
		Array=BanDataStore:GetAsync("banned")
	end)
	if Success and Array then
		return Array
	end
end
function module:LoadAdmin(Player,Rank,Commands,Arguments,Layout,Services,BanDataStore)
	GrantAccess(Player,{Rank,Commands})
	local UI=script.Parent['AdvancedAdmin']:Clone()
	UI.Parent=Player:WaitForChild("PlayerGui")
	local BannedUsers=GetBannedArray(BanDataStore)
	Services.ReplicatedStorage.AdminRemotes.AdminAccess:FireClient(Player,Commands,Rank,Colours,Arguments,Layout)
	if not BannedUsers then BannedUsers={} end
	Services.ReplicatedStorage.AdminRemotes.Utility.BannedUsers:FireClient(Player,BannedUsers)
end
function module:CheckBan(Player,BanDataStore)
	local Array=GetBannedArray(BanDataStore)
	if Array then
		if table.find(Array,Player.Name) or table.find(Array,Player.DisplayName) then
			Player:Kick("You have been Banned")
		end
	end
end
function module:Initialize(ReplicatedStorage,PanelSettings,BanDataStore)
	Colours=PanelSettings.Colours
	ReplicatedStorage:WaitForChild("AdminRemotes"):WaitForChild("CommandUse")
	ReplicatedStorage.AdminRemotes.CommandUse.OnServerInvoke=function(Player,Command,args)
		local Response
		local Access=CheckAccess(Player)
		if not Access then
			if PanelSettings.AutoBanExploiters==true then
				run:Ban(
					{
						['Player']=Player.Name;
						['Reason']="Exploit Detected";
					}, nil, BanDataStore
				)
			end
		else
			local Rank,Commands=Access[1],Access[2]
			if Commands[Command] and Commands[Command]==true then
				Response=run[Command](args,Player,BanDataStore)
			else 
				if Command=="Unban" and Commands["Ban"]==true then
					Response=run[Command](args,Player,BanDataStore)
				else --[[ No Access to Command / Unknown Command]]
				end
			end
		end
		return Response
	end
end
return module
