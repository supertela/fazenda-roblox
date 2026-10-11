-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetInformationUserInterfaceService, time of decompilation: Wed Jun  4 21:32:00 2025 ]]
local _ = game:GetService("Selection");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
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
local l_PetList_0 = v11.PetList;
local l_MAX_LEVEL_0 = v11.PetConfig.XP_CONFIG.MAX_LEVEL;
local l_PetInformationUI_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetInformationUI");
local v16 = v10(l_PetInformationUI_0, "CanvasGroup");
local v17 = v10(l_PetInformationUI_0, "DROP_SHADOW");
local v18 = v10(l_PetInformationUI_0, "PET_TEXT");
local v19 = v10(l_PetInformationUI_0, "LEVEL_TEXT");
local v20 = v10(l_PetInformationUI_0, "HUNGER_BAR");
local v21 = v10(l_PetInformationUI_0, "LEVEL_PROGRESS_BAR");
local v22 = v10(l_PetInformationUI_0, "LEVEL_ICON");
local v23 = v10(l_PetInformationUI_0, "LEVEL_MAXED_TEXT");
local v24 = v10(l_PetInformationUI_0, "CANVAS_STROKE");
local v25 = {
    Active = false, 
    Target = nil
};
v25.SetTarget = function(_, v27) --[[ Line: 36 ]]
    -- upvalues: v25 (copy), v9 (copy), v18 (copy), v19 (copy)
    v25.Target = v27;
    if not v27 then
        return;
    else
        local l_v9_PetDataFromPetObject_0 = v9:GetPetDataFromPetObject(v27);
        if not l_v9_PetDataFromPetObject_0 then
            return;
        else
            local l_PetType_0 = l_v9_PetDataFromPetObject_0.PetType;
            local l_PetData_0 = l_v9_PetDataFromPetObject_0.PetData;
            local l_Name_0 = l_PetData_0.Name;
            if l_Name_0 == "" then
                l_Name_0 = nil;
            end;
            v18.Text = l_Name_0 or l_PetType_0;
            v19.Text = ("Age %*"):format(l_PetData_0.Level);
            v25:Update(0);
            return;
        end;
    end;
end;
v25.Update = function(_, v33) --[[ Line: 59 ]]
    -- upvalues: v25 (copy), v9 (copy), l_PetList_0 (copy), l_TweenService_0 (copy), v20 (copy), v12 (copy), l_MAX_LEVEL_0 (copy), v21 (copy), v23 (copy), v22 (copy)
    local l_Target_0 = v25.Target;
    if not l_Target_0 then
        return;
    else
        local l_v9_PetDataFromPetObject_1 = v9:GetPetDataFromPetObject(l_Target_0);
        if not l_v9_PetDataFromPetObject_1 then
            return;
        else
            local l_PetType_1 = l_v9_PetDataFromPetObject_1.PetType;
            local l_PetData_1 = l_v9_PetDataFromPetObject_1.PetData;
            local l_DefaultHunger_0 = l_PetList_0[l_PetType_1].DefaultHunger;
            local v39 = l_PetData_1.Hunger / l_DefaultHunger_0;
            l_TweenService_0:Create(v20, TweenInfo.new(v33 or 0.2), {
                Size = UDim2.fromScale(v39, 1)
            }):Play();
            local l_Level_0 = l_PetData_1.Level;
            local l_v12_CurrentLevelXPCost_0 = v12:GetCurrentLevelXPCost(l_Level_0);
            local v42 = l_MAX_LEVEL_0 <= l_Level_0;
            local v43 = l_PetData_1.LevelProgress or 0;
            local v44 = v42 and 1 or v43 / l_v12_CurrentLevelXPCost_0;
            l_TweenService_0:Create(v21, TweenInfo.new(v33 or 0.2), {
                Size = UDim2.fromScale(v44, 1)
            }):Play();
            v23.Visible = v42;
            v22.Visible = not v42;
            return;
        end;
    end;
end;
v25.Toggle = function(_, v46) --[[ Line: 90 ]]
    -- upvalues: v25 (copy), l_TweenService_0 (copy), v16 (copy), v17 (copy), v24 (copy)
    if v25.Active == v46 then
        return;
    else
        v25.Active = v46;
        local v47 = l_TweenService_0:Create(v16, TweenInfo.new(0.15), {
            GroupTransparency = v46 and 0 or 1
        });
        local _ = l_TweenService_0:Create(v17, TweenInfo.new(0.15), {
            ImageTransparency = v46 and 0.6 or 1
        });
        v47:Play();
        l_TweenService_0:Create(v24, TweenInfo.new(0.15), {
            Transparency = v46 and 0 or 1
        }):Play();
        if not v46 then
            v25.Target = nil;
        end;
        return;
    end;
end;
local function _(v49) --[[ Line: 112 ]] --[[ Name: _ ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    if not v49 then
        return;
    else
        local v50 = l_CurrentCamera_0:WorldToScreenPoint(v49);
        return UDim2.fromOffset(v50.X, v50.Y);
    end;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 121 ]]
    -- upvalues: v25 (copy), l_PetInformationUI_0 (copy), l_CurrentCamera_0 (ref)
    if not v25.Active then
        return;
    elseif not v25.Target then
        v25:Toggle(false);
        return;
    else
        local l_l_PetInformationUI_0_0 = l_PetInformationUI_0;
        local v53 = v25.Target.Position + Vector3.new(0, 5, 0, 0);
        local v54 = nil;
        if not v53 then
            v54 = nil;
        else
            local v55 = l_CurrentCamera_0:WorldToScreenPoint(v53);
            v54 = UDim2.fromOffset(v55.X, v55.Y);
        end;
        l_l_PetInformationUI_0_0.Position = v54;
        return;
    end;
end);
task.spawn(function() --[[ Line: 142 ]]
    -- upvalues: v25 (copy)
    while true do
        task.wait(1);
        v25:Update();
    end;
end);
return v25;