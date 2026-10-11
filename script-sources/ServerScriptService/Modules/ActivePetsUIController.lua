-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ActivePetsUIController, time of decompilation: Wed Jun  4 21:31:50 2025 ]]
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v5 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v6 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v7 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v8 = require(l_ReplicatedStorage_0.Modules.PetServices.PetsService);
local v9 = require(l_ReplicatedStorage_0.Modules.Notification);
local v10 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local l_PetList_0 = v10.PetList;
local l_RefreshActivePetsUI_0 = l_ReplicatedStorage_0:WaitForChild("GameEvents"):WaitForChild("RefreshActivePetsUI");
local l_ActivePetUI_0 = l_PlayerGui_0:WaitForChild("ActivePetUI");
local l_Main_0 = l_ActivePetUI_0.Frame:WaitForChild("Main");
local l_SENSOR_0 = l_Main_0:WaitForChild("Header").EXIT_BUTTON.SENSOR;
local l_ScrollingFrame_0 = l_Main_0.ScrollingFrame;
local l_PetTemplate_0 = l_ScrollingFrame_0:WaitForChild("PetTemplate");
local l_Opener_0 = l_ActivePetUI_0.Frame:WaitForChild("Opener");
local l_SENSOR_1 = l_Opener_0:WaitForChild("SENSOR");
local l_OPEN_BUTTON_0 = l_Opener_0:WaitForChild("OPEN_BUTTON");
local v21 = {};
local l_TouchEnabled_0 = game:GetService("UserInputService").TouchEnabled;
local v23 = false;
local v24 = os.clock();
local function _() --[[ Line: 28 ]] --[[ Name: _ ]]
    -- upvalues: v24 (ref)
    v24 = os.clock();
end;
local v26 = UDim2.new(2, 0, 0.5, 0);
local v27 = UDim2.new(0.88, 0, 0.5, 0);
local v28 = l_TouchEnabled_0 and UDim2.new(1, 0, 0.4, 0) or UDim2.new(1, 0, 0.5, 0);
local v29 = l_TouchEnabled_0 and UDim2.new(0, 0, 0.4, 0) or UDim2.new(0, 0, 0.5, 0);
local v30 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v31 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local function _(v32, v33, v34) --[[ Line: 38 ]] --[[ Name: _ ]]
    -- upvalues: l_TweenService_0 (copy)
    return l_TweenService_0:Create(v32, v34, {
        Position = v33
    });
