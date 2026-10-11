-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEggShopController, time of decompilation: Wed Jun  4 21:31:41 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("ServerScriptService");
local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
local v4 = require(l_ReplicatedStorage_0.Modules.DataService);
local v5 = require(l_ReplicatedStorage_0.Modules.WaitForDescendant);
local v6 = require(l_ReplicatedStorage_0.Modules.GiftController);
local v7 = require(l_ReplicatedStorage_0.Modules.MarketController);
local v8 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v9 = require(l_ReplicatedStorage_0.Modules.NumberUtil);
local v10 = require(l_ReplicatedStorage_0.Data.DecimalNumberFormat);
local v11 = require(l_ReplicatedStorage_0.Modules.CommaFormatNumber);
local _ = require(l_ReplicatedStorage_0.Item_Module);
local _ = require(l_ReplicatedStorage_0.Comma_Module);
local v14 = require(l_ReplicatedStorage_0.Data.PetEggShopData);
local v15 = require(l_ReplicatedStorage_0.Data.PetEggData);
local v16 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local _ = require(l_ReplicatedStorage_0.Frame_Popup_Module);
local l_PetList_0 = v16.PetList;
local v19 = {};
local l_EggModels_0 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("EggModels");
local v21 = workspace:WaitForChild("NPCS"):WaitForChild("Pet Stand");
local l_ResetTimeLabel_0 = v21:WaitForChild("Timer"):WaitForChild("SurfaceGui"):WaitForChild("ResetTimeLabel");
local l_v21_FirstChildWhichIsA_0 = v21:FindFirstChildWhichIsA("ProximityPrompt", true);
local l_ConfirmPetEggPurchase_0 = l_PlayerGui_0:WaitForChild("ConfirmPetEggPurchase");
local v25 = v5(l_ConfirmPetEggPurchase_0, "GiftButton");
local v26 = v5(l_ConfirmPetEggPurchase_0, "RobuxButton");
local v27 = v5(l_ConfirmPetEggPurchase_0, "ShecklesButton");
local v28 = v5(l_ConfirmPetEggPurchase_0, "PetChanceDetails");
local v29 = v5(l_ConfirmPetEggPurchase_0, "PetItemTemplate");
local v30 = 0;
local v31 = nil;
local function _() --[[ Line: 35 ]] --[[ Name: _ ]]
    -- upvalues: v4 (copy), v14 (copy)
    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
    local l_v4_Data_0 = v4:GetData();
    local v34 = l_v4_Data_0.PetEggStock.ForcedEggEndTimestamp and l_v4_Data_0.PetEggStock.ForcedEggEndTimestamp - l_workspace_ServerTimeNow_0 or -1;
    if v34 >= 0 then
        return v34;
    else
        return v14.RefreshTime - l_workspace_ServerTimeNow_0 % v14.RefreshTime;
    end;
end;
local function _(v36) --[[ Line: 46 ]] --[[ Name: _ ]]
    local v37 = math.floor(v36.R * 255);
    local v38 = math.floor(v36.G * 255);
    local v39 = math.floor(v36.B * 255);
    return string.format("#%02X%02X%02X", v37, v38, v39);
end;
local function v45() --[[ Line: 52 ]] --[[ Name: v45 ]]
    -- upvalues: v4 (copy), v14 (copy), l_ResetTimeLabel_0 (copy), v9 (copy), l_ReplicatedStorage_0 (copy)
    local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
    local l_v4_Data_1 = v4:GetData();
    local v43 = l_v4_Data_1.PetEggStock.ForcedEggEndTimestamp and l_v4_Data_1.PetEggStock.ForcedEggEndTimestamp - l_workspace_ServerTimeNow_1 or -1;
    local v44 = if v43 >= 0 then v43 else v14.RefreshTime - l_workspace_ServerTimeNow_1 % v14.RefreshTime;
    l_ResetTimeLabel_0.Text = v44 <= 0 and "Restocking" or v9.compactFormat(v44);
    if v44 <= 1 then
        require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("<font color=\"#DF8A0F\"><b>Your Pet Shop stock has been reset!</b></font>");
    end;
    task.wait(1);
