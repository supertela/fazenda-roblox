-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ActivePetsService, time of decompilation: Wed Jun  4 21:32:00 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Models");
local l_PetsPhysical_0 = workspace:WaitForChild("PetsPhysical");
local v6 = require(l_ReplicatedStorage_0.Modules.TwoPointCast);
local _ = require(l_ReplicatedStorage_0.Modules.ExponentialScaler);
local v8 = require(l_ReplicatedStorage_0.Modules.ReplicationClass);
local v9 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local l_AnimationEvents_0 = l_ReplicatedStorage_0.Modules.PetServices.AnimationEvents;
local v11 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v12 = require(l_ReplicatedStorage_0.Modules.PetServices.PetSoundHandler);
local v13 = RaycastParams.new();
v13.FilterDescendantsInstances = {
    workspace.MapaGrowAGarden.Canteiros
};
v13.FilterType = Enum.RaycastFilterType.Include;
local v14 = require(l_ReplicatedStorage_0.Modules.PetServices.PetVFXHandler);
local v15 = require(l_ReplicatedStorage_0.Modules.SkinService);
local _ = require(l_ReplicatedStorage_0.Modules.DumpTable);
local _ = require(l_ReplicatedStorage_0.Modules.PlatformService);
local v18 = l_UserInputService_0.TouchEnabled and "Mobile" or "PC";
local v19 = {};
for _, v21 in l_AnimationEvents_0:GetDescendants() do
    if v21:IsA("ModuleScript") then
        v19[v21.Name] = require(v21);
    end;
end;
local l_PetList_0 = v9.PetList;
local l_ActivePetService_0 = l_ReplicatedStorage_0:WaitForChild("GameEvents"):WaitForChild("ActivePetService");
local v24 = v8.new("ActivePetsService_Replicator");
local _ = v24:YieldUntilData();
local v26 = require(l_ReplicatedStorage_0.Modules.GetFarm);
local function _() --[[ Line: 37 ]] --[[ Name: _ ]]
    -- upvalues: v24 (copy)
    return v24:YieldUntilData().Table;
