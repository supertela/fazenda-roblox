-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEggTutorialController, time of decompilation: Wed Jun  4 21:31:56 2025 ]]
local _ = game:GetService("ServerScriptService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v6 = require(l_ReplicatedStorage_0.Modules.DataService);
local v7 = require(l_ReplicatedStorage_0.Modules.TutorialController.TutorialUtils);
local v8 = require(l_ReplicatedStorage_0.Modules.InventoryService);
local v9 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v10 = require(l_ReplicatedStorage_0.Modules.PetServices.PetCardUserInterfaceService);
local v11 = require(l_ReplicatedStorage_0.Modules.PetServices.PetActionUserInterfaceService);
local _ = require(l_ReplicatedStorage_0.Modules.ActivePetsUIController);
local v13 = require(l_ReplicatedStorage_0.Modules.Notification);
local v14 = require(l_ReplicatedStorage_0.Arrow_Module);
local v15 = require(l_ReplicatedStorage_0.Modules.FastTween);
local v16 = require(l_ReplicatedStorage_0.Modules.GetFarmAsync);
local v17 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v18 = require(l_ReplicatedStorage_0.Data.PetEggData);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v127 = {
    Run = function(_) --[[ Line: 26 ]] --[[ Name: Run ]]
        -- upvalues: l_LocalPlayer_0 (copy), v16 (copy), v6 (copy), l_RunService_0 (copy), v14 (copy), l_CollectionService_0 (copy), v8 (copy), v17 (copy), v18 (copy), v13 (copy), v7 (copy), l_ReplicatedStorage_0 (copy), v9 (copy), l_PlayerGui_0 (copy), v15 (copy), l_CurrentCamera_0 (copy), v11 (copy), v10 (copy), l_SoundService_0 (copy)
        if not l_LocalPlayer_0.Character then
            l_LocalPlayer_0.CharacterAdded:Wait();
        end;
        local v23 = v16(l_LocalPlayer_0);
        if not v23 then
            warn("PetEggTutorialController:Run || Failed to execute tutorial because player has no farm");
            return;
        else
            local l_v6_Data_0 = v6:GetData();
            if not l_v6_Data_0 then
                warn("PetEggTutorialController:Run || Failed to execute tutorial because player data is missing");
                return;
            elseif not workspace.NPCS:WaitForChild("Pet Stand", 10) then
                warn("PetEggTutorialController:Run || Failed to execute tutorial because Pet Stand is missing");
                return;
            elseif not l_RunService_0:IsStudio() then
                return;
            else
                local function _(v25) --[[ Line: 46 ]] --[[ Name: _ ]]
                    -- upvalues: v14 (ref), l_LocalPlayer_0 (ref)
                    local v26 = v14.GenerateArrow(l_LocalPlayer_0, v25, math.random(1, 1000000));
                    return function() --[[ Line: 49 ]]
                        -- upvalues: v14 (ref), v26 (copy)
                        v14.Remove_Arrow(v26);
                    end;
                end;
                local function v35() --[[ Line: 54 ]] --[[ Name: v35 ]]
                    -- upvalues: v23 (copy), l_CollectionService_0 (ref)
                    local v28 = nil;
                    for _, v30 in v23.Important.Plant_Locations:GetChildren() do
                        if v30:IsA("BasePart") then
                            local v31 = Random.new();
                            local v32 = 15;
                            while v32 > 0 do
                                local v33 = v30.Position + v31:NextUnitVector() * Vector3.new(v30.Size.X, 0, v30.Size.Z) * 0.5 * 0.7;
                                local v34 = OverlapParams.new();
                                v34.FilterDescendantsInstances = l_CollectionService_0:GetTagged("Harvestable");
                                v34.FilterType = Enum.RaycastFilterType.Include;
                                v34.MaxParts = 1;
                                if #workspace:GetPartBoundsInRadius(v33, 10, v34) == 0 then
                                    v28 = v33;
                                    break;
                                else
                                    v32 = v32 - 1;
                                end;
                            end;
                            if v28 then
                                break;
                            end;
                        end;
                    end;
                end;
                local function _() --[[ Line: 80 ]] --[[ Name: _ ]]
                    -- upvalues: v8 (ref)
                    local v37 = v8:Find("PetEgg", function(v36) --[[ Line: 82 ]]
                        return v36.EggName == "Common Egg";
                    end);
                    if type(v37) ~= "table" then
                        return false;
                    else
                        return next(v37) ~= nil;
                    end;
                end;
                local function v41() --[[ Line: 91 ]] --[[ Name: v41 ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    for _, v40 in l_v6_Data_0.SavedObjects do
                        if type(v40) == "table" and v40.ObjectType == "PetEgg" and type(v40.Data) == "table" and v40.Data.EggName == "Common Egg" then
                            return true;
                        end;
                    end;
                    return false;
                end;
                local function _() --[[ Line: 100 ]] --[[ Name: v42 ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    return next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil;
                end;
                local _ = function() --[[ Line: 104 ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    local _, v44 = next(l_v6_Data_0.PetsData.EquippedPets);
                    return v44;
                end;
                local function _() --[[ Line: 109 ]] --[[ Name: v46 ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    return next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local v47 = false;
                local v48 = false;
                local function _() --[[ Line: 115 ]] --[[ Name: _ ]]
                    -- upvalues: v47 (ref)
                    return not v47;
                end;
                local function _() --[[ Line: 119 ]] --[[ Name: v50 ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    return next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local function _() --[[ Line: 123 ]] --[[ Name: _ ]]
                    -- upvalues: l_v6_Data_0 (copy)
                    local v51 = true;
                    if next(l_v6_Data_0.PetsData.PetInventory.Data) == nil then
                        v51 = next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                    end;
                    return v51;
                end;
                local function _() --[[ Line: 127 ]] --[[ Name: _ ]]
                    -- upvalues: v41 (copy), l_v6_Data_0 (copy)
                    return v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local function _() --[[ Line: 131 ]] --[[ Name: _ ]]
                    -- upvalues: v41 (copy), l_v6_Data_0 (copy)
                    return v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local function _() --[[ Line: 135 ]] --[[ Name: _ ]]
                    -- upvalues: v8 (ref), v41 (copy), l_v6_Data_0 (copy)
                    local v56 = v8:Find("PetEgg", function(v55) --[[ Line: 137 ]]
                        return v55.EggName == "Common Egg";
                    end);
                    return type(v56) == "table" and next(v56) ~= nil or v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local function _() --[[ Line: 142 ]] --[[ Name: _ ]]
                    -- upvalues: v8 (ref), v41 (copy), l_v6_Data_0 (copy)
                    local v59 = v8:Find("PetEgg", function(v58) --[[ Line: 144 ]]
                        return v58.EggName == "Common Egg";
                    end);
                    return type(v59) == "table" and next(v59) ~= nil or v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil;
                end;
                local function v67() --[[ Line: 149 ]] --[[ Name: v66 ]]
                    -- upvalues: v8 (ref), v41 (copy), l_v6_Data_0 (copy), v17 (ref), v18 (ref)
                    local v62 = v8:Find("PetEgg", function(v61) --[[ Line: 151 ]]
                        return v61.EggName == "Common Egg";
                    end);
                    if type(v62) == "table" and next(v62) ~= nil or v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        local v63 = false;
                        for _, v65 in l_v6_Data_0.PetEggStock.Stocks do
                            if v65.EggName == "Common Egg" and v65.Stock > 0 then
                                v63 = true;
                                break;
                            end;
                        end;
                        if not v17.PetEggs["Common Egg"] then
                            return false;
                        else
                            local v66 = v18["Common Egg"];
                            if not v66 then
                                return false;
                            elseif not v63 or l_v6_Data_0.Sheckles < v66.Price * 1.03 then
                                return false;
                            else
                                return true;
                            end;
                        end;
                    end;
                end;
                local function v74() --[[ Line: 178 ]] --[[ Name: v73 ]]
                    -- upvalues: v67 (copy), v6 (ref)
                    while not v67() do
                        local v68 = coroutine.running();
                        local v69 = false;
                        do
                            local l_v69_0 = v69;
                            local function v71() --[[ Line: 185 ]] --[[ Name: v70 ]]
                                -- upvalues: l_v69_0 (ref), v68 (copy)
                                l_v69_0 = true;
                                if coroutine.status(v68) == "suspended" then
                                    task.spawn(v68);
                                end;
                            end;
                            local v72 = assert(v6:GetPathSignal("Sheckles")):Connect(v71);
                            local v73 = assert(v6:GetPathSignal("PetEggStock/@")):Connect(v71);
                            if not l_v69_0 then
                                coroutine.yield();
                            end;
                            v72:Disconnect();
                            v73:Disconnect();
                        end;
                    end;
                    return true;
                end;
                local function v79() --[[ Line: 203 ]] --[[ Name: v78 ]]
                    -- upvalues: v8 (ref), v41 (copy), l_v6_Data_0 (copy), v14 (ref), l_LocalPlayer_0 (ref), v67 (copy)
                    local v76 = v8:Find("PetEgg", function(v75) --[[ Line: 205 ]]
                        return v75.EggName == "Common Egg";
                    end);
                    if type(v76) == "table" and next(v76) ~= nil or v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        local l_Position_0 = workspace.Tutorial_Points.Tutorial_Point_4.Position;
                        local v78 = v14.GenerateArrow(l_LocalPlayer_0, l_Position_0, math.random(1, 1000000));
                        v76 = function() --[[ Line: 213 ]]
                            -- upvalues: v14 (ref), v78 (copy)
                            v14.Remove_Arrow(v78);
                        end;
                        while (not l_LocalPlayer_0.Character or l_LocalPlayer_0:DistanceFromCharacter(l_Position_0) > 8) and v67() do
                            task.wait(0.25);
                        end;
                        v76();
                        return (v67());
                    end;
                end;
                local function _() --[[ Line: 224 ]] --[[ Name: _ ]]
                    -- upvalues: v41 (copy), l_v6_Data_0 (copy), v13 (ref)
                    if v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        v13:CreateNotification("Buy a Common Egg!");
                        return true;
                    end;
                end;
                local v81 = nil;
                local function v89() --[[ Line: 234 ]] --[[ Name: v87 ]]
                    -- upvalues: v41 (copy), l_v6_Data_0 (copy), v8 (ref), v6 (ref), v23 (copy), v7 (ref), v13 (ref), v14 (ref), l_LocalPlayer_0 (ref), v81 (ref), v35 (copy), l_ReplicatedStorage_0 (ref), v48 (ref)
                    if v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        while true do
                            local v83 = v8:Find("PetEgg", function(v82) --[[ Line: 240 ]]
                                return v82.EggName == "Common Egg";
                            end);
                            if type(v83) ~= "table" or next(v83) == nil then
                                assert(v6:GetPathSignal("InventoryData/@")):Wait();
                            else
                                break;
                            end;
                        end;
                        local l_Position_1 = v23.Spawn_Point.CFrame.Position;
                        if v7.getDistanceTo(l_Position_1) > 10 then
                            v13:CreateNotification("Go back to your farm");
                            local v85 = v14.GenerateArrow(l_LocalPlayer_0, l_Position_1, math.random(1, 1000000));
                            local l_v85_0 = v85 --[[ copy: 1 -> 3 ]];
                            local function _() --[[ Line: 253 ]] --[[ Name: v85 ]]
                                -- upvalues: v14 (ref), l_v85_0 (copy)
                                v14.Remove_Arrow(l_v85_0);
                            end;
                            v7.waitUntilDistance(l_Position_1, 10);
                            v14.Remove_Arrow(v85);
                        end;
                        v13:CreateNotification("Equip the egg and place it in your Farm");
                        if not v81 then
                            v81 = v35();
                        end;
                        local v88 = l_ReplicatedStorage_0.Tutorial_Parts.Tutorial_Click:Clone();
                        v88.Size = Vector3.new(0.0010000000474974513, 0.0010000000474974513, 0.0010000000474974513, 0);
                        v88.Position = v81 or (v23.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
                        v88.Parent = workspace.Click_Points;
                        while not v41() do
                            assert(v6:GetPathSignal("SavedObjects/@")):Wait();
                        end;
                        v48 = true;
                        v88:Destroy();
                        return true;
                    end;
                end;
                local function v103() --[[ Line: 276 ]] --[[ Name: v101 ]]
                    -- upvalues: l_v6_Data_0 (copy), v48 (ref), v13 (ref), l_CollectionService_0 (ref), l_LocalPlayer_0 (ref), v7 (ref), v14 (ref), v6 (ref)
                    if next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        local function v93() --[[ Line: 281 ]] --[[ Name: v91 ]]
                            -- upvalues: l_v6_Data_0 (ref)
                            local v90 = 1e999;
                            for _, v92 in l_v6_Data_0.SavedObjects do
                                if type(v92) == "table" and v92.ObjectType == "PetEgg" and type(v92.Data) == "table" and v92.Data.EggName == "Common Egg" and type(v92.Data.TimeToHatch) == "number" then
                                    v90 = math.min(v90, v92.Data.TimeToHatch);
                                end;
                            end;
                            return v90;
                        end;
                        local v94 = v93();
                        local _ = v94 <= 0;
                        if v94 > 0 and v48 then
                            v13:CreateNotification("Wait until your egg is ready");
                        end;
                        while v93() > 0 and next(l_v6_Data_0.PetsData.PetInventory.Data) == nil do
                            task.wait(1);
                        end;
                        v13:CreateNotification("Your egg is ready to hatch!");
                        local function v98() --[[ Line: 300 ]] --[[ Name: v96 ]]
                            -- upvalues: l_CollectionService_0 (ref), l_LocalPlayer_0 (ref)
                            for _, v97 in l_CollectionService_0:GetTagged("PetEggServer") do
                                if v97:GetAttribute("OWNER") == l_LocalPlayer_0.Name and v97:GetAttribute("EggName") == "Common Egg" and v97:GetAttribute("READY") then
                                    return v97;
                                end;
                            end;
                            return nil;
                        end;
                        local v99 = if next(l_v6_Data_0.PetsData.PetInventory.Data) == nil then v98() else nil;
                        local v100 = if v99 then v99:GetPivot().Position else nil;
                        if v99 ~= nil and v100 ~= nil then
                            if v7.getDistanceTo(v100) > 7 then
                                local v101 = v14.GenerateArrow(l_LocalPlayer_0, v100, math.random(1, 1000000));
                                local function _() --[[ Line: 314 ]] --[[ Name: v100 ]]
                                    -- upvalues: v14 (ref), v101 (copy)
                                    v14.Remove_Arrow(v101);
                                end;
                                v7.waitUntilDistance(v100, 7);
                                v14.Remove_Arrow(v101);
                            end;
                            v13:CreateNotification("Hatch the egg!");
                        end;
                        while next(l_v6_Data_0.PetsData.PetInventory.Data) == nil do
                            assert(v6:GetPathSignal("PetsData/PetInventory/@")):Wait();
                        end;
                        task.wait(0.5);
                        while workspace.Visuals:FindFirstChild("Common Egg") or workspace.Visuals:FindFirstChild("EggExplode") do
                            task.wait();
                        end;
                        task.wait(0.5);
                        return true;
                    end;
                end;
                local function v106() --[[ Line: 334 ]] --[[ Name: v104 ]]
                    -- upvalues: l_v6_Data_0 (copy), l_LocalPlayer_0 (ref), v13 (ref), l_ReplicatedStorage_0 (ref), v81 (ref), v23 (copy), v6 (ref), v47 (ref)
                    if next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                        return true;
                    else
                        local l_Tool_0 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Tool");
                        if l_Tool_0 and l_Tool_0:GetAttribute("ItemType") == "Pet" then
                            v13:CreateNotification("Now with your pet in hands, tap on your Farm");
                        else
                            v13:CreateNotification("Now equip your pet and tap on your Farm");
                        end;
                        local v105 = l_ReplicatedStorage_0.Tutorial_Parts.Tutorial_Click:Clone();
                        v105.Size = Vector3.new(0.0010000000474974513, 0.0010000000474974513, 0.0010000000474974513, 0);
                        v105.Position = v81 or (v23.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
                        v105.Parent = workspace.Click_Points;
                        while next(l_v6_Data_0.PetsData.EquippedPets) == nil do
                            assert(v6:GetPathSignal("PetsData/EquippedPets/@")):Wait();
                        end;
                        v47 = true;
                        v105:Destroy();
                        return true;
                    end;
                end;
                local function v125() --[[ Line: 357 ]] --[[ Name: v123 ]]
                    -- upvalues: v47 (ref), l_v6_Data_0 (copy), v9 (ref), l_LocalPlayer_0 (ref), l_PlayerGui_0 (ref), v15 (ref), l_RunService_0 (ref), l_CurrentCamera_0 (ref), v11 (ref), v10 (ref), l_CollectionService_0 (ref), l_SoundService_0 (ref)
                    if not v47 then
                        return true;
                    else
                        local v107, v108 = next(l_v6_Data_0.PetsData.EquippedPets);
                        local l_v108_0 = v108;
                        if not l_v108_0 then
                            return true;
                        else
                            v107 = 15;
                            while not v9:GetClientPetStateUUID(l_LocalPlayer_0.Name, l_v108_0) and v107 > 0 do
                                v107 = v107 - task.wait();
                            end;
                            if v107 <= 0 then
                                return true;
                            else
                                l_PlayerGui_0.PetEggTutorial.Enabled = true;
                                v108 = l_PlayerGui_0.PetEggTutorial.FocusPoint;
                                local v110 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                                local v111 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                                v108.Size = UDim2.fromScale(1.5, 1.5);
                                v15(v108, v111, {
                                    Size = UDim2.fromScale(0.3, 0.3)
                                });
                                v15(v108, v110, {
                                    ImageTransparency = 0.3
                                });
                                v15(v108.UIStroke, v110, {
                                    Transparency = 0.3
                                });
                                local v115 = l_RunService_0.PreRender:Connect(function() --[[ Line: 388 ]]
                                    -- upvalues: v9 (ref), l_LocalPlayer_0 (ref), l_v108_0 (copy), l_CurrentCamera_0 (ref), v108 (ref)
                                    local l_v9_ClientPetStateUUID_0 = v9:GetClientPetStateUUID(l_LocalPlayer_0.Name, l_v108_0);
                                    if l_v9_ClientPetStateUUID_0 and l_v9_ClientPetStateUUID_0.LastUpdatedPosition then
                                        local v113, v114 = l_CurrentCamera_0:WorldToScreenPoint(l_v9_ClientPetStateUUID_0.LastUpdatedPosition);
                                        if not v114 then
                                            v108.Position = UDim2.fromScale(1.5, 1.5);
                                            v108.Visible = false;
                                            return;
                                        else
                                            v108.Position = UDim2.fromOffset(v113.X, v113.Y);
                                            v108.Visible = true;
                                        end;
                                    end;
                                end);
                                v108.Step1.Visible = true;
                                v15(v108.Step1.Label1, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                    TextTransparency = 0
                                });
                                v15(v108.Step1.Label2, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.3), {
                                    TextTransparency = 0
                                });
                                local v116 = 7;
                                while not v11.Active and v116 > 0 do
                                    v116 = v116 - task.wait();
                                end;
                                v15(v108, v110, {
                                    ImageTransparency = 1
                                });
                                v15(v108.UIStroke, v110, {
                                    Transparency = 1
                                });
                                v15(v108.Step1.Label1, v110, {
                                    TextTransparency = 1
                                });
                                v15(v108.Step1.Label2, v110, {
                                    TextTransparency = 1
                                });
                                task.wait(0.5);
                                v108.Step1.Visible = false;
                                v115:Disconnect();
                                while not l_PlayerGui_0.PetUI.Enabled or l_PlayerGui_0.PetUI.PetCard.Main.Position.X.Scale > 1 do
                                    task.wait();
                                end;
                                if not v10.Active then
                                    v10:Toggle(true);
                                end;
                                local l_Toggle_0 = v10.Toggle;
                                v10.Toggle = function() --[[ Line: 436 ]]

                                end;
                                v15(l_PlayerGui_0.PetUI.Background, v110, {
                                    BackgroundTransparency = 0.3
                                });
                                task.wait(0.5);
                                local v118 = {};
                                for _, v120 in l_CollectionService_0:GetTagged("PetTooltip") do
                                    if v120:IsDescendantOf(l_PlayerGui_0.PetUI) then
                                        if v120.Parent.Parent:FindFirstChild("HUNGER_BAR") then
                                            table.insert(v118, 1, v120);
                                        elseif v120.Parent.Parent:FindFirstChild("PET_LEVEL") then
                                            table.insert(v118, 2, v120);
                                        elseif v120.Parent.Parent:FindFirstChild("PET_WEIGHT") then
                                            table.insert(v118, 3, v120);
                                        elseif v120.Parent.Parent:FindFirstChild("PET_ABILITY") then
                                            table.insert(v118, 4, v120);
                                        end;
                                    end;
                                end;
                                for _, v122 in v118 do
                                    l_SoundService_0.Click:Play();
                                    v122:SetAttribute("ForceTooltip", true);
                                    task.wait(3);
                                end;
                                task.wait(3);
                                for _, v124 in v118 do
                                    v124:SetAttribute("ForceTooltip", not v124.Parent.Parent:FindFirstChild("PET_ABILITY") and nil);
                                end;
                                v15(l_PlayerGui_0.PetUI.Background, v110, {
                                    BackgroundTransparency = 1
                                });
                                v10.Toggle = l_Toggle_0;
                                return true;
                            end;
                        end;
                    end;
                end;
                while task.wait() do
                    l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(1);
                    v74();
                    l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(2);
                    if v79() then
                        l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(3);
                        local v126 = nil;
                        if v41() or next(l_v6_Data_0.PetsData.PetInventory.Data) ~= nil or next(l_v6_Data_0.PetsData.EquippedPets) ~= nil then
                            v126 = true;
                        else
                            v13:CreateNotification("Buy a Common Egg!");
                            v126 = true;
                        end;
                        if v126 then
                            l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(4);
                            if v89() then
                                l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(5);
                                if v103() then
                                    l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(6);
                                    if v106() then
                                        l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(7);
                                        if v125() then
                                            l_ReplicatedStorage_0.GameEvents.EggTutorial:FireServer(8);
                                            break;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                return;
            end;
        end;
    end
};
v127.Start = function(_) --[[ Line: 511 ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), v127 (copy)
    l_ReplicatedStorage_0.GameEvents.EggTutorial.OnClientEvent:Connect(function(_) --[[ Line: 513 ]]
        -- upvalues: v127 (ref)
        v127:Run();
    end);
end;
task.spawn(v127.Start, v127);
return v127;