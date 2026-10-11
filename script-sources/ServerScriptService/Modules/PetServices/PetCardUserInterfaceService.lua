-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetCardUserInterfaceService, time of decompilation: Wed Jun  4 21:32:03 2025 ]]
local _ = game:GetService("Selection");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local _ = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local v9 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v10 = require(l_ReplicatedStorage_0.Modules.WaitForDescendant);
local v11 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v12 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v13 = require(l_ReplicatedStorage_0.Modules.PlayClickSound);
local v14 = require(l_ReplicatedStorage_0.Modules.Chalk);
local v15 = require(l_ReplicatedStorage_0.Modules.PlayHoverSound);
local l_PetList_0 = v11.PetList;
local l_MAX_LEVEL_0 = v11.PetConfig.XP_CONFIG.MAX_LEVEL;
local l_PetCard_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetCard");
local l_DropShadowHolder_0 = l_PetCard_0:WaitForChild("DropShadowHolder");
local l_Main_0 = l_PetCard_0:WaitForChild("Main");
local v21 = v10(l_PetCard_0, "PET_TEXT");
local v22 = v10(l_PetCard_0, "PET_NAME_CONFIG");
local v23 = v10(l_PetCard_0, "PET_LEVEL");
local v24 = v10(l_PetCard_0, "PET_WEIGHT");
local v25 = v10(l_PetCard_0, "XP_TEXT");
local v26 = v10(l_PetCard_0, "HUNGER_TEXT");
local v27 = v10(l_PetCard_0, "EXP_BAR");
local v28 = v10(l_PetCard_0, "HUNGER_BAR");
local _ = v10(l_PetCard_0, "PASSIVE_INSERTION_POINT");
local v30 = v10(l_PetCard_0, "PET_DESCRIPTION");
local _ = v10(l_PetCard_0, "PASSIVE_TEMPLATE");
local v32 = v10(l_PetCard_0, "PET_IMAGE");
local v33 = v10(l_PetCard_0, "EXIT_BUTTON");
local v34 = require(l_ReplicatedStorage_0.Modules.SetupBrightnessAnimationFrame)(v33);
local function _(v35, v36) --[[ Line: 42 ]] --[[ Name: _ ]]
    local v37, v38, v39 = v35:ToHSV();
    v39 = math.clamp(v39 + v36, 0, 1);
    return Color3.fromHSV(v37, v38, v39);
end;
local v41 = UDim2.fromScale(0.875, 0.5);
local v42 = v41 + UDim2.fromScale(2, 0);
local v43 = {
    Active = false, 
    Target = nil
};
local v44 = {};
v43.SetTarget = function(_, v46) --[[ Line: 54 ]]
    -- upvalues: v43 (copy), v9 (copy), l_PetList_0 (copy), v11 (copy), v14 (copy), v30 (copy), v21 (copy), v32 (copy), v44 (copy)
    v43.Target = v46;
    if not v46 then
        return;
    else
        local l_v9_PetDataFromPetObject_0 = v9:GetPetDataFromPetObject(v46);
        if not l_v9_PetDataFromPetObject_0 then
            return;
        else
            local l_PetType_0 = l_v9_PetDataFromPetObject_0.PetType;
            local l_PetData_0 = l_v9_PetDataFromPetObject_0.PetData;
            local v50 = l_PetList_0[l_PetType_0];
            local v51 = v50.Rarity or "Common";
            local l_Color_0 = v11.PetRarities[v51].Color;
            local v53, v54, v55 = l_Color_0:ToHSV();
            v55 = math.clamp(v55 + -0.4, 0, 1);
            local v56 = Color3.fromHSV(v53, v54, v55);
            v53 = v14.color(l_Color_0).stroke({
                Color = v56, 
                Joins = "Round", 
                Thickness = 2
            });
            v54 = v14.color(Color3.fromRGB(255, 255, 255)).stroke({
                Color = Color3.fromRGB(35, 35, 35), 
                Joins = "Round", 
                Thickness = 2
            });
            v55 = v53((("[%*]"):format(v51)));
            local v57 = v54(l_PetType_0);
            v30.Text = v50.Description;
            v21.Text = ("%* %*"):format(v57, v55);
            v32.Image = v50.Icon;
            local v58 = l_PetList_0[l_PetType_0];
            for _, v60 in v44 do
                v60:Destroy();
            end;
            local l_Passives_0 = v58.Passives;
            local _ = l_PetData_0.Level;
            for _, _ in l_Passives_0 do

            end;
            v43:Update();
            return;
        end;
    end;
end;
local v65 = require(l_ReplicatedStorage_0.Data.DecimalNumberFormat);
v43.Update = function(_) --[[ Line: 102 ]]
    -- upvalues: v43 (copy), v9 (copy), l_PetList_0 (copy), v12 (copy), v24 (copy), v65 (copy), v22 (copy), l_MAX_LEVEL_0 (copy), l_TweenService_0 (copy), v27 (copy), v28 (copy), v26 (copy), v23 (copy), v25 (copy), v30 (copy)
    local l_Target_0 = v43.Target;
    if not l_Target_0 then
        return;
    else
        local l_v9_PetDataFromPetObject_1 = v9:GetPetDataFromPetObject(l_Target_0);
        if not l_v9_PetDataFromPetObject_1 then
            return;
        else
            local v69 = l_PetList_0[l_v9_PetDataFromPetObject_1.PetType];
            local l_DefaultHunger_0 = v69.DefaultHunger;
            local l_PetData_1 = l_v9_PetDataFromPetObject_1.PetData;
            local v72 = v12:CalculateWeight(l_PetData_1.BaseWeight, l_PetData_1.Level);
            v24.Text = ("Weight: %* KG"):format((v65(v72)));
            local l_Name_0 = l_PetData_1.Name;
            if l_Name_0 == "" then
                l_Name_0 = nil;
            end;
            v22.Text = l_Name_0 or "Unnamed";
            local l_Level_1 = l_PetData_1.Level;
            local l_v12_CurrentLevelXPCost_0 = v12:GetCurrentLevelXPCost(l_Level_1);
            local v76 = l_MAX_LEVEL_0 <= l_Level_1;
            local v77 = l_PetData_1.LevelProgress or 0;
            local v78 = v76 and 1 or v77 / l_v12_CurrentLevelXPCost_0;
            l_TweenService_0:Create(v27.ACTUAL_BAR, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(v78, 1)
            }):Play();
            local l_Hunger_0 = l_PetData_1.Hunger;
            local v80 = l_Hunger_0 / l_DefaultHunger_0;
            l_TweenService_0:Create(v28.ACTUAL_BAR, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(v80, 1)
            }):Play();
            v26.Text = ("%* / %* HGR"):format(v65(l_Hunger_0), l_DefaultHunger_0);
            v27.ACTUAL_BAR.BAR_END.Visible = not v76;
            v23.Text = ("Age: %*"):format(l_Level_1);
            v25.Text = v76 and "MAXED" or ("%* / %* EXP"):format(v65(v77), (math.round(l_v12_CurrentLevelXPCost_0)));
            local l_Passives_1 = v69.Passives;
            local v82 = "";
            local v83 = v12:CalculateWeight(l_PetData_1.BaseWeight, l_Level_1);
            for _, v85 in l_Passives_1 do
                v82 = v82 .. ("%*\n"):format((v12:GetPassiveString(v83, v85)));
            end;
            v30.Text = v82;
            return;
        end;
    end;
end;
v43.Toggle = function(_, v87) --[[ Line: 150 ]]
    -- upvalues: l_PetCard_0 (copy), v43 (copy), l_TweenService_0 (copy), l_DropShadowHolder_0 (copy), v41 (copy), v42 (copy), l_Main_0 (copy), v33 (copy)
    if v87 then
        l_PetCard_0.Visible = true;
    end;
    v43.Active = v87;
    l_TweenService_0:Create(l_DropShadowHolder_0, TweenInfo.new(0.5), {
        Position = v87 and v41 or v42
    }):Play();
    local v88 = l_TweenService_0:Create(l_Main_0, TweenInfo.new(0.5), {
        Position = v87 and v41 or v42
    });
    v88:Play();
    v88.Completed:Connect(function() --[[ Line: 163 ]]
        -- upvalues: v87 (copy), l_PetCard_0 (ref)
        if not v87 then
            l_PetCard_0.Visible = false;
        end;
    end);
    if v87 then
        game:GetService("GamepadService"):EnableGamepadCursor(v33);
        return;
    else
        game:GetService("GamepadService"):DisableGamepadCursor();
        return;
    end;
end;
v34.MouseEnter:Connect(function() --[[ Line: 177 ]]
    -- upvalues: v15 (copy)
    v15();
end);
v34.MouseButton1Click:Connect(function() --[[ Line: 181 ]]
    -- upvalues: v13 (copy), v43 (copy)
    v13();
    v43:Toggle(false);
end);
task.spawn(function() --[[ Line: 186 ]]
    -- upvalues: v43 (copy)
    while true do
        task.wait(1);
        v43:Update();
    end;
end);
return v43;