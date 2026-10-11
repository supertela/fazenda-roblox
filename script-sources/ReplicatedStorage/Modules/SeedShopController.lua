-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SeedShopController, time of decompilation: Thu Jun  5 11:10:25 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_Seed_Shop_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("Seed_Shop");
local v3 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v4 = require(l_ReplicatedStorage_0.Modules.DataService);
local v5 = require(l_ReplicatedStorage_0.Comma_Module);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.FastTween);
local v8 = require(l_ReplicatedStorage_0.Modules.MarketController);
local v9 = require(l_ReplicatedStorage_0.Modules.GiftController);
local v10 = require(l_ReplicatedStorage_0.Data.SeedShopData);
local v11 = require(l_ReplicatedStorage_0.Item_Module);
local _ = require(l_ReplicatedStorage_0.Modules.DumpTable);
local v13 = nil;
local v14 = v6.new();
local l_ScrollingFrame_0 = l_Seed_Shop_0:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local l_Timer_0 = l_Seed_Shop_0:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local l_ItemFrame_0 = l_ScrollingFrame_0:WaitForChild("ItemFrame");
l_ItemFrame_0.Parent = script;
local l_ItemPadding_0 = l_ScrollingFrame_0:WaitForChild("ItemPadding");
l_ItemPadding_0.Parent = l_ScrollingFrame_0;
local v19 = require(game.ReplicatedStorage.Data.SeedData);
local v20 = {};
local v21 = {};
local function _() --[[ Line: 27 ]] --[[ Name: _ ]]
	-- upvalues: v4 (copy), v10 (copy)
	local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
	local l_v4_Data_0 = v4:GetData();
	local v24 = l_v4_Data_0.SeedStock.ForcedSeedEndTimestamp and l_v4_Data_0.SeedStock.ForcedSeedEndTimestamp - l_workspace_ServerTimeNow_0 or -1;
	if v24 >= 0 then
		return v24;
	else
		return v10.RefreshTime - l_workspace_ServerTimeNow_0 % v10.RefreshTime;
	end;
end;
local function v30() --[[ Line: 38 ]] --[[ Name: setupTimer ]]
	-- upvalues: v4 (copy), v10 (copy), l_Timer_0 (copy)
	while true do
		local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
		local l_v4_Data_1 = v4:GetData();
		local v28 = l_v4_Data_1.SeedStock.ForcedSeedEndTimestamp and l_v4_Data_1.SeedStock.ForcedSeedEndTimestamp - l_workspace_ServerTimeNow_1 or -1;
		local v29 = if v28 >= 0 then v28 else v10.RefreshTime - l_workspace_ServerTimeNow_1 % v10.RefreshTime;
		l_Timer_0.Text = v29 <= 0 and "Restocking" or "New seeds in " .. string.format("%01d:%02d", v29 / 60, v29 % 60);
		if v29 <= 1 then
			require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#ADD8E6\"><b>Your Seed shop stock has been reset!</b></font>");
		end;
		task.wait(1);
	end;
end;
local function _(v31) --[[ Line: 52 ]] --[[ Name: _ ]]
	local v32, v33, v34 = v31:ToHSV();
	return Color3.fromHSV(v32, v33, v34 / 2);
