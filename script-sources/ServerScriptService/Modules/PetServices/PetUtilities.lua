-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetUtilities, time of decompilation: Wed Jun  4 21:32:00 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local l_RunService_0 = game:GetService("RunService");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_VFX_0 = l_ReplicatedStorage_0.Assets.VFX;
local v5 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v6 = require(l_ReplicatedStorage_0.Modules.CalculatePlantValue);
local v7 = require(l_ReplicatedStorage_0.Modules.TimeHelper);
local l_SpottedEffect_0 = l_VFX_0.SpottedEffect;
local l_PetConfig_0 = v5.PetConfig;
local l_PetList_0 = v5.PetList;
local l_PetEggs_0 = v5.PetEggs;
local l_PassiveRegistry_0 = v5.PassiveRegistry;
local l_XP_CONFIG_0 = l_PetConfig_0.XP_CONFIG;
local _ = l_XP_CONFIG_0.XP_EXPONENTIAL;
local l_HUNGER_PER_WEIGHT_0 = l_PetConfig_0.PET_FEEDING_CONFIG.HUNGER_PER_WEIGHT;
local l_SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL_0 = l_PetConfig_0.WEIGHT_CONFIG.SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL;
local v17 = require(l_ReplicatedStorage_0.Modules.ExponentialScaler);
local v18 = require(l_ReplicatedStorage_0.Data.DecimalNumberFormat);
local v19 = require(l_ReplicatedStorage_0.Modules.ReplicationClass.DeepClone);
local v20 = v17.new({
    BaseCost = l_XP_CONFIG_0.XP_BASE_COST, 
    ScalingFactor = l_XP_CONFIG_0.XP_EXPONENTIAL
});
local v21 = 0;
for v22 = 1, l_XP_CONFIG_0.MAX_LEVEL do
    v21 = v21 + v20:GetCost(v22);
end;
local v36 = {
    GetCurrentLevelXPCost = function(_, v24) --[[ Line: 32 ]] --[[ Name: GetCurrentLevelXPCost ]]
        -- upvalues: v20 (copy)
        return v20:GetCost(v24);
    end, 
    GetCurrentLevelState = function(_, v26, v27) --[[ Line: 36 ]] --[[ Name: GetCurrentLevelState ]]
        -- upvalues: l_PassiveRegistry_0 (copy)
        local v28 = l_PassiveRegistry_0[v27];
        if not v28 then
            warn("Could not find passive", v27, debug.traceback(nil, 3));
            return {};
        else
            local v29 = {};
            for v30, v31 in v28.States do
                local l_Min_0 = v31.Min;
                local l_Max_0 = v31.Max;
                local v34 = v31.Scale * v26;
                local v35 = v31.Base + v34;
                if l_Min_0 and l_Max_0 then
                    v35 = math.clamp(v35, l_Min_0, l_Max_0);
                elseif l_Min_0 then
                    v35 = math.max(v35, l_Min_0);
                elseif l_Max_0 then
                    v35 = math.min(v35, l_Max_0);
                end;
                v29[v30] = v30 == "Cooldown" and v35 * 1 or v35;
            end;
            return v29;
        end;
    end
};
local v38 = {
    ColonTime = function(v37) --[[ Line: 63 ]] --[[ Name: ColonTime ]]
        -- upvalues: v7 (copy)
        return v7:GenerateColonFormatFromTime(v37);
    end
};
v36.GetPassiveString = function(_, v40, v41) --[[ Line: 68 ]]
    -- upvalues: v36 (copy), l_PassiveRegistry_0 (copy), v38 (copy), v18 (copy)
    local l_v36_CurrentLevelState_0 = v36:GetCurrentLevelState(v40, v41);
    local v43 = l_PassiveRegistry_0[v41];
    local l_Description_0 = v43.Description;
    local l_States_0 = v43.States;
    for v46, v47 in l_v36_CurrentLevelState_0 do
        local v48 = v38[l_States_0[v46].Formatter];
        local v49 = v48 and v48(v47) or tostring(v18(v47));
        l_Description_0 = l_Description_0:gsub(("<%*>"):format(v46), v49);
    end;
    return l_Description_0;