end;
local function v80() --[[ Line: 64 ]] --[[ Name: v80 ]]
    -- upvalues: v4 (copy), v8 (copy), l_ConfirmPetEggPurchase_0 (copy), v21 (copy), v15 (copy), l_EggModels_0 (copy), v16 (copy), v11 (copy), l_ReplicatedStorage_0 (copy), v5 (copy), v28 (copy), v29 (copy), l_PetList_0 (copy), v10 (copy), v27 (copy), v7 (copy), v26 (copy), v31 (ref), v30 (ref)
    local l_v4_Data_2 = v4:GetData();
    v8:Close(l_ConfirmPetEggPurchase_0);
    local l_Children_0 = v21.EggLocations:GetChildren();
    for _, v49 in ipairs(l_Children_0) do
        if v49:IsA("Model") then
            v49:Destroy();
        end;
    end;
    for v50, v51 in pairs(l_v4_Data_2.PetEggStock.Stocks) do
        local v52 = v15[v51.EggName];
        if not v52 then
            warn((("GenerateStall | No egg found for egg \"%*\"!"):format(v51.EggName)));
        else
            local l_l_EggModels_0_FirstChild_0 = l_EggModels_0:FindFirstChild(v52.EggName);
            if not l_l_EggModels_0_FirstChild_0 then
                warn((("GenerateStall | No egg model found for name \"%*\"!"):format(v52.EggName)));
            else
                local v54 = l_l_EggModels_0_FirstChild_0:Clone();
                v54.Parent = v21.EggLocations;
                v54:PivotTo(l_Children_0[v50].CFrame);
                v54.HitBox.Anchored = true;
                if v51.Stock <= 0 then
                    v54:SetAttribute("RobuxEggOnly", true);
                    for _, v56 in v54:GetDescendants() do
                        if v56:IsA("BasePart") and v56.Name ~= "HitBox" then
                            v56.Transparency = 0.65;
                        end;
                    end;
                end;
                local l_FirstChild_0 = l_Children_0[v50]:FindFirstChild("SurfaceGui", true);
                local l_EggNameTextLabel_0 = l_FirstChild_0:WaitForChild("EggNameTextLabel");
                local l_RarityTextLabel_0 = l_FirstChild_0:WaitForChild("RarityTextLabel");
                local l_PriceTextLabel_0 = l_FirstChild_0:WaitForChild("PriceTextLabel");
                local v61 = v16.PetEggs[v52.EggName];
                local v62 = v61 and v61.Color or Color3.new(1, 1, 1);
                l_EggNameTextLabel_0.Text = v52.EggName;
                l_RarityTextLabel_0.Text = v52.EggRarity;
                l_RarityTextLabel_0.TextColor3 = v62;
                l_PriceTextLabel_0.Text = ("%*\194\162"):format((v11(v52.Price)));
                local v63 = l_ReplicatedStorage_0.ProximityPrompt:Clone();
                if not v63 then
                    return warn("PetEggShopController:GenerateStall | No Proximity Prompt found in ReplicatedStorage!");
                else
                    v63.Parent = v54;
                    v63.ActionText = "Buy Egg";
                    v63.HoldDuration = 0;
                    v63.Enabled = true;
                    v63.Triggered:Connect(function() --[[ Line: 113 ]]
                        -- upvalues: v5 (ref), l_ConfirmPetEggPurchase_0 (ref), v16 (ref), v52 (copy), v28 (ref), v29 (ref), l_PetList_0 (ref), v10 (ref), v27 (ref), v11 (ref), v7 (ref), v26 (ref), v31 (ref), v30 (ref), v50 (copy), v54 (copy), v8 (ref)
                        local _ = v5(l_ConfirmPetEggPurchase_0, "PetName");
                        local v65 = v5(l_ConfirmPetEggPurchase_0, "Rarity");
                        local v66 = v5(l_ConfirmPetEggPurchase_0, "HeaderTitle");
                        local l_PetEggs_0 = v16.PetEggs;
                        if not l_PetEggs_0 then
                            return warn((("PetEggShopController:GenerateStall | Cannot find Pet Rarity Data for \"%*\"!"):format(v52.EggName)));
                        else
                            local v68 = l_PetEggs_0[v52.EggName];
                            local l_Color_0 = v68.Color;
                            local l_Items_0 = v68.RarityData.Items;
                            local v71 = math.floor(l_Color_0.R * 255);
                            local v72 = math.floor(l_Color_0.G * 255);
                            local v73 = math.floor(l_Color_0.B * 255);
                            local v74 = string.format("#%02X%02X%02X", v71, v72, v73);
                            v65.TextColor3 = l_Color_0;
                            v66.Text = string.format("Purchase <font color=\"%s\">%s</font>", v74, v52.EggName);
                            for _, v76 in (v28:GetChildren()) do
                                if v76:IsA("Frame") and v76.Visible then
                                    v76:Destroy();
                                end;
                            end;
                            for v77, v78 in l_Items_0 do
                                local v79 = v29:Clone();
                                v79.Parent = v28;
                                v79.Visible = true;
                                if l_PetList_0[v77] and l_PetList_0[v77].Icon then
                                    v79.Detail.PetImageLabel.Image = l_PetList_0[v77].Icon;
                                end;
                                v79.PetChance.Text = ("%*%%"):format((v10(v78.NormalizedOdd)));
                                v79.LayoutOrder = 100 / v78.NormalizedOdd;
                                v79.PetName.Text = v78.Name;
                            end;
                            v27.Text = v11(v52.Price) .. "\194\162";
                            task.spawn(function() --[[ Line: 148 ]]
                                -- upvalues: v7 (ref), v26 (ref), v52 (ref)
                                v7:SetPriceLabel(v26, v52.PurchaseID, ":robux::value:");
                            end);
                            v31 = v52;
                            v30 = v50;
                            if v54:GetAttribute("RobuxEggOnly") then
                                v27.Text = "NO STOCK";
                                v27.UIStroke.Color = Color3.fromRGB(85, 0, 0);
                                v27.Parent.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
                                v27.Parent.UIStroke.Color = Color3.fromRGB(85, 0, 0);
                            else
                                v27.Text = v11(v52.Price) .. "\194\162";
                                v27.UIStroke.Color = Color3.fromRGB(30, 100, 14);
                                v27.Parent.BackgroundColor3 = Color3.fromRGB(37, 238, 38);
                                v27.Parent.UIStroke.Color = Color3.fromRGB(30, 100, 14);
                            end;
                            v27.AutoButtonColor = not v54:GetAttribute("RobuxEggOnly");
                            v27.Active = not v54:GetAttribute("RobuxEggOnly");
                            v8:Open(l_ConfirmPetEggPurchase_0);
                            return;
                        end;
                    end);
                    v63.PromptShown:Connect(function() --[[ Line: 172 ]]
                        -- upvalues: l_FirstChild_0 (copy)
                        l_FirstChild_0.Enabled = true;
                    end);
                    v63.PromptHidden:Connect(function() --[[ Line: 176 ]]
                        -- upvalues: l_FirstChild_0 (copy)
                        l_FirstChild_0.Enabled = false;
                    end);
                end;
            end;
        end;
    end;
end;
local function v81() --[[ Line: 185 ]] --[[ Name: v81 ]]
    -- upvalues: v5 (copy), l_ConfirmPetEggPurchase_0 (copy), v8 (copy), v26 (copy), v7 (copy), v31 (ref), v25 (copy), v6 (copy), v27 (copy), l_ReplicatedStorage_0 (copy), v30 (ref)
    v5(l_ConfirmPetEggPurchase_0, "ExitButton").Activated:Connect(function() --[[ Line: 187 ]]
        -- upvalues: v8 (ref), l_ConfirmPetEggPurchase_0 (ref)
        v8:Close(l_ConfirmPetEggPurchase_0);
    end);
    v26.Activated:Connect(function() --[[ Line: 191 ]]
        -- upvalues: v7 (ref), v31 (ref), v8 (ref), l_ConfirmPetEggPurchase_0 (ref)
        v7:PromptPurchase(v31.PurchaseID, Enum.InfoType.Product);
        v8:Close(l_ConfirmPetEggPurchase_0);
    end);
    v25.Activated:Connect(function() --[[ Line: 196 ]]
        -- upvalues: v31 (ref), v6 (ref), v8 (ref), l_ConfirmPetEggPurchase_0 (ref)
        if v31.GiftPurchaseID then
            v6:PromptGiftFromGiftId(v31.GiftPurchaseID);
        end;
        v8:Close(l_ConfirmPetEggPurchase_0);
    end);
    v27.Activated:Connect(function() --[[ Line: 203 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v30 (ref), v8 (ref), l_ConfirmPetEggPurchase_0 (ref)
        l_ReplicatedStorage_0.GameEvents.BuyPetEgg:FireServer(v30);
        v8:Close(l_ConfirmPetEggPurchase_0);
    end);
end;
v19.Start = function(_) --[[ Line: 209 ]]
    -- upvalues: v4 (copy), v80 (copy), v81 (copy), l_v21_FirstChildWhichIsA_0 (copy), v7 (copy), v45 (copy)
    task.spawn(function() --[[ Line: 211 ]]
        -- upvalues: v4 (ref), v80 (ref)
        local l_v4_PathSignal_0 = v4:GetPathSignal("PetEggStock/@");
        if l_v4_PathSignal_0 then
            l_v4_PathSignal_0:Connect(v80);
        end;
        local l_v4_PathSignal_1 = v4:GetPathSignal("PetEggStock");
        if l_v4_PathSignal_1 then
            l_v4_PathSignal_1:Connect(v80);
        end;
    end);
    task.spawn(v80);
    task.spawn(v81);
    task.spawn(function() --[[ Line: 224 ]]
        -- upvalues: l_v21_FirstChildWhichIsA_0 (ref), v7 (ref)
        l_v21_FirstChildWhichIsA_0.Triggered:Connect(function() --[[ Line: 226 ]]
            -- upvalues: v7 (ref)
            v7:PromptPurchase(3276329270, Enum.InfoType.Product);
        end);
    end);
    task.spawn(function() --[[ Line: 231 ]]
        -- upvalues: v45 (ref)
        while true do
            v45();
        end;
    end);
end;
task.spawn(v19.Start, v19);
return v19;