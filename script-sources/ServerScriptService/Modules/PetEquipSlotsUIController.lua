-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEquipSlotsUIController, time of decompilation: Wed Jun  4 21:31:47 2025 ]]
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_PetEquipSlots_UI_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("PetEquipSlots_UI");
local l_Main_0 = l_PetEquipSlots_UI_0:WaitForChild("Main");
local l_GameEvents_0 = l_ReplicatedStorage_0:WaitForChild("GameEvents");
local v6 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v7 = require(l_ReplicatedStorage_0.Modules.DataService);
local l_PetList_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetList;
local v9 = require(l_ReplicatedStorage_0.Modules.GuiController);
local l_TradeIn_0 = l_Main_0.Main.Holder.TradeInButton.TradeIn;
local l_Details_0 = l_Main_0:WaitForChild("Details");
local l_TradeInButton_0 = l_Main_0.Main.Holder.TradeInButton;
local l_Confirm_0 = l_TradeInButton_0.Confirm;
local l_Cancel_0 = l_TradeInButton_0.Cancel;
local l_TradeIn_1 = l_TradeInButton_0.TradeIn;
local l_REQUIRED_AGE_0 = l_Main_0.Main.Holder.TextHolder.REQUIRED_AGE;
local v17 = {};
local v18 = {
    Pet = "Pet", 
    Egg = "Egg", 
    EggInfo = "EggInfo"
};
v17.CurrentMode = v18.Pet;
local v19 = nil;
local v20 = {
    [0] = UDim2.new(1, 0, 0, 0), 
    [1] = UDim2.new(1, 0, 0.175, 0), 
    [2] = UDim2.new(1, 0, 0.375, 0), 
    [3] = UDim2.new(1, 0, 0.575, 0), 
    [4] = UDim2.new(1, 0, 0.775, 0), 
    [5] = UDim2.new(1, 0, 1, 0)
};
local function v26(v21) --[[ Line: 36 ]] --[[ Name: v26 ]]
    -- upvalues: l_TweenService_0 (copy), l_Details_0 (copy)
    local v22 = {
        Position = v21 and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.6, 0, 0.5, 0)
    };
    local v23 = {
        Scale = v21 and 1 or 0.1
    };
    local v24 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    l_TweenService_0:Create(l_Details_0, v24, v22):Play();
    local l_UIScale_0 = l_Details_0:FindFirstChildWhichIsA("UIScale");
    if l_UIScale_0 then
        l_TweenService_0:Create(l_UIScale_0, v24, v23):Play();
    end;
end;
local function _(v27) --[[ Line: 51 ]] --[[ Name: _ ]]
    -- upvalues: l_TradeIn_0 (copy)
    l_TradeIn_0.BackgroundTransparency = v27 and 0 or 0.5;
    l_TradeIn_0.UIStroke.Transparency = v27 and 0 or 0.5;
    l_TradeIn_0.TextLabel.TextTransparency = v27 and 0 or 0.5;
end;
local function _(v29) --[[ Line: 57 ]] --[[ Name: _ ]]
    -- upvalues: l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy)
    l_TradeIn_1.Visible = not v29;
    l_Confirm_0.Visible = v29;
    l_Cancel_0.Visible = v29;
end;
v17.SetMode = function(v31, v32) --[[ Line: 63 ]]
    -- upvalues: v19 (ref), v26 (copy), l_TradeIn_0 (copy), l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), v18 (copy), l_Main_0 (copy)
    v31.CurrentMode = v32;
    v19 = nil;
    v26(false);
    l_TradeIn_0.BackgroundTransparency = 0.5;
    l_TradeIn_0.UIStroke.Transparency = 0.5;
    l_TradeIn_0.TextLabel.TextTransparency = 0.5;
    l_TradeIn_1.Visible = true;
    l_Confirm_0.Visible = false;
    l_Cancel_0.Visible = false;
    local v33 = true;
    if v32 ~= v18.Pet then
        v33 = v32 == v18.Egg;
    end;
    l_Main_0.Main.Holder.ScrollingFrame.Visible = v33;
    l_Main_0.Main.Holder.TradeInButton.Visible = v33;
    l_Main_0.Main.Holder.TextHolder.Visible = v33;
    l_Main_0.Main.BAR.Visible = v33;
    l_Main_0.Main.Holder.EggInfo.Visible = not v33;
    if v33 then
        v31:RefreshUI();
        return;
    else
        l_Main_0.Main.Header.Title.Text = "Egg Rarity Info";
        l_Main_0.Main.Header.BackgroundColor3 = Color3.fromRGB(35, 150, 238);
        l_Main_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(17, 74, 117);
        return;
    end;