end;
local v28 = {};
local v29 = {};
v28.ClientPetState = v29;
local function _(v30, v31) --[[ Line: 44 ]] --[[ Name: _ ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v30;
    l_Weld_0.Part1 = v31;
    l_Weld_0.Name = "Weld";
    l_Weld_0.Parent = v31;
    l_Weld_0.Name = ("%*_%*_WELD"):format(v30.Name, v31.Name);
    return l_Weld_0;
end;
local function _(v34) --[[ Line: 53 ]] --[[ Name: _ ]]
    -- upvalues: v29 (copy)
    local v35 = v29[v34];
    if not v35 then
        v35 = {};
        v29[v34] = v35;
    end;
    return v35;
end;
local function v58(v37, v38, v39) --[[ Line: 62 ]] --[[ Name: v58 ]]
    -- upvalues: v29 (copy), v24 (copy), l_PetList_0 (copy), v15 (copy), v6 (copy), v13 (copy), v18 (copy), v12 (copy), v14 (copy)
    local v40 = v29[v37];
    if not v40 then
        v40 = {};
        v29[v37] = v40;
    end;
    v40 = v40[v38];
    local l_PetType_0 = v24:YieldUntilData().Table.PlayerPetData[v37].PetInventory.Data[v38].PetType;
    local v42 = l_PetList_0[l_PetType_0];
    local v43 = v42 and v42.Model;
    local l_Asset_0 = v40.Asset;
    local l_Model_0 = v40.Model;
    if l_Model_0 then
        l_Model_0:Destroy();
    end;
    l_Model_0 = v43 and v43:Clone();
    local l_Variant_0 = v42.Variant;
    if l_Variant_0 then
        v15:SetSkin(l_Model_0, l_Variant_0);
    end;
    l_Model_0:ScaleTo((math.max(v39 * 1, 0.1)));
    local v47 = v6(l_Asset_0.Position + Vector3.new(0, 2, 0, 0), l_Asset_0.Position - Vector3.new(0, 2, 0, 0), v13);
    local v48 = v47 and v47.Position.Y or 0;
    l_Model_0:PivotTo(l_Asset_0.CFrame * CFrame.new(0, v48 + l_Model_0:GetExtentsSize().Y / 2, 0));
    l_Model_0:AddTag("PetModel");
    local v49 = false;
    if v18 == "PC" then
        v49 = v12.new(l_PetType_0, l_Model_0, v38);
    end;
    v40.PetSoundHandler = v49;
    local _ = v14.new(l_PetType_0, l_Model_0, v38);
    v40.PetVFXHandler = v14.new(l_PetType_0, l_Model_0, v38);
    local l_PrimaryPart_0 = l_Model_0.PrimaryPart;
    local l_Weld_1 = Instance.new("Weld");
    l_Weld_1.Part0 = l_PrimaryPart_0;
    l_Weld_1.Part1 = l_Asset_0;
    l_Weld_1.Name = "Weld";
    l_Weld_1.Parent = l_Asset_0;
    l_Weld_1.Name = ("%*_%*_WELD"):format(l_PrimaryPart_0.Name, l_Asset_0.Name);
    local l_l_Weld_1_0 = l_Weld_1;
    l_l_Weld_1_0.C1 = l_l_Weld_1_0.C1 * v42.WeldOffset;
    l_Model_0.Parent = l_Asset_0;
    v40.Model = l_Model_0;
    l_PrimaryPart_0 = l_Model_0:FindFirstChild("AnimationController");
    l_Weld_1 = l_PrimaryPart_0 and l_PrimaryPart_0:FindFirstChild("Animator");
    if l_Weld_1 then
        local v54 = {};
        v40.LoadedAnimations = v54;
        for v55, v56 in v42.Animations do
            task.spawn(function() --[[ Line: 112 ]]
                -- upvalues: l_Weld_1 (ref), v56 (copy), v54 (copy), v55 (copy)
                local v57 = l_Weld_1:LoadAnimation(v56);
                v57.Looped = true;
                v54[v55] = v57;
                if v55 == "Idle" then
                    v57:Play();
                end;
            end);
        end;
    end;
end;
local function v81(v59, v60) --[[ Line: 124 ]] --[[ Name: v81 ]]
    -- upvalues: v29 (copy), l_Players_0 (copy), v26 (copy), v24 (copy), l_PetList_0 (copy), v6 (copy), v13 (copy), l_PetsPhysical_0 (copy), v58 (copy)
    local v61 = v29[v59];
    if not v61 then
        v61 = {};
        v29[v59] = v61;
    end;
    local l_v61_0 = v61;
    v61 = l_v61_0[v60];
    local l_l_Players_0_FirstChild_0 = l_Players_0:FindFirstChild(v59);
    if not l_l_Players_0_FirstChild_0 then
        return;
    else
        local v64 = v26(l_l_Players_0_FirstChild_0);
        if not v61 then
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Size = Vector3.new(2, 2, 2, 0);
            l_Part_0.Transparency = 1;
            l_Part_0.Material = Enum.Material.Neon;
            l_Part_0.Color = Color3.fromRGB(15, 119, 255);
            l_Part_0.Anchored = true;
            l_Part_0.CanQuery = false;
            l_Part_0:AddTag("PetTargetable");
            l_Part_0:SetAttribute("UUID", v60);
            l_Part_0:SetAttribute("OWNER", (tostring(v59)));
            l_Part_0.Name = "PetMover";
            l_Part_0.CanCollide = false;
            local l_Table_0 = v24:YieldUntilData().Table;
            local l_PlayerPetData_0 = l_Table_0.PlayerPetData;
            local l_ActivePetStates_0 = l_Table_0.ActivePetStates;
            local v69 = l_PlayerPetData_0[v59];
            if not v69 then
                return;
            else
                local l_PetInventory_0 = v69.PetInventory;
                if not l_PetInventory_0 then
                    return;
                else
                    local v71 = l_PetInventory_0.Data[v60];
                    if not v71 then
                        return;
                    else
                        local l_PetType_1 = v71.PetType;
                        local v73 = l_PetList_0[l_PetType_1];
                        if v73 then
                            local _ = v73.Model;
                        end;
                        local l_BaseWeight_0 = v71.PetData.BaseWeight;
                        if not v73 then
                            warn(l_PetType_1, "does not have foundpettypedata");
                            return;
                        else
                            local v76 = l_BaseWeight_0 + v73.ModelScalePerLevel * v71.PetData.Level;
                            local l_PetArea_0 = v64:FindFirstChild("PetArea");
                            local v78 = l_ActivePetStates_0[v59][v60];
                            local v79 = v6(l_Part_0.Position + Vector3.new(0, 2, 0, 0), l_Part_0.Position - Vector3.new(0, 2, 0, 0), v13);
                            local v80 = v79 and v79.Position.Y or 0;
                            l_Part_0:PivotTo(v73.MovementType == "Grounded" and CFrame.new(v78.CurrentCFrame.X, v80, v78.CurrentCFrame.Z) or v78.CurrentCFrame or l_PetArea_0.CFrame);
                            l_Part_0.Parent = l_PetsPhysical_0;
                            l_v61_0[v60] = {
                                Asset = l_Part_0, 
                                LoadedAnimations = {}
                            };
                            v58(v59, v60, v76);
                        end;
                    end;
                end;
            end;
        end;
        return v61;
    end;
end;
local function v89(v82, v83) --[[ Line: 196 ]] --[[ Name: v89 ]]
    -- upvalues: v29 (copy), v19 (copy)
    local v84 = v29[v82];
    if not v84 then
        v84 = {};
        v29[v82] = v84;
    end;
    local l_v84_0 = v84;
    v84 = l_v84_0[v83];
    if v84 then
        if v84.PetSoundHandler then
            v84.PetSoundHandler:destroy();
        end;
        v84.Asset:Destroy();
    end;
    local l_CurrentAnimation_0 = v84.CurrentAnimation;
    if l_CurrentAnimation_0 then
        local v87 = v19[l_CurrentAnimation_0.Name];
        local v88 = v87 and v87.AnimationEnded;
        if v88 then
            v88(v83);
        end;
        l_CurrentAnimation_0:Stop();
    end;
    l_v84_0[v83] = nil;
end;
local function _(v90) --[[ Line: 222 ]] --[[ Name: _ ]]
    -- upvalues: v29 (copy), v89 (copy)
    local v91 = v29[v90];
    if not v91 then
        v91 = {};
        v29[v90] = v91;
    end;
    local l_v91_0 = v91;
    if l_v91_0 then
        for v93 in l_v91_0 do
            v89(v90, v93);
        end;
    end;
    v29[v90] = nil;
end;
local function v106() --[[ Line: 237 ]] --[[ Name: v106 ]]
    -- upvalues: v24 (copy), v29 (copy), v89 (copy), v81 (copy)
    local l_ActivePetStates_1 = v24:YieldUntilData().Table.ActivePetStates;
    for v96, v97 in v29 do
        local v98 = l_ActivePetStates_1[v96];
        if not v98 then
            local v99 = v29[v96];
            if not v99 then
                v99 = {};
                v29[v96] = v99;
            end;
            local l_v99_0 = v99;
            if l_v99_0 then
                for v101 in l_v99_0 do
                    v89(v96, v101);
                end;
            end;
            v29[v96] = nil;
        else
            for v102 in v97 do
                if not v98[v102] then
                    v89(v96, v102);
                end;
            end;
        end;
    end;
    for v103, v104 in l_ActivePetStates_1 do
        for v105 in v104 do
            v81(v103, v105);
        end;
    end;
end;
local _ = workspace.Baseplate;
local function _(v108, v109, v110, v111) --[[ Line: 270 ]] --[[ Name: _ ]]
    local v112 = (v109 - v108).Magnitude / v111;
    local v113 = os.clock() - v110;
    if v112 <= v113 then
        return v109;
    else
        return v108:Lerp(v109, v113 / v112);
    end;
end;
local v115 = {};
local v116 = {};
local v117 = 0;
local function v166(v118) --[[ Line: 282 ]] --[[ Name: v166 ]]
    -- upvalues: v117 (ref), v116 (copy), v115 (copy), v24 (copy), v29 (copy), l_PetList_0 (copy), v11 (copy), v6 (copy), v13 (copy), v18 (copy), v19 (copy)
    v117 = 0;
    table.clear(v116);
    table.clear(v115);
    local l_ActivePetStates_2 = v24:YieldUntilData().Table.ActivePetStates;
    for v120, v121 in v29 do
        local v122 = l_ActivePetStates_2[v120];
        if v122 then
            for v123, v124 in v121 do
                local v125 = v122[v123];
                if v125 then
                    local l_Asset_1 = v124.Asset;
                    local l_CurrentCFrame_0 = v125.CurrentCFrame;
                    local l_Magnitude_0 = (l_CurrentCFrame_0.Position - l_Asset_1.Position).Magnitude;
                    local l_IsNotFirstTime_0 = v124.IsNotFirstTime;
                    if l_Magnitude_0 >= 3 or l_IsNotFirstTime_0 then
                        v124.IsNotFirstTime = true;
                        local l_l_Asset_1_FirstChildWhichIsA_0 = l_Asset_1:FindFirstChildWhichIsA("Model", true);
                        local v131 = v24:YieldUntilData().Table.PlayerPetData[v120];
                        if v131 then
                            local v132 = v131.PetInventory.Data[v123];
                            local v133 = l_l_Asset_1_FirstChildWhichIsA_0 and l_l_Asset_1_FirstChildWhichIsA_0.PrimaryPart;
                            local v134 = v133 and v133.Size;
                            if not v132 then
                                return;
                            else
                                local v135 = l_PetList_0[v132.PetType];
                                local l_MovementSpeed_0 = v125.MovementSpeed;
                                local l_MovementType_0 = v135.MovementType;
                                local l_BaseWeight_1 = v132.PetData.BaseWeight;
                                local v139 = math.clamp(l_MovementSpeed_0 * v118 / l_Magnitude_0, 0, 1);
                                local v140 = l_Asset_1.Position:Lerp(l_CurrentCFrame_0.Position, v139);
                                local l_LastScale_0 = v124.LastScale;
                                local v142 = v11:CalculateWeight(v132.PetData.BaseWeight or 1, v132.PetData.Level);
                                local v143 = l_BaseWeight_1 + v135.ModelScalePerLevel * v142;
                                if l_LastScale_0 ~= v143 then
                                    l_l_Asset_1_FirstChildWhichIsA_0:ScaleTo((math.max(0.01, v143 * 1)));
                                    v124.LastScale = v143;
                                end;
                                local v144 = v6(l_Asset_1.Position + Vector3.new(0, 2, 0, 0), l_Asset_1.Position - Vector3.new(0, 2, 0, 0), v13);
                                local v145 = v144 and v144.Position.Y or 0;
                                local v146 = math.lerp(v124.LastYHeight or v145, v145, 5 * v118);
                                if not v124 then
                                    return;
                                else
                                    v124.LastYHeight = v146;
                                    local v147 = (v135.YHeightScaler or 0) * v143;
                                    local v148 = if l_MovementType_0 == "Grounded" then CFrame.new(v140.X, (v146 or 0) + v147 + v134.Y / 2, v140.Z) else CFrame.new(v140);
                                    local l_Position_0 = v133.Position;
                                    local l_Position_1 = l_CurrentCFrame_0.Position;
                                    local v151 = false;
                                    if l_MovementType_0 == "Grounded" then
                                        v151 = (Vector2.new(l_Position_0.X, l_Position_0.Z) - Vector2.new(l_Position_1.X, l_Position_1.Z)).Magnitude <= 2.5;
                                    end;
                                    local v152 = false;
                                    if l_MovementType_0 == "Flight" then
                                        v152 = (l_Position_0 - l_Position_1).Magnitude <= 1;
                                    end;
                                    local v153 = v152 or v151;
                                    local v154 = v125.CustomAnimationState or v153 and "Idle" or "Walk";
                                    if not v124.LastAnimationState or v124.LastAnimationState ~= v154 then
                                        if v18 == "PC" and v124.PetSoundHandler then
                                            v124.PetSoundHandler:playSound(v154);
                                        end;
                                        v124.PetVFXHandler:playVFX(v154);
                                        v124.LastAnimationState = v154;
                                    end;
                                    local v155 = v124.LoadedAnimations[v154];
                                    local l_CurrentAnimation_1 = v124.CurrentAnimation;
                                    if l_CurrentAnimation_1 ~= v155 and v155 then
                                        if l_CurrentAnimation_1 then
                                            local v157 = v19[l_CurrentAnimation_1.Name];
                                            local v158 = v157 and v157.AnimationEnded;
                                            if v158 then
                                                v158(v123);
                                            end;
                                            l_CurrentAnimation_1:Stop();
                                        end;
                                        v124.CurrentAnimation = v155;
                                        if v155 then
                                            local v159 = v19[v155.Name];
                                            local v160 = v159 and v159.AnimationStarted;
                                            if v160 then
                                                v160(v123);
                                            end;
                                            v155:Play();
                                        end;
                                    end;
                                    if v124.LastTargetCFrame ~= l_CurrentCFrame_0 or not v124.LastAngles then
                                        local v161, v162, v163 = (l_MovementType_0 == "Grounded" and v11:GetLookAt(l_Asset_1.Position, l_CurrentCFrame_0.Position) or CFrame.new(l_Asset_1.Position, l_CurrentCFrame_0.Position)):ToEulerAnglesXYZ();
                                        if v161 ~= v161 or v162 ~= v162 or v163 ~= v163 then
                                            v161 = 0;
                                            v162 = 0;
                                            v163 = 0;
                                        end;
                                        local v164 = CFrame.Angles(v161, v162, v163);
                                        local v165 = (v124.LastAngles or v164):Lerp(v164, 6 * v118);
                                        v117 = v117 + 1;
                                        v115[v117] = l_Asset_1;
                                        v116[v117] = v148 * v165;
                                        v124.LastAngles = v165;
                                    else
                                        v117 = v117 + 1;
                                        v115[v117] = l_Asset_1;
                                        v116[v117] = v148 * v124.LastAngles;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    workspace:BulkMoveTo(v115, v116, Enum.BulkMoveMode.FireCFrameChanged);
end;
task.spawn(function() --[[ Line: 400 ]]
    -- upvalues: v18 (copy), v166 (copy)
    while true do
        local v167 = task.wait(v18 == "Mobile" and 0.025 or 0.015);
        task.spawn(function() --[[ Line: 404 ]]
            -- upvalues: v166 (ref), v167 (copy)
            v166(v167);
        end);
    end;
end);
v28.GetServerState = function(_, v169, v170) --[[ Line: 410 ]]
    -- upvalues: v24 (copy)
    local v171 = v24:YieldUntilData().Table.ActivePetStates[v169];
    if not v171 then
        return;
    else
        return v171[v170];
    end;
end;
v28.GetPlayerDatastorePetData = function(_, v173) --[[ Line: 419 ]]
    -- upvalues: v24 (copy)
    local v174 = v24:YieldUntilData().Table.PlayerPetData[v173];
    if not v174 then
        return;
    else
        return v174;
    end;
end;
v28.GetPetData = function(_, v176, v177) --[[ Line: 428 ]]
    -- upvalues: v24 (copy)
    local v178 = v24:YieldUntilData().Table.PlayerPetData[v176];
    if not v178 then
        return;
    else
        return v178.PetInventory.Data[v177];
    end;
end;
v28.GetPetDataFromPetObject = function(_, v180) --[[ Line: 437 ]]
    -- upvalues: v28 (copy)
    if not v180 then
        return;
    else
        local l_v180_Attribute_0 = v180:GetAttribute("OWNER");
        local l_v180_Attribute_1 = v180:GetAttribute("UUID");
        return v28:GetPetData(l_v180_Attribute_0, l_v180_Attribute_1);
    end;
end;
v28.SetPetState = function(_, v184, v185, v186) --[[ Line: 447 ]]
    -- upvalues: l_ActivePetService_0 (copy)
    l_ActivePetService_0:FireServer("SetPetState", v184, v185, v186);
end;
v28.GetClientPetState = function(_, v188) --[[ Line: 451 ]]
    -- upvalues: v29 (copy)
    local v189 = v29[v188];
    if not v189 then
        v189 = {};
        v29[v188] = v189;
    end;
    return v189;
end;
v28.GetClientPetStateUUID = function(_, v191, v192) --[[ Line: 460 ]]
    -- upvalues: v28 (copy)
    local l_v28_ClientPetState_0 = v28:GetClientPetState(v191);
    if not Player then
        return;
    else
        return l_v28_ClientPetState_0[v192];
    end;
end;
v28.Feed = function(_, v195) --[[ Line: 469 ]]
    -- upvalues: l_ActivePetService_0 (copy)
    l_ActivePetService_0:FireServer("Feed", v195);
end;
task.delay(2, function() --[[ Line: 473 ]]
    -- upvalues: v106 (copy), v24 (copy)
    v106();
    v24:GetPathSignal("ActivePetStates/@"):Connect(function(...) --[[ Line: 476 ]]
        -- upvalues: v106 (ref)
        v106();
    end);
end);
v106();
task.spawn(function() --[[ Line: 482 ]]
    -- upvalues: v106 (copy)
    while true do
        task.wait(2);
        v106();
    end;
end);
return v28;