end;
v36.GetFruitWorthForAnimal = function(_, v51, v52) --[[ Line: 81 ]]
    -- upvalues: l_PetList_0 (copy), v6 (copy), l_HUNGER_PER_WEIGHT_0 (copy)
    local v53 = l_PetList_0[v51].HungerFruitMultipliers[v52:GetAttribute("ItemName")] or 1;
    return v6(v52) * l_HUNGER_PER_WEIGHT_0 * v53;
end;
v36.GetFruitWorthPercentageForAnimal = function(_, v55, v56) --[[ Line: 86 ]]
    -- upvalues: v36 (copy), l_PetList_0 (copy)
    return v36:GetFruitWorthForAnimal(v55, v56) / l_PetList_0[v55].DefaultHunger;
end;
v36.NormalizeOdds = function(_, v58) --[[ Line: 90 ]]
    local v59 = 0;
    local l_Items_0 = v58.Items;
    for _, v62 in l_Items_0 do
        v59 = v59 + v62.ItemOdd;
    end;
    for v63, v64 in l_Items_0 do
        v64.NormalizedOdd = v64.ItemOdd / v59 * 100;
        v64.Name = v63;
    end;
    v58.TotalOdds = v59;
    return v58;
end;
v36.CalculateWeight = function(_, v66, v67) --[[ Line: 103 ]]
    -- upvalues: l_SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL_0 (copy)
    return v66 + v66 * l_SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL_0 * v67;
end;
v36.GetLevelProgress = function(_, v69) --[[ Line: 107 ]]
    -- upvalues: v20 (copy), v21 (ref)
    if not v69 then
        warn("PetUtilities:GetLevelProgress | No Level!");
        return 0;
    else
        local v70 = 0;
        for v71 = 1, v69 do
            v70 = v70 + v20:GetCost(v71);
        end;
        return v70 / v21;
    end;
end;
for _, v73 in l_PetEggs_0 do
    v73.Color = v73.Color or Color3.fromRGB(255, 252, 252);
    v73.HatchTime = v73.HatchTime or 6;
    v73.RarityData = v73.RarityData or {
        Items = {}
    };
    v36:NormalizeOdds(v73.RarityData);
end;
v36.GetRandomPet = function(_, v75) --[[ Line: 128 ]]
    if not v75 or not v75.TotalOdds or not v75.Items then
        return warn((("GetRandomPet | %* is nil or invalid!"):format(v75)));
    else
        local l_TotalOdds_0 = v75.TotalOdds;
        local l_Items_1 = v75.Items;
        local v78 = math.random() * l_TotalOdds_0;
        local v79 = 0;
        for _, v81 in l_Items_1 do
            v79 = v79 + v81.ItemOdd;
            if v78 <= v79 then
                return v81;
            end;
        end;
        return;
    end;
end;
v36.GetLookAt = function(_, v83, v84) --[[ Line: 145 ]]
    return (CFrame.new(v83, (Vector3.new(v84.X, v83.Y, v84.Z))));