end;
local function v39(v34) --[[ Line: 93 ]] --[[ Name: v39 ]]
    -- upvalues: l_PetList_0 (copy), v6 (copy), l_Details_0 (copy)
    local v35 = l_PetList_0[v34.PetType];
    local l_PetData_0 = v34.PetData;
    local l_Level_0 = l_PetData_0.Level;
    local v38 = math.round(v6:CalculateWeight(l_PetData_0.BaseWeight, l_Level_0) * 100) / 100;
    l_Details_0.Holder.Header.PET_TEXT.Text = v34.PetType or "Unknown";
    l_Details_0.Holder.Display.Display.PET_NAME_CONFIG.Text = l_PetData_0.Name or "Unnamed";
    l_Details_0.Holder.Display.Display.PET_IMAGE.Image = v35.Icon or "";
    l_Details_0.Holder.Description.Display.PET_DESCRIPTION.Text = v35.Description or "No description available.";
    l_Details_0.Holder.Stats.Holder.Weight.PET_WEIGHT.Text = ("Weight: %* KG"):format(v38);
    l_Details_0.Holder.Stats.Holder.Age.PET_AGE.Text = ("Age: %*"):format(l_Level_0);
end;
v17.Show = function(v40) --[[ Line: 106 ]]
    -- upvalues: l_PetEquipSlots_UI_0 (copy)
    l_PetEquipSlots_UI_0.Enabled = true;
    v40:SetMode(v40.CurrentMode);
    v40:RefreshUI();
end;
v17.Hide = function(_) --[[ Line: 112 ]]
    -- upvalues: l_PetEquipSlots_UI_0 (copy)
    l_PetEquipSlots_UI_0.Enabled = false;