end;
local v36 = string.split(l_ReplicatedStorage_0:WaitForChild("Collectibles").Value, "|");
local function v74() --[[ Line: 57 ]] --[[ Name: setupFrames ]]
	-- upvalues: v30 (copy), v19 (copy), v36 (copy), l_ItemFrame_0 (copy), v20 (copy), v11 (copy), v5 (copy), l_ScrollingFrame_0 (copy), v7 (copy), l_ItemPadding_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy), v9 (copy), v13 (ref), v14 (copy), v4 (copy)
	task.spawn(v30);
	local v37 = {};
	for v38, v39 in v19 do
		if v39.DisplayInShop and table.find(v36, v38) then
			local v40 = l_ItemFrame_0:Clone();
			v20[v38] = v40;
			v40.Name = v38;
			v40.LayoutOrder = v39.LayoutOrder * 10;
			table.insert(v37, v40);
			local l_Main_Frame_0 = v40.Main_Frame;
			local v42 = v11.Return_Rarity_Data(v39.SeedRarity);
			if v42 then
				if v42[1] == "Prismatic" then
					local v43 = nil;
					do
						local l_v43_0 = v43;
						l_v43_0 = game:GetService("RunService").Heartbeat:Connect(function(_) --[[ Line: 75 ]]
							-- upvalues: l_Main_Frame_0 (copy), l_v43_0 (ref), v42 (copy)
							if not l_Main_Frame_0 or not l_Main_Frame_0.Parent then
								l_v43_0:Disconnect();
								return;
							else
								local v46 = tick() * 0.1 % 1;
								local v47 = Color3.fromHSV(v46, 1, 1);
								l_Main_Frame_0.Rarity_BG.ImageColor3 = v47;
								l_Main_Frame_0.Rarity_Text.Text = v42[1];
								if l_Main_Frame_0.Rarity_Text.UIStroke then
									local l_UIStroke_0 = l_Main_Frame_0.Rarity_Text.UIStroke;
									local v49, v50, v51 = v47:ToHSV();
									l_UIStroke_0.Color = Color3.fromHSV(v49, v50, v51 / 2);
								end;
								return;
							end;
						end);
					end;
				else
					l_Main_Frame_0.Rarity_Text.Text = v42[1];
					local l_UIStroke_1 = l_Main_Frame_0.Rarity_Text.UIStroke;
					local v53, v54, v55 = v42[2]:ToHSV();
					l_UIStroke_1.Color = Color3.fromHSV(v53, v54, v55 / 2);
					l_Main_Frame_0.Rarity_BG.ImageColor3 = v42[2];
				end;
			end;
			l_Main_Frame_0.Seed_Text.Text = v39.SeedName;
			l_Main_Frame_0.Seed_Text_Shadow.Text = v39.SeedName;
			l_Main_Frame_0.Cost_Text.Text = v5.Comma(v39.Price) .. "\194\162";
			local v56 = v39.Asset:Clone();
			local l_BasePart_0 = v40.Main_Frame.ViewportFrame.BasePart;
			v56.CFrame = l_BasePart_0.CFrame;
			v56.Parent = v40.Main_Frame.ViewportFrame;
			l_BasePart_0:Destroy();
			v40.Parent = l_ScrollingFrame_0;
			v56.Orientation = Vector3.new(0, 45, 0, 0);
			local v58 = nil;
			do
				local l_v58_0 = v58;
				l_Main_Frame_0.MouseEnter:Connect(function() --[[ Line: 115 ]]
					-- upvalues: l_v58_0 (ref), v7 (ref), v56 (copy), v40 (copy)
					l_v58_0 = v7(v56, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0), {
						Orientation = v56.Orientation + Vector3.new(0, 360, 0, 0)
					});
					v7(v40.Main_Frame.ViewportFrame.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
						Scale = 1.25
					});
				end);
				l_Main_Frame_0.MouseLeave:Connect(function() --[[ Line: 124 ]]
					-- upvalues: l_v58_0 (ref), v56 (copy), v7 (ref), v40 (copy)
					if l_v58_0 then
						l_v58_0:Cancel();
					end;
					v56.Orientation = Vector3.new(0, 45, 0, 0);
					v7(v40.Main_Frame.ViewportFrame.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
						Scale = 1
					});
				end);
				local v60 = l_ItemPadding_0:Clone();
				v60.LayoutOrder = v39.LayoutOrder * 10 + 1;
				v60.Name = ("%*_Padding"):format(v38);
				v60.Parent = l_ScrollingFrame_0;
				local l_Frame_0 = v40.Frame;
				l_Frame_0.Sheckles_Buy.In_Stock.Cost_Text.Text = v5.Comma(v39.Price) .. "\194\162";
				l_Frame_0.Sheckles_Buy.Activated:Connect(function() --[[ Line: 140 ]]
					-- upvalues: v38 (copy), l_ReplicatedStorage_0 (ref)
					if workspace:GetAttribute("InTutorial") and v38 ~= "Carrot" then
						return;
					else
						l_ReplicatedStorage_0.GameEvents.BuySeedStock:FireServer(v38);
						return;
					end;
				end);
				l_Frame_0.Robux_Buy.Activated:Connect(function() --[[ Line: 149 ]]
					-- upvalues: v8 (ref), v39 (copy)
					v8:PromptPurchase(v39.PurchaseID, Enum.InfoType.Product);
				end);
				l_Frame_0.Gift.Visible = v39.GiftPurchaseID ~= nil;
				if v39.GiftPurchaseID then
					l_Frame_0.Gift.Activated:Connect(function() --[[ Line: 155 ]]
						-- upvalues: v9 (ref), v39 (copy)
						v9:PromptGiftFromGiftId(v39.GiftPurchaseID);
					end);
				end;
				local function v62() --[[ Line: 160 ]] --[[ Name: updateOptions ]]
					-- upvalues: v13 (ref), v38 (copy), l_Frame_0 (copy), v7 (ref), v60 (copy)
					if v13 == v38 then
						l_Frame_0.Visible = true;
						v7(l_Frame_0, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Position = UDim2.fromScale(0.5, 1.3)
						});
						v7(v60, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(0.13, 0.25)
						});
						return;
					else
						l_Frame_0.Visible = false;
						v7(l_Frame_0, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Position = UDim2.fromScale(0.5, 0.5)
						});
						v7(v60, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(0.13, 0.02)
						});
						return;
					end;
				end;
				v14:Connect(v62);
				task.spawn(v62);
				l_Main_Frame_0.Activated:Connect(function() --[[ Line: 184 ]]
					-- upvalues: v7 (ref), l_ScrollingFrame_0 (ref), v40 (copy), v37 (copy), v13 (ref), v38 (copy), v14 (ref)
					v7(l_ScrollingFrame_0, TweenInfo.new(0.35), {
						CanvasPosition = Vector2.new(0, v40.AbsoluteSize.Y * (table.find(v37, v40) - 1))
					});
					v13 = if v13 == v38 then nil else v38;
					v14:Fire();
				end);
				task.spawn(function() --[[ Line: 192 ]]
					-- upvalues: v8 (ref), l_Frame_0 (copy), v39 (copy)
					v8:SetPriceLabel(l_Frame_0.Robux_Buy.Price, v39.PurchaseID, ":robux::value:");
				end);
				local function v67() --[[ Line: 196 ]] --[[ Name: updateStock ]]
					-- upvalues: v4 (ref), v38 (copy), l_Main_Frame_0 (copy), l_Frame_0 (copy), v5 (ref), v39 (copy)
					local l_v4_Data_2 = v4:GetData();
					local v64 = l_v4_Data_2 and l_v4_Data_2.SeedStock.Stocks[v38];
					local v65 = v64 and v64.Stock or 0;
					local v66 = ("X%* Stock"):format(v65);
					l_Main_Frame_0.Stock_Text.Text = v66;
					l_Frame_0.Sheckles_Buy.In_Stock.Visible = v65 > 0;
					l_Frame_0.Sheckles_Buy.No_Stock.Visible = v65 <= 0;
					l_Frame_0.Sheckles_Buy.HoverImage = v65 > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
					l_Frame_0.Sheckles_Buy.Image = v65 > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
					l_Main_Frame_0.Cost_Text.Text = v65 <= 0 and "NO STOCK" or v5.Comma(v39.Price) .. "\194\162";
					l_Main_Frame_0.Cost_Text.TextColor3 = if v65 <= 0 then Color3.fromRGB(255, 0, 0) else Color3.fromRGB(0, 255, 0);
				end;
				task.spawn(v67);
				task.spawn(function() --[[ Line: 211 ]]
					-- upvalues: v4 (ref), v67 (copy)
					local l_v4_PathSignal_0 = v4:GetPathSignal("SeedStock/@");
					if l_v4_PathSignal_0 then
						l_v4_PathSignal_0:Connect(v67);
					end;
					local l_v4_PathSignal_1 = v4:GetPathSignal("SeedStock");
					if l_v4_PathSignal_1 then
						l_v4_PathSignal_1:Connect(v67);
					end;
				end);
			end;
		end;
	end;
	table.sort(v37, function(v70, v71) --[[ Line: 225 ]]
		local l_LayoutOrder_0 = v70.LayoutOrder;
		local l_LayoutOrder_1 = v71.LayoutOrder;
		if l_LayoutOrder_0 == l_LayoutOrder_1 then
			return v70.Name < v71.Name;
		else
			return l_LayoutOrder_0 < l_LayoutOrder_1;
		end;
	end);
end;
v21.Start = function(_) --[[ Line: 235 ]]
	-- upvalues: v3 (copy), l_Seed_Shop_0 (copy), v74 (copy)
	v3:UsePopupAnims(l_Seed_Shop_0);
	l_Seed_Shop_0.Frame.Frame.ExitButton.Activated:Connect(function() --[[ Line: 238 ]]
		-- upvalues: v3 (ref), l_Seed_Shop_0 (ref)
		v3:Close(l_Seed_Shop_0);
	end);
	l_Seed_Shop_0.Frame.Frame.Restock.Activated:Connect(function() --[[ Line: 242 ]]

	end);
	v74();
end;
task.spawn(v21.Start, v21);
return v21;