end;
v36.GetGeneratedEclipsePositions = function(_, v86) --[[ Line: 148 ]]
    local l_TargetCFrame_0 = v86.TargetCFrame;
    if not l_TargetCFrame_0 then
        return warn("GetGeneratedEclipsePositions: There is no TargetCFrame in Config:", v86, debug.traceback());
    else
        local l_TotalPositions_0 = v86.TotalPositions;
        if not l_TotalPositions_0 then
            return warn("GetGeneratedEclipsePositions: There is no TotalPositions in Config:", v86, debug.traceback());
        else
            local v89 = v86.StartingRowAmount or 5;
            local v90 = v86.RadiusIncrementX or 3;
            local v91 = v86.RadiusIncrementZ or 3;
            local v92 = v86.Angle or 0.39269908169872414;
            local v93 = {};
            local l_v89_0 = v89;
            local v95 = 1;
            while #v93 < l_TotalPositions_0 do
                local v96 = math.min(l_v89_0, l_TotalPositions_0 - #v93);
                local v97 = v96 == 1 and 0 or v92 * (v96 - 1) / 2;
                for v98 = 1, v96 do
                    local v99 = v92 * (v98 - 1) - v97;
                    local v100 = math.sin(v99) * v95 * v90;
                    local v101 = math.cos(v99) * v95 * v91;
                    table.insert(v93, (l_TargetCFrame_0 * CFrame.new(v100, 0, v101)).Position);
                end;
                v95 = v95 + 1;
                l_v89_0 = l_v89_0 + 1;
            end;
            return v93;
        end;
    end;
end;
v36.GetPetsSortedByAge = function(_, v103, v104, v105, v106) --[[ Line: 180 ]]
    -- upvalues: l_RunService_0 (copy), l_ServerScriptService_0 (copy), v19 (copy), l_ReplicatedStorage_0 (copy)
    v105 = v105 or false;
    v106 = v106 or false;
    v104 = v104 or 0;
    if l_RunService_0:IsServer() then
        local l_PlayerDataAsync_0 = require(l_ServerScriptService_0.Modules.DataService):GetPlayerDataAsync(v103);
        if not l_PlayerDataAsync_0 then
            return;
        else
            local l_Data_0 = l_PlayerDataAsync_0.PetsData.PetInventory.Data;
            local l_EquippedPets_0 = l_PlayerDataAsync_0.PetsData.EquippedPets;
            local v110 = {};
            for v111, v112 in l_Data_0 do
                if v104 <= v112.PetData.Level then
                    if v106 then
                        if not table.find(l_EquippedPets_0, v111) then
                            continue;
                        end;
                    elseif v105 and table.find(l_EquippedPets_0, v111) then
                        continue;
                    end;
                    local v113 = v19(v112);
                    v113.UUID = v111;
                    table.insert(v110, v113);
                end;
            end;
            table.sort(v110, function(v114, v115) --[[ Line: 207 ]]
                return v114.PetData.Level > v115.PetData.Level;
            end);
            return v110;
        end;
    elseif l_RunService_0:IsClient() then
        local l_PlayerDatastorePetData_0 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService):GetPlayerDatastorePetData(v103.Name);
        local l_Data_1 = l_PlayerDatastorePetData_0.PetInventory.Data;
        local l_EquippedPets_1 = l_PlayerDatastorePetData_0.EquippedPets;
        local v119 = {};
        for v120, v121 in l_Data_1 do
            if v104 <= v121.PetData.Level then
                if v106 then
                    if not table.find(l_EquippedPets_1, v120) then
                        continue;
                    end;
                elseif v105 and table.find(l_EquippedPets_1, v120) then
                    continue;
                end;
                local v122 = v19(v121);
                v122.UUID = v120;
                table.insert(v119, v122);
            end;
        end;
        table.sort(v119, function(v123, v124) --[[ Line: 231 ]]
            return v123.PetData.Level > v124.PetData.Level;
        end);
        return v119;
    else
        return;
    end;
end;
v36.AbilityFX = function(_, v126, v127) --[[ Line: 239 ]]
    -- upvalues: l_RunService_0 (copy), l_SpottedEffect_0 (copy), l_Debris_0 (copy)
    local v128 = if l_RunService_0:IsServer() then require(game.ServerScriptService.Modules.PetsServices.ActivePetsService) else require(game.ReplicatedStorage.Modules.PetServices.ActivePetsService);
    local v129 = l_SpottedEffect_0:Clone();
    v129.CFrame = CFrame.new(v128:GetRealPosition(v126, v127)) * CFrame.new(0, 3, 0);
    v129.Parent = workspace;
    v129.SpottedFX.SpotParticle:Emit(1);
    l_Debris_0:AddItem(v129, 3);
end;
return v36;