end;
v17.RefreshUI = function(_) --[[ Line: 116 ]]
    -- upvalues: v19 (ref), v26 (copy), l_TradeIn_0 (copy), l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), v7 (copy), v17 (copy), l_Main_0 (copy), v20 (copy), v6 (copy), l_LocalPlayer_0 (copy), l_PetList_0 (copy), v39 (copy)
    v19 = nil;
    v26(false);
    l_TradeIn_0.BackgroundTransparency = 0.5;
    l_TradeIn_0.UIStroke.Transparency = 0.5;
    l_TradeIn_0.TextLabel.TextTransparency = 0.5;
    l_TradeIn_1.Visible = true;
    l_Confirm_0.Visible = false;
    l_Cancel_0.Visible = false;
    local l_v7_Data_0 = v7:GetData();
    local _ = l_v7_Data_0.PetsData.MutableStats;
    local v45 = v17.CurrentMode == "Pet";
    local v46 = if v45 then l_v7_Data_0.PetsData.PurchasedEquipSlots or 0 else l_v7_Data_0.PetsData.PurchasedEggSlots or 0;
    local v47 = ({
        20, 
        30, 
        45, 
        60, 
        75
    })[v46 + 1] or 999;
    if v17.CurrentMode == "Pet" then
        l_Main_0.Main.Header.Title.Text = "Trade in Pets for Extra Pet Equip Slots!";
        l_Main_0.Main.Header.BackgroundColor3 = Color3.fromRGB(255, 175, 21);
        l_Main_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(134, 87, 11);
    elseif v17.CurrentMode == "Egg" then
        l_Main_0.Main.Header.Title.Text = "Trade in Pets for Extra Egg Equip Slots!";
        l_Main_0.Main.Header.BackgroundColor3 = Color3.fromRGB(83, 171, 52);
        l_Main_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(57, 100, 47);
    end;
    if v46 >= 5 then
        l_Main_0.Main.Holder.TextHolder.REQUIRED_AGE.Text = "You have reached the maximum amount of pet equip slots!";
        l_Main_0.Main.Holder.ScrollingFrame.Visible = false;
        l_Main_0.Main.Holder.TradeInButton.Visible = false;
    elseif v45 or v17.CurrentMode == "Egg" then
        l_Main_0.Main.Holder.TextHolder.REQUIRED_AGE.Text = ("Required age for next pet equip slot unlock: <font color=\"#ffbe19\">%*</font>"):format(v47);
        l_Main_0.Main.Holder.ScrollingFrame.Visible = true;
        l_Main_0.Main.Holder.TradeInButton.Visible = true;
    end;
    l_Main_0.Main.BAR.ACTUAL_BAR.Size = v20[math.clamp(v46, 0, 5)] or v20[0];
    local l_IncrementalListing_0 = l_Main_0.Main.BAR.IncrementalListing;
    local v49 = {
        "One", 
        "Two", 
        "Three", 
        "Four", 
        "Five"
    };
    for v50 = 1, 5 do
        local l_l_IncrementalListing_0_FirstChild_0 = l_IncrementalListing_0:FindFirstChild(v49[v50]);
        if l_l_IncrementalListing_0_FirstChild_0 then
            local v52 = v50 <= v46;
            local l_UIGradient_0 = l_l_IncrementalListing_0_FirstChild_0:FindFirstChildWhichIsA("UIGradient");
            if l_UIGradient_0 then
                l_UIGradient_0.Enabled = v52;
            end;
        end;
    end;
    local l_Title_0 = l_IncrementalListing_0:FindFirstChild("Title");
    if l_Title_0 and l_Title_0:FindFirstChild("UIGradient") then
        l_Title_0.UIGradient.Enabled = v46 >= 5;
    end;
    local l_Content_0 = l_Main_0.Main.Holder.ScrollingFrame.Content;
    local l_TEMPLATE_0 = l_Content_0:FindFirstChild("TEMPLATE");
    for _, v58 in l_Content_0:GetChildren() do
        if v58:IsA("ImageButton") and v58.Name ~= "TEMPLATE" then
            v58:Destroy();
        end;
    end;
    l_TEMPLATE_0.Visible = false;
    local l_v6_PetsSortedByAge_0 = v6:GetPetsSortedByAge(l_LocalPlayer_0, 0, true);
    if v46 >= 5 then
        l_TradeIn_0.BackgroundTransparency = 0.5;
        l_TradeIn_0.UIStroke.Transparency = 0.5;
        l_TradeIn_0.TextLabel.TextTransparency = 0.5;
        return;
    else
        for _, v61 in l_v6_PetsSortedByAge_0 do
            if v47 <= v61.PetData.Level then
                local v62 = l_PetList_0[v61.PetType];
                local v63 = l_TEMPLATE_0:Clone();
                v63.Visible = true;
                v63.Name = v61.UUID;
                v63.Display.PET_NAME.Text = v61.PetType or "Unknown";
                v63.Display.PET_AGE.Text = v61.PetData.Level or "1";
                v63.Display.DetailHolder.PET_IMAGE.Image = v62.Icon or "";
                local function v66(v64, v65) --[[ Line: 202 ]] --[[ Name: v66 ]]
                    if v65 then
                        v64.Display.BackgroundColor3 = Color3.fromRGB(30, 100, 14);
                        v64.Display.UIStroke.Color = Color3.fromRGB(37, 238, 38);
                        v64.Display.SELECTED_VIGNETTE.Visible = true;
                        return;
                    else
                        v64.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                        v64.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                        v64.Display.SELECTED_VIGNETTE.Visible = false;
                        return;
                    end;
                end;
                v66(v63, false);
                v63.MouseButton1Click:Connect(function() --[[ Line: 216 ]]
                    -- upvalues: v19 (ref), v61 (copy), l_Content_0 (copy), v66 (copy), l_TradeIn_0 (ref), v39 (ref), v26 (ref)
                    if v19 == v61.UUID then
                        v19 = nil;
                    else
                        v19 = v61.UUID;
                    end;
                    for _, v68 in l_Content_0:GetChildren() do
                        if v68:IsA("ImageButton") and v68:FindFirstChild("Display") then
                            local v69 = v68.Name == v19;
                            v66(v68, v69);
                        end;
                    end;
                    local v70 = v19 ~= nil;
                    l_TradeIn_0.BackgroundTransparency = v70 and 0 or 0.5;
                    l_TradeIn_0.UIStroke.Transparency = v70 and 0 or 0.5;
                    l_TradeIn_0.TextLabel.TextTransparency = v70 and 0 or 0.5;
                    if v19 then
                        v39(v61);
                        v26(true);
                        return;
                    else
                        v26(false);
                        return;
                    end;
                end);
                v63.Parent = l_Content_0;
                l_TradeIn_0.BackgroundTransparency = 0.5;
                l_TradeIn_0.UIStroke.Transparency = 0.5;
                l_TradeIn_0.TextLabel.TextTransparency = 0.5;
            end;
        end;
        return;
    end;
end;
v17.OpenEggInfoExternally = function(v71) --[[ Line: 251 ]]
    -- upvalues: v18 (copy)
    v71:SetMode(v18.EggInfo);
end;
local v72 = {};
local function _(v73, v74) --[[ Line: 256 ]] --[[ Name: _ ]]
    -- upvalues: v72 (copy)
    v74 = v74 or 0.5;
    if v72[v73] and tick() - v72[v73] < v74 then
        return true;
    else
        v72[v73] = tick();
        return false;
    end;
end;
v17.Start = function(_) --[[ Line: 266 ]]
    -- upvalues: v9 (copy), l_PetEquipSlots_UI_0 (copy), l_TradeIn_1 (copy), v72 (copy), v19 (ref), l_REQUIRED_AGE_0 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), l_GameEvents_0 (copy), v17 (copy), v26 (copy), l_TradeIn_0 (copy), l_Main_0 (copy), l_Details_0 (copy), v18 (copy)
    v9:UsePopupAnims(l_PetEquipSlots_UI_0);
    l_TradeIn_1.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 269 ]]
        -- upvalues: v72 (ref), v19 (ref), l_REQUIRED_AGE_0 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref)
        local v77 = nil;
        if v72.TradeInStart and tick() - v72.TradeInStart < 0.5 then
            v77 = true;
        else
            v72.TradeInStart = tick();
            v77 = false;
        end;
        if v77 then
            return;
        elseif not v19 then
            return;
        else
            l_REQUIRED_AGE_0.Text = "Are you sure you want to trade in this pet?";
            l_TradeIn_1.Visible = false;
            l_Confirm_0.Visible = true;
            l_Cancel_0.Visible = true;
            return;
        end;
    end);
    l_Confirm_0.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 291 ]]
        -- upvalues: v72 (ref), v19 (ref), l_GameEvents_0 (ref), v17 (ref), v26 (ref), l_TradeIn_0 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref)
        local v78 = nil;
        if v72.TradeConfirm and tick() - v72.TradeConfirm < 0.5 then
            v78 = true;
        else
            v72.TradeConfirm = tick();
            v78 = false;
        end;
        if v78 then
            return;
        elseif not v19 then
            return;
        else
            l_GameEvents_0.UnlockSlotFromPet:FireServer(v19, v17.CurrentMode);
            task.wait(1);
            v17:RefreshUI();
            v19 = nil;
            v26(false);
            l_TradeIn_0.BackgroundTransparency = 0.5;
            l_TradeIn_0.UIStroke.Transparency = 0.5;
            l_TradeIn_0.TextLabel.TextTransparency = 0.5;
            l_TradeIn_1.Visible = true;
            l_Confirm_0.Visible = false;
            l_Cancel_0.Visible = false;
            return;
        end;
    end);
    l_Cancel_0.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 320 ]]
        -- upvalues: v72 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref), v17 (ref)
        local v79 = nil;
        if v72.TradeCancel and tick() - v72.TradeCancel < 0.5 then
            v79 = true;
        else
            v72.TradeCancel = tick();
            v79 = false;
        end;
        if v79 then
            return;
        else
            l_TradeIn_1.Visible = true;
            l_Confirm_0.Visible = false;
            l_Cancel_0.Visible = false;
            v17:RefreshUI();
            return;
        end;
    end);
    l_Main_0.Main.Header.Exit.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 340 ]]
        -- upvalues: v72 (ref), v9 (ref), l_PetEquipSlots_UI_0 (ref)
        local v80 = nil;
        if v72.ExitHeader and tick() - v72.ExitHeader < 0.5 then
            v80 = true;
        else
            v72.ExitHeader = tick();
            v80 = false;
        end;
        if v80 then
            return;
        else
            v9:Close(l_PetEquipSlots_UI_0);
            return;
        end;
    end);
    l_Details_0.Holder.Header.EXIT_BUTTON.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 357 ]]
        -- upvalues: v72 (ref), v19 (ref), v26 (ref), l_TradeIn_0 (ref), v17 (ref), v18 (ref), l_Main_0 (ref)
        local v81 = nil;
        if v72.ExitDetails and tick() - v72.ExitDetails < 0.5 then
            v81 = true;
        else
            v72.ExitDetails = tick();
            v81 = false;
        end;
        if v81 then
            return;
        else
            v19 = nil;
            v26(false);
            l_TradeIn_0.BackgroundTransparency = 0.5;
            l_TradeIn_0.UIStroke.Transparency = 0.5;
            l_TradeIn_0.TextLabel.TextTransparency = 0.5;
            v17:SetMode(v18.Pet);
            for _, v83 in l_Main_0.Main.Holder.ScrollingFrame.Content:GetChildren() do
                if v83:IsA("ImageButton") and v83:FindFirstChild("Display") then
                    v83.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                    v83.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                    v83.Display.SELECTED_VIGNETTE.Visible = false;
                end;
            end;
            return;
        end;
    end);
    l_Main_0.Main.SideBar.ButtonList.PetEquipSlots.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 386 ]]
        -- upvalues: v72 (ref), v17 (ref), v18 (ref)
        local v84 = nil;
        if v72.PetButton and tick() - v72.PetButton < 0.5 then
            v84 = true;
        else
            v72.PetButton = tick();
            v84 = false;
        end;
        if v84 then
            return;
        else
            v17:SetMode(v18.Pet);
            return;
        end;
    end);
    l_Main_0.Main.SideBar.ButtonList.EggEquipSlots.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 403 ]]
        -- upvalues: v72 (ref), v17 (ref), v18 (ref)
        local v85 = nil;
        if v72.EggButton and tick() - v72.EggButton < 0.5 then
            v85 = true;
        else
            v72.EggButton = tick();
            v85 = false;
        end;
        if v85 then
            return;
        else
            v17:SetMode(v18.Egg);
            return;
        end;
    end);
    l_Main_0.Main.SideBar.ButtonList.EggInfo.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 420 ]]
        -- upvalues: v72 (ref), v17 (ref), v18 (ref)
        local v86 = nil;
        if v72.EggInfoButton and tick() - v72.EggInfoButton < 0.5 then
            v86 = true;
        else
            v72.EggInfoButton = tick();
            v86 = false;
        end;
        if v86 then
            return;
        else
            v17:SetMode(v18.EggInfo);
            return;
        end;
    end);
end;
task.spawn(v17.Start, v17);
return v17;