end;
v21.Refresh = function(v36) --[[ Line: 44 ]]
    -- upvalues: l_ScrollingFrame_0 (copy), l_PetTemplate_0 (copy), l_ReplicatedStorage_0 (copy), l_Main_0 (copy), v6 (copy), l_LocalPlayer_0 (copy), l_PetList_0 (copy), v10 (copy), v9 (copy), v7 (copy), v8 (copy), l_Opener_0 (copy)
    for _, v38 in l_ScrollingFrame_0:GetChildren() do
        if v38:IsA("Frame") and v38 ~= l_PetTemplate_0 then
            v38:Destroy();
        end;
    end;
    local l_Data_0 = require(l_ReplicatedStorage_0.Modules.DataService):GetData();
    local l_MaxEquippedPets_0 = l_Data_0.PetsData.MutableStats.MaxEquippedPets;
    local v41 = l_Data_0.PetsData.EquippedPets or {};
    l_Main_0.Header.TITLE.Text = ("Active Pets: %*/%*"):format(#v41, l_MaxEquippedPets_0);
    local l_v6_PetsSortedByAge_0 = v6:GetPetsSortedByAge(l_LocalPlayer_0, 0, false, true);
    for _, v44 in l_v6_PetsSortedByAge_0 do
        local v45 = l_PetList_0[v44.PetType];
        local l_PetData_0 = v44.PetData;
        local v47 = l_PetTemplate_0:Clone();
        v47.Visible = true;
        v47.Name = v44.UUID;
        v47.PET_NAME.Text = l_PetData_0.Name or "Unnamed";
        v47.PET_TYPE.Text = v44.PetType or "Unknown";
        v47.PET_AGE.Text = ("Age: %*"):format(l_PetData_0.Level);
        v47.PET_IMAGE.Image = v45.Icon or "";
        local l_DefaultHunger_0 = v45.DefaultHunger;
        local v49 = math.clamp((l_PetData_0.Hunger or 0) / l_DefaultHunger_0, 0, 1);
        v47.PetStats.HUNGER.HUNGER_BAR.Size = UDim2.fromScale(v49, 1);
        local l_MAX_LEVEL_0 = v10.PetConfig.XP_CONFIG.MAX_LEVEL;
        local l_v6_CurrentLevelXPCost_0 = v6:GetCurrentLevelXPCost(l_PetData_0.Level);
        local v52 = l_MAX_LEVEL_0 <= l_PetData_0.Level;
        local v53 = l_PetData_0.LevelProgress or 0;
        local v54 = v52 and 1 or math.clamp(v53 / l_v6_CurrentLevelXPCost_0, 0, 1);
        v47.PetStats.XP.LEVEL_PROGRESS_BAR.Size = UDim2.fromScale(v54, 1);
        local l_SENSOR_2 = v47.PetStats.FEED.Inner.SENSOR;
        local l_SENSOR_3 = v47.PetStats.VIEW.Inner.SENSOR;
        local l_SENSOR_4 = v47.PetStats.PICKUP.Inner.SENSOR;
        l_SENSOR_2.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v9 (ref), v7 (ref), v44 (copy), v36 (copy)
            local l_Character_0 = l_LocalPlayer_0.Character;
            if not l_Character_0 then
                return;
            else
                local l_Tool_0 = l_Character_0:FindFirstChildWhichIsA("Tool");
                if not l_Tool_0 then
                    return v9:CreateNotification("You are not holding a fruit!");
                elseif not l_Tool_0:HasTag("FruitTool") then
                    return v9:CreateNotification("You are not holding a fruit!");
                else
                    v7:Feed(v44.UUID);
                    task.delay(0.5, function() --[[ Line: 91 ]]
                        -- upvalues: v36 (ref)
                        v36:Refresh();
                    end);
                    return;
                end;
            end;
        end);
        l_SENSOR_3.MouseButton1Click:Connect(function() --[[ Line: 99 ]]

        end);
        l_SENSOR_4.MouseButton1Click:Connect(function() --[[ Line: 102 ]]
            -- upvalues: v8 (ref), v44 (copy), l_ScrollingFrame_0 (ref), l_ReplicatedStorage_0 (ref), l_Main_0 (ref), v36 (copy)
            v8:UnequipPet(v44.UUID);
            local l_l_ScrollingFrame_0_FirstChild_0 = l_ScrollingFrame_0:FindFirstChild(v44.UUID);
            if l_l_ScrollingFrame_0_FirstChild_0 then
                l_l_ScrollingFrame_0_FirstChild_0:Destroy();
            end;
            local l_Data_1 = require(l_ReplicatedStorage_0.Modules.DataService):GetData();
            local l_MutableStats_0 = l_Data_1.PetsData.MutableStats;
            local v63 = l_Data_1.PetsData.EquippedPets or {};
            l_Main_0.Header.TITLE.Text = ("Active Pets: %*/%*"):format(#v63, l_MutableStats_0.MaxEquippedPets);
            if #v63 == 0 then
                v36:Close();
            end;
        end);
        v47.Parent = l_ScrollingFrame_0;
    end;
    local v64 = #l_v6_PetsSortedByAge_0 > 0;
    l_Opener_0.Visible = v64;
    if not v64 then
        v36:Close();
    end;
end;
task.spawn(function() --[[ Line: 125 ]]
    -- upvalues: v23 (ref), v21 (copy)
    while true do
        task.wait(5);
        if v23 then
            v21:Refresh();
        end;
    end;
end);
v21.Toggle = function(v65) --[[ Line: 134 ]]
    -- upvalues: v23 (ref), v27 (copy), v26 (copy), v29 (copy), v28 (copy), l_Opener_0 (copy), l_Main_0 (copy), l_ActivePetUI_0 (copy), v30 (copy), v31 (copy), l_TweenService_0 (copy), l_OPEN_BUTTON_0 (copy)
    v23 = not v23;
    local v66 = v23 and v27 or v26;
    local v67 = v23 and v29 or v28;
    local v68 = v23 and ">>" or "<<";
    l_Opener_0.Parent = v23 and l_Main_0 or l_ActivePetUI_0.Frame;
    local l_l_Main_0_0 = l_Main_0;
    local v70 = v23 and v30 or v31;
    l_TweenService_0:Create(l_l_Main_0_0, v70, {
        Position = v66
    }):Play();
    l_Opener_0.Position = v67;
    l_OPEN_BUTTON_0.Text = v68;
    if v23 then
        v65:Refresh();
    end;
end;
task.spawn(function() --[[ Line: 152 ]]
    -- upvalues: v23 (ref), v24 (ref), v21 (copy)
    while true do
        task.wait(1);
        if v23 and os.clock() - v24 > 6 then
            v21:Close();
        end;
    end;
end);
v21.Open = function(v71) --[[ Line: 161 ]]
    -- upvalues: v23 (ref)
    if not v23 then
        v71:Toggle();
    end;
end;
v21.Close = function(v72) --[[ Line: 167 ]]
    -- upvalues: v23 (ref)
    if v23 then
        v72:Toggle();
    end;
end;
v21.Start = function(v73) --[[ Line: 173 ]]
    -- upvalues: l_Main_0 (copy), v26 (copy), l_PetTemplate_0 (copy), l_Opener_0 (copy), l_SENSOR_0 (copy), v24 (ref), v28 (copy), l_OPEN_BUTTON_0 (copy), l_SENSOR_1 (copy), l_TouchEnabled_0 (copy)
    l_Main_0.Position = v26;
    l_PetTemplate_0.Visible = false;
    l_Opener_0.Visible = false;
    l_SENSOR_0.MouseButton1Click:Connect(function() --[[ Line: 178 ]]
        -- upvalues: v24 (ref), v73 (copy)
        v24 = os.clock();
        v73:Close();
    end);
    l_Opener_0.Position = v28;
    l_OPEN_BUTTON_0.Text = "<<";
    l_SENSOR_1.MouseButton1Click:Connect(function() --[[ Line: 185 ]]
        -- upvalues: v24 (ref), v73 (copy)
        v24 = os.clock();
        v73:Toggle();
    end);
    l_Main_0.InputBegan:Connect(function() --[[ Line: 190 ]]
        -- upvalues: v24 (ref)
        v24 = os.clock();
    end);
    if l_TouchEnabled_0 then
        l_Opener_0.Size = UDim2.new(0, 30, 0, 30);
    else
        l_Opener_0.Size = UDim2.new(0, 40, 0, 40);
    end;
    v73:Refresh();
end;
v5:GetStateForGui(l_ActivePetUI_0).Visible:Observe(function(v74) --[[ Line: 201 ]]
    -- upvalues: v21 (copy)
    if not v74 then
        v21:Close();
    end;
end);
l_RefreshActivePetsUI_0.OnClientEvent:Connect(function() --[[ Line: 207 ]]
    -- upvalues: v21 (copy)
    v21:Refresh();
end);
v21:Start();
return v21;