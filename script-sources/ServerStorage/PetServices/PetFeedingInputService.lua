-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetFeedingInputService, time of decompilation: Wed Jun  4 21:32:01 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local v2 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
l_LocalPlayer_0.CharacterAdded:Connect(function(v3) --[[ Line: 6 ]]
    -- upvalues: v2 (ref)
    v2 = v3;
end);
local v4 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v5 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local l_MINIMUM_DISTANCE_FOR_FEEDING_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetConfig.PET_FEEDING_CONFIG.MINIMUM_DISTANCE_FOR_FEEDING;
local v7 = {};
local function v17() --[[ Line: 14 ]] --[[ Name: v17 ]]
    -- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v2 (ref), l_MINIMUM_DISTANCE_FOR_FEEDING_0 (copy)
    local l_v5_ClientPetState_0 = v5:GetClientPetState(l_LocalPlayer_0.Name);
    local v9 = nil;
    local v10 = 1e999;
    local v11 = nil;
    for v12, v13 in l_v5_ClientPetState_0 do
        local l_Asset_0 = v13.Asset;
        if not l_Asset_0 then
            return;
        else
            local l_l_Asset_0_FirstChildWhichIsA_0 = l_Asset_0:FindFirstChildWhichIsA("Model", true);
            local l_Magnitude_0 = (l_l_Asset_0_FirstChildWhichIsA_0:GetPivot().Position - v2:GetPivot().Position).Magnitude;
            if l_Magnitude_0 < v10 and l_Magnitude_0 < l_MINIMUM_DISTANCE_FOR_FEEDING_0 then
                v9 = l_l_Asset_0_FirstChildWhichIsA_0;
                v10 = l_Magnitude_0;
                v11 = v12;
            end;
        end;
    end;
    return v11, v9;
end;
local v18 = nil;
local l_Part_0 = Instance.new("Part");
l_Part_0.CanCollide = false;
l_Part_0.CanQuery = false;
l_Part_0.Anchored = true;
l_Part_0.Transparency = 1;
l_Part_0.Parent = workspace;
local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
l_ProximityPrompt_0.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow;
l_ProximityPrompt_0.KeyboardKeyCode = Enum.KeyCode.F;
l_ProximityPrompt_0.RequiresLineOfSight = false;
l_ProximityPrompt_0.HoldDuration = 0.5;
l_ProximityPrompt_0.MaxActivationDistance = 1e999;
l_ProximityPrompt_0.Triggered:Connect(function() --[[ Line: 49 ]]
    -- upvalues: v18 (ref), v5 (copy)
    if not v18 then
        return;
    else
        v5:Feed(v18);
        return;
    end;
end);
l_ProximityPrompt_0.Parent = l_Part_0;
local v21 = require(l_ReplicatedStorage_0.Data.DecimalNumberFormat);
local function _() --[[ Line: 60 ]] --[[ Name: _ ]]
    -- upvalues: l_ProximityPrompt_0 (copy), l_Part_0 (copy)
    l_ProximityPrompt_0.Enabled = false;
    l_Part_0.CFrame = CFrame.new(100, 5000, 100);
end;
task.spawn(function() --[[ Line: 65 ]]
    -- upvalues: v2 (ref), l_ProximityPrompt_0 (copy), l_Part_0 (copy), v17 (copy), v5 (copy), v18 (ref), v4 (copy), v21 (copy)
    while true do
        task.wait(0.05);
        task.spawn(function() --[[ Line: 69 ]]
            -- upvalues: v2 (ref), l_ProximityPrompt_0 (ref), l_Part_0 (ref), v17 (ref), v5 (ref), v18 (ref), v4 (ref), v21 (ref)
            local l_Tool_0 = v2:FindFirstChildWhichIsA("Tool");
            if not l_Tool_0 then
                l_ProximityPrompt_0.Enabled = false;
                l_Part_0.CFrame = CFrame.new(100, 5000, 100);
                return;
            elseif not l_Tool_0:HasTag("FruitTool") then
                l_ProximityPrompt_0.Enabled = false;
                l_Part_0.CFrame = CFrame.new(100, 5000, 100);
                return;
            else
                local v24, v25 = v17();
                if not v25 then
                    l_ProximityPrompt_0.Enabled = false;
                    l_Part_0.CFrame = CFrame.new(100, 5000, 100);
                    return;
                else
                    local l_PetType_0 = v5:GetPetDataFromPetObject(v25.Parent).PetType;
                    v18 = v24;
                    local v27 = v4:GetFruitWorthPercentageForAnimal(l_PetType_0, l_Tool_0) * 100;
                    l_Part_0.CFrame = v25:GetPivot();
                    l_ProximityPrompt_0.ObjectText = v25.Name;
                    l_ProximityPrompt_0.ActionText = ("Feed (%*%%) %*"):format(v21(v27), l_Tool_0.Name);
                    l_ProximityPrompt_0.Enabled = true;
                    return;
                end;
            end;
        end);
    end;
end);
return v7;