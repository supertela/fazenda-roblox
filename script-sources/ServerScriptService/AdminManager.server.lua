local ReplicatedStorage=game:GetService('ReplicatedStorage')
local PlayersService=game:GetService('Players')
--[[]]--
local DataStoreService=game:GetService('DataStoreService')
local BanDataStore=DataStoreService:GetDataStore(":BanData")
--[[]]--
local Assistant=require(script:WaitForChild('Assistant'))
local PanelSettings
local Meta={
	__call=function(t,args)
		local Rank
		if table.find(t.Access.Master,args.Name) then Rank="Master"
		elseif table.find(t.Access.Admin,args.Name) then Rank="Admin"
		elseif table.find(t.Access.Basic,args.Name) then Rank="Basic"
		end
		return Rank
	end,
}
local MetaArray={
	--[[ bans players who use exploits to get admin ]]--
	['ChatCommand']="/panel";
	['AutoBanExploiters']=true; 
	['CommandSettings']={
		["Master"]={
			['Ban']=true;
			['Kick']=true;
			['Fly']=true;
			['Teleport']=true;
			['Invisible']=true;
			['Kill']=true;
			['Explode']=true;
			['Health']=true;
			['Announce']=true;
			['Speed']=true;
			['Jump']=true;
			['Freeze']=true;
			['Shutdown Server']=true;
			['Give Tool']=true;
			['Give Currency']=true;
		}; 
		["Admin"]={
			['Ban']=false;
			['Kick']=true;
			['Fly']=true;
			['Teleport']=true;
			['Invisible']=true;
			['Kill']=true;
			['Explode']=true;
			['Health']=true;
			['Announce']=true;
			['Speed']=true;
			['Jump']=true;
			['Freeze']=true;
			['Shutdown Server']=true;
			['Give Tool']=false;
			['Give Currency']=false;
		};
		["Basic"]={
			['Ban']=false;
			['Kick']=false;
			['Fly']=false;
			['Teleport']=false;
			['Invisible']=true;
			['Kill']=true;
			['Explode']=true;
			['Health']=true;
			['Announce']=true;
			['Speed']=true;
			['Jump']=true;
			['Freeze']=true;
			['Shutdown Server']=false;
			['Give Tool']=false;
			['Give Currency']=false;	
		};
	};
	['Access']={
		["Master"]={"waaaaaa5678"};
		["Admin"]={"waaaaaa5678"};
		["Basic"]={"waaaaaa5678"};
	};
	['Colours']={
		["Master"]=Color3.fromRGB(31, 31, 31);
		["Admin"]=Color3.fromRGB(20, 181, 255);
		["Basic"]=Color3.fromRGB(150, 1, 4);
	};
	--[[ Do Not Change ]]--
	['Arguments']={
		['Ban']={"Player","Reason"};
		['Kick']={"Player","Reason"};
		['Teleport']={"Player","To"};
		['Fly']={"Speed"};
		['Unfly']={"??"};
		['Invisible']={"Player"};
		['Kill']={"Player"};
		['Explode']={"Player"};
		['Health']={"Player","Value"};
		['Announce']={"Message"};
		['Speed']={"Player","Value"};
		['Jump']={"Player","Value"};
		['Freeze']={"Player"};
		['UnFreeze']={"Player"};
		['Shutdown Server']={"??"};
		['Give Tool']={"Player","ToolID"};
		['Give Currency']={"Player","CurrencyName","Amount"};	
	};
	['Layout']={
		['Ban']=1;
		['Kick']=2;
		['Teleport']=3;
		['Fly']=4;
		['Unfly']=5;
		['Invisible']=6;
		['Kill']=7;
		['Explode']=8;
		['Health']=9;
		['Announce']=10;
		['Speed']=11;
		['Jump']=12;
		['Freeze']=13;
		['UnFreeze']=14;
		['Shutdown Server']=15;
		['Give Tool']=16;
		['Give Currency']=17;	
	}
}
for a, b in pairs(MetaArray.CommandSettings) do 
	local bool=b['Fly']
	b['Unfly']=bool
	local bool2=b['Freeze']
	b['UnFreeze']=bool2
end
PanelSettings=setmetatable(MetaArray,Meta)
Assistant:Initialize(ReplicatedStorage,PanelSettings,BanDataStore)
--[[]]--
PlayersService.PlayerAdded:Connect(function(Player)
	if script.Assistant.Run.Shutdown.Value==true then Player:Kick("Server Shutting Down") return end
	Assistant:CheckBan(Player,BanDataStore)
	local PlayerRank=PanelSettings(Player)
	if PlayerRank then
		local Commands=PanelSettings.CommandSettings[PlayerRank]
		Assistant:LoadAdmin(Player,PlayerRank,Commands,PanelSettings.Arguments,PanelSettings.Layout,{['ReplicatedStorage']=ReplicatedStorage,['PlayersService']=PlayersService},BanDataStore)
		Player.Chatted:Connect(function(ChatMessage)
			if #ChatMessage>1 then
				if string.lower(ChatMessage)==string.lower(PanelSettings.ChatCommand) then
					ReplicatedStorage.AdminRemotes.PanelToggle:FireClient(Player)
				end
			end
		end)	
	end
end)
PlayersService.PlayerRemoving:Connect(function(Player)
	Assistant:RemoveAccess(Player.Name)
end)