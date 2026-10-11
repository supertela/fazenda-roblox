-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEggUserInterfaceService, time of decompilation: Wed Jun  4 21:32:02 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_PetEggUI_0 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetEggUI");
local l_CanvasGroup_0 = l_PetEggUI_0:WaitForChild("CanvasGroup");
local l_EggName_0 = l_CanvasGroup_0:WaitForChild("EggName");
local l_EggHatchTime_0 = l_CanvasGroup_0:WaitForChild("EggHatchTime");
local v8 = {};
local v9 = require(l_ReplicatedStorage_0.Modules.GetFarmAncestor);
local v10 = require(l_ReplicatedStorage_0.Modules.CreateTagHandler);
local _ = require(l_ReplicatedStorage_0.Modules.GetMouseToWorld);
local v12 = require(l_ReplicatedStorage_0.Modules.TimeHelper);
local l_PetEggs_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetEggs;
local v14 = {};
v10({
    Tag = "PetEggLocalHitBox", 
    OnInstanceAdded = function(v15) --[[ Line: 20 ]] --[[ Name: OnInstanceAdded ]]
        -- upvalues: v14 (copy)
        table.insert(v14, v15);
    end, 
    OnInstanceRemoved = function(v16) --[[ Line: 24 ]] --[[ Name: OnInstanceRemoved ]]
        -- upvalues: v14 (copy)
        local v17 = table.find(v14, v16);
        if not v17 then
            return warn((("%* hitbox not tracked!"):format(v16.Name)));
        else
            table.remove(v14, v17);
            return;
        end;
    end
});
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 36 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local v19 = nil;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 41 ]]
    -- upvalues: v19 (ref), l_CurrentCamera_0 (ref), l_PetEggUI_0 (copy)
    if not v19 then
        return;
    else
        local v20 = l_CurrentCamera_0:WorldToScreenPoint(v19:GetPivot().Position + Vector3.new(0, 2, 0, 0));
        l_PetEggUI_0.Position = UDim2.new(0, v20.X, 0, v20.Y);
        return;
    end;
end);
local function v27() --[[ Line: 51 ]] --[[ Name: v27 ]]
    -- upvalues: v19 (ref), l_PetEggs_0 (copy), l_TweenService_0 (copy), l_EggName_0 (copy), l_EggHatchTime_0 (copy), v12 (copy)
    if not v19 then
        return;
    else
        local l_v19_FirstAncestor_0 = v19:FindFirstAncestor("PetEgg");
        if not l_v19_FirstAncestor_0 then
            return;
        else
            local l_l_v19_FirstAncestor_0_Attribute_0 = l_v19_FirstAncestor_0:GetAttribute("EggName");
            local l_l_v19_FirstAncestor_0_Attribute_1 = l_v19_FirstAncestor_0:GetAttribute("TimeToHatch");
            local l_l_v19_FirstAncestor_0_Attribute_2 = l_v19_FirstAncestor_0:GetAttribute("GrowthMultiplier");
            local v25 = l_l_v19_FirstAncestor_0_Attribute_2 and l_l_v19_FirstAncestor_0_Attribute_2 > 0;
            local v26 = l_PetEggs_0[l_l_v19_FirstAncestor_0_Attribute_0];
            l_TweenService_0:Create(l_EggName_0, TweenInfo.new(0.2), {
                TextColor3 = v26.Color
            }):Play();
            l_EggHatchTime_0.Text = l_l_v19_FirstAncestor_0_Attribute_1 == 0 and "Ready" or v12:GenerateColonFormatFromTime(l_l_v19_FirstAncestor_0_Attribute_1);
            l_EggName_0.Text = l_l_v19_FirstAncestor_0_Attribute_0;
            if v25 and l_l_v19_FirstAncestor_0_Attribute_1 ~= 0 then
                l_EggHatchTime_0.TextColor3 = Color3.new(0, 0.666667, 0);
                return;
            else
                l_EggHatchTime_0.TextColor3 = Color3.new(1, 1, 1);
                return;
            end;
        end;
    end;
end;
task.spawn(function() --[[ Line: 80 ]]
    -- upvalues: v14 (copy), v9 (copy), v19 (ref), v27 (copy), l_TweenService_0 (copy), l_CanvasGroup_0 (copy)
    while true do
        task.wait(0.25);
        local v28 = RaycastParams.new();
        v28.FilterDescendantsInstances = {
            v14
        };
        v28.FilterType = Enum.RaycastFilterType.Include;
        local v29 = nil;
        local v30 = nil;
        local l_Character_0 = game.Players.LocalPlayer.Character;
        if l_Character_0 and l_Character_0:IsDescendantOf(workspace) then
            local l_p_0 = l_Character_0:GetPivot().p;
            for _, v34 in game.CollectionService:GetTagged("PetEggServer") do
                if v9(v34) then
                    local l_Magnitude_0 = (l_p_0 - v34:GetPivot().p).Magnitude;
                    if l_Magnitude_0 < 9 and (v30 == nil or l_Magnitude_0 < v29) then
                        v30 = v34:FindFirstChild("HitBox", true);
                        v29 = l_Magnitude_0;
                    end;
                end;
            end;
            if v9(v30) then
                v19 = v30;
                v27();
            else
                v19 = nil;
            end;
            l_TweenService_0:Create(l_CanvasGroup_0, TweenInfo.new(0.25), {
                GroupTransparency = v19 and 0 or 1
            }):Play();
        end;
    end;
end);
task.spawn(function() --[[ Line: 115 ]]
    -- upvalues: v27 (copy)
    while true do
        task.wait(1);
        v27();
    end;
end);
return v8;