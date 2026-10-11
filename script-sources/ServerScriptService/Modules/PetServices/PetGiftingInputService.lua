-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetGiftingInputService, time of decompilation: Wed Jun  4 21:32:03 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v3 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
l_LocalPlayer_0.CharacterAdded:Connect(function(v4) --[[ Line: 7 ]]
    -- upvalues: v3 (ref)
    v3 = v4;
end);
local v5 = require(l_ReplicatedStorage_0.Modules.PetServices.PetGiftingService);
local _ = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v7 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local l_MINIMUM_DISTANCE_FOR_GIFTING_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetConfig.PET_GIFTING_CONFIG.MINIMUM_DISTANCE_FOR_GIFTING;
local v9 = {};
local function v19() --[[ Line: 16 ]] --[[ Name: v19 ]]
    -- upvalues: v7 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v3 (ref), l_MINIMUM_DISTANCE_FOR_GIFTING_0 (copy)
    local _ = v7:GetClientPetState(l_LocalPlayer_0.Name);
    local v11 = nil;
    local v12 = 1e999;
    local l_l_Players_0_Players_0 = l_Players_0:GetPlayers();
    local v14 = table.find(l_l_Players_0_Players_0, l_LocalPlayer_0);
    if v14 then
        table.remove(l_l_Players_0_Players_0, v14);
    end;
    for _, v16 in l_l_Players_0_Players_0 do
        local l_Character_0 = v16.Character;
        if l_Character_0 then
            local l_Magnitude_0 = (l_Character_0:GetPivot().Position - v3:GetPivot().Position).Magnitude;
            if l_Magnitude_0 < v12 and l_Magnitude_0 < l_MINIMUM_DISTANCE_FOR_GIFTING_0 then
                v11 = l_Character_0;
                v12 = l_Magnitude_0;
            end;
        end;
    end;
    return v11;
end;
local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
l_ProximityPrompt_0.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow;
l_ProximityPrompt_0.KeyboardKeyCode = Enum.KeyCode.E;
l_ProximityPrompt_0.RequiresLineOfSight = false;
l_ProximityPrompt_0.HoldDuration = 0.5;
l_ProximityPrompt_0.MaxActivationDistance = 1e999;
local v21 = nil;
l_ProximityPrompt_0.Triggered:Connect(function() --[[ Line: 45 ]]
    -- upvalues: v21 (ref), l_Players_0 (copy), v5 (copy)
    if not v21 then
        return warn("No Closest");
    else
        local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v21);
        if not l_l_Players_0_PlayerFromCharacter_0 then
            return warn("No player");
        else
            v5:GivePet(l_l_Players_0_PlayerFromCharacter_0);
            return;
        end;
    end;
end);
local _ = require(l_ReplicatedStorage_0.Data.DecimalNumberFormat);
task.spawn(function() --[[ Line: 60 ]]
    -- upvalues: v3 (ref), l_ProximityPrompt_0 (copy), v19 (copy), v21 (ref)
    while true do
        task.wait(0.5);
        local l_Tool_0 = v3:FindFirstChildWhichIsA("Tool");
        if not l_Tool_0 then
            l_ProximityPrompt_0.Enabled = false;
        elseif l_Tool_0:GetAttribute("ItemType") ~= "Pet" then
            l_ProximityPrompt_0.Enabled = false;
        elseif l_Tool_0:GetAttribute("Favorite") == true then
            l_ProximityPrompt_0.Enabled = false;
        else
            local v25 = v19();
            v21 = v25;
            if not v25 then
                l_ProximityPrompt_0.Enabled = false;
            else
                l_ProximityPrompt_0.ObjectText = v25.Name;
                l_ProximityPrompt_0.ActionText = ("Gift Pet %*"):format(l_Tool_0.Name);
                l_ProximityPrompt_0.Enabled = true;
                l_ProximityPrompt_0.Parent = v25.PrimaryPart or v25:FindFirstChildWhichIsA("BasePart", true);
            end;
        end;
    end;
end);
return v9;