-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEggRenderer, time of decompilation: Wed Jun  4 21:32:01 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerScriptService");
local _ = game:GetService("ServerScriptService");
local _ = game:GetService("RunService");
local _ = l_ReplicatedStorage_0.Assets.SFX;
local _ = l_ReplicatedStorage_0.Assets.VFX;
local v6 = {};
local _ = require(l_ReplicatedStorage_0.Modules.TweenModel);
local v8 = require(l_ReplicatedStorage_0.Modules.CreateTagHandler);
local l_Assets_0 = l_ReplicatedStorage_0:WaitForChild("Assets");
local l_EggModels_0 = l_Assets_0:WaitForChild("Models"):WaitForChild("EggModels");
local v11 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local _ = v11.PetList;
local _ = l_Assets_0.SFX;
local _ = l_Assets_0.VFX;
local _ = game:GetService("TweenService");
local l_PetEggService_0 = l_ReplicatedStorage_0.GameEvents.PetEggService;
local l_PetSkipped_0 = l_ReplicatedStorage_0.GameEvents.PetSkipped;
local l_EggReadyToHatch_RE_0 = l_ReplicatedStorage_0.GameEvents.EggReadyToHatch_RE;
local v19 = {};
local v20 = {};
local v21 = {};
for _, v23 in script.EggEffects:GetChildren() do
    v20[v23.Name] = require(v23);
end;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local function _(v25) --[[ Line: 29 ]] --[[ Name: _ ]]
    local v26 = v25:Clone();
    v26.Parent = workspace;
    v26:Play();
    v26.Ended:Once(function() --[[ Line: 33 ]]
        -- upvalues: v26 (copy)
        v26:Destroy();
    end);
end;
local function v35(v28, v29) --[[ Line: 38 ]] --[[ Name: v35 ]]
    -- upvalues: v19 (copy), v21 (copy), v20 (copy)
    if not v28 then
        warn("DoHatchAnim | No server egg!");
        return;
    else
        local v30 = v19[v28];
        if not v30 then
            warn("DoHatchAnim | No state data for server egg");
            return;
        else
            local l_Asset_0 = v30.Asset;
            if not l_Asset_0 then
                warn("DoHatchAnim | No asset!");
                return;
            else
                local l_v28_Attribute_0 = v28:GetAttribute("OBJECT_UUID");
                if not l_v28_Attribute_0 then
                    return warn("DoHatchAnim | No egg uuid!");
                elseif l_Asset_0:GetAttribute("DoingHatch") then
                    return;
                else
                    l_Asset_0:SetAttribute("DoingHatch", true);
                    l_Asset_0.Parent = workspace.Visuals;
                    local v33 = v21[l_v28_Attribute_0];
                    local l_v28_Attribute_1 = v28:GetAttribute("EggName");
                    if v20[l_v28_Attribute_1] then
                        v20[l_v28_Attribute_1](l_Asset_0, v33, v29);
                        return;
                    elseif l_v28_Attribute_1 == "Rare Egg" or l_v28_Attribute_1 == "Legendary Egg" or l_v28_Attribute_1 == "Mythical Egg" then
                        v20.Rare(l_Asset_0, v33, v29);
                        return;
                    else
                        v20.Normal(l_Asset_0, v33, v29);
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
local function v41(v36, v37) --[[ Line: 79 ]] --[[ Name: v41 ]]
    -- upvalues: v19 (copy), v35 (copy)
    if not v36 then
        warn("ActivateEgg | No server egg!");
        return;
    else
        local v38 = v19[v36];
        if not v38 then
            warn("ActivateEgg | No state data for server egg");
            return;
        else
            local l_Asset_1 = v38.Asset;
            if not l_Asset_1 then
                warn("ActivateEgg | No asset!");
                return;
            else
                local l_ProximityPrompt_0 = l_Asset_1:FindFirstChild("ProximityPrompt");
                if not l_ProximityPrompt_0 then
                    return warn((("PetEggRender:RenderEgg | No Proximity Prompt found for %*"):format(l_Asset_1)));
                else
                    l_ProximityPrompt_0:Destroy();
                    v35(v36, v37);
                    return;
                end;
            end;
        end;
    end;
end;
local function v48(v42) --[[ Line: 107 ]] --[[ Name: v48 ]]
    -- upvalues: l_LocalPlayer_0 (copy), v19 (copy)
    if v42:GetAttribute("OWNER") ~= l_LocalPlayer_0.Name then
        return;
    else
        local l_v42_Attribute_0 = v42:GetAttribute("TimeToHatch");
        local v44 = v19[v42];
        if not v44 then
            warn("CheckEggTimer | No state data for server egg");
            return;
        else
            local l_Asset_2 = v44.Asset;
            if not l_Asset_2 then
                warn("CheckEggTimer | No asset!");
                return;
            else
                local l_ProximityPrompt_1 = l_Asset_2:FindFirstChild("ProximityPrompt");
                local l_SkipPrompt_0 = l_Asset_2:FindFirstChild("SkipPrompt");
                if not l_ProximityPrompt_1 then
                    return warn((("CheckEggTimer | No Proximity Prompt found for %*"):format(l_Asset_2)));
                elseif not l_SkipPrompt_0 then
                    return warn((("CheckEggTimer | No Skip Prompt found for %*"):format(l_Asset_2)));
                elseif l_v42_Attribute_0 <= 0 then
                    l_ProximityPrompt_1.Enabled = true;
                    l_SkipPrompt_0.Enabled = false;
                    return;
                else
                    l_ProximityPrompt_1.Enabled = false;
                    l_SkipPrompt_0.Enabled = true;
                    return;
                end;
            end;
        end;
    end;
end;
v6.RenderEgg = function(_, v50) --[[ Line: 142 ]]
    -- upvalues: l_EggModels_0 (copy), v11 (copy), v48 (copy), v19 (copy), l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy), l_PetEggService_0 (copy)
    if not v50:GetAttribute("READY") then
        v50:GetAttributeChangedSignal("READY"):Wait();
    end;
    local l_v50_Attribute_0 = v50:GetAttribute("EggName");
    local v52 = 0;
    if not l_v50_Attribute_0 then
        repeat
            task.wait(0.5);
            l_v50_Attribute_0 = v50:GetAttribute("EggName");
            print("tryting to eggname for", v50:GetFullName(), l_v50_Attribute_0);
            v52 = v52 + 1;
        until v52 >= 5 or l_v50_Attribute_0;
    end;
    if not l_v50_Attribute_0 then
        return;
    else
        local l_l_EggModels_0_FirstChild_0 = l_EggModels_0:FindFirstChild(l_v50_Attribute_0);
        if not l_l_EggModels_0_FirstChild_0 then
            return warn((("Could not find egg model associated with %*"):format(l_v50_Attribute_0)));
        else
            local v54 = l_l_EggModels_0_FirstChild_0:Clone();
            v54.PrimaryPart.Anchored = true;
            local l_HatchTime_0 = v11.PetEggs[l_v50_Attribute_0].HatchTime;
            local _ = {};
            v54:ScaleTo((math.clamp(1 - 0.5 * (v50:GetAttribute("TimeToHatch") / l_HatchTime_0), 0.2, 1)));
            workspace.Terrain.EggParticle.WorldCFrame = v50:GetPivot();
            for _, v58 in workspace.Terrain.EggParticle:GetDescendants() do
                v58:Emit(v58:GetAttribute("EmitCount"));
            end;
            local v59 = Vector3.new(0, 1.5, 0, 0);
            local v60 = 0;
            task.spawn(function() --[[ Line: 175 ]]
                -- upvalues: v60 (ref), v59 (ref), v54 (copy), v50 (copy)
                while v60 < 0.25 do
                    v60 = v60 + game:GetService("RunService").Heartbeat:Wait();
                    local l_Value_0 = game.TweenService:GetValue(v60 / 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                    v59 = Vector3.new(0, 3, 0, 0):Lerp(Vector3.new(0, 0, 0, 0), l_Value_0);
                    local l_Y_0 = v54:GetExtentsSize().Y;
                    v54:PivotTo(v50:GetPivot() * CFrame.new(0, v59.Y + l_Y_0 * 0.5, 0));
                end;
            end);
            v50:GetAttributeChangedSignal("TimeToHatch"):Connect(function() --[[ Line: 185 ]]
                -- upvalues: v54 (copy), v50 (copy), l_HatchTime_0 (copy), v59 (ref), v48 (ref)
                v54:ScaleTo((math.clamp(1 - 0.5 * (v50:GetAttribute("TimeToHatch") / l_HatchTime_0), 0.2, 1)));
                local l_Y_1 = v54:GetExtentsSize().Y;
                v54:PivotTo(v50:GetPivot() * CFrame.new(0, v59.Y + l_Y_1 * 0.5, 0));
                v48(v50);
            end);
            v19[v50] = {
                Asset = v54
            };
            local l_Y_2 = v54:GetExtentsSize().Y;
            v54:PivotTo(v50:GetPivot() * CFrame.new(0, v59.Y + l_Y_2 * 0.4, 0));
            v54.Parent = v50;
            if v50:GetAttribute("OWNER") ~= l_LocalPlayer_0.Name then
                return;
            else
                local v65 = l_ReplicatedStorage_0.ProximityPrompt:Clone();
                if not v65 then
                    return warn("PetEggRender:RenderEgg | No Proximity Prompt found in ReplicatedStorage!");
                else
                    v65.Parent = v54;
                    v65.ActionText = "Hatch!";
                    v65.HoldDuration = 1;
                    v65.Enabled = false;
                    v65.Triggered:Connect(function() --[[ Line: 209 ]]
                        -- upvalues: l_PetEggService_0 (ref), v50 (copy)
                        l_PetEggService_0:FireServer("HatchPet", v50);
                    end);
                    local v66 = l_ReplicatedStorage_0.ProximityPrompt:Clone();
                    if not v66 then
                        return warn("PetEggRender:RenderEgg | No Proximity Prompt found in ReplicatedStorage!");
                    else
                        v66.Parent = v54;
                        v66.ActionText = "Skip Growth";
                        v66.Name = "SkipPrompt";
                        v66.HoldDuration = 1;
                        v66.Enabled = false;
                        v66.Triggered:Connect(function() --[[ Line: 222 ]]
                            -- upvalues: l_PetEggService_0 (ref), v50 (copy)
                            l_PetEggService_0:FireServer("AuthorisePurchase", v50);
                        end);
                        v48(v50);
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
v6.DerenderEgg = function(_, v68) --[[ Line: 234 ]]
    -- upvalues: v19 (copy)
    if not v68 then
        warn("PetEggRender:DerenderEgg | No server egg to derender");
        return;
    else
        local v69 = v19[v68];
        if not v69 then
            warn("PetEggRender:DerenderEgg | No state data for server egg");
            return;
        else
            local l_Asset_3 = v69.Asset;
            if not l_Asset_3 then
                warn("PetEggRender:DerenderEgg | No asset to derender");
                return;
            else
                if not l_Asset_3:GetAttribute("DoingHatch") then
                    l_Asset_3:Destroy();
                end;
                return;
            end;
        end;
    end;
end;
v8({
    Tag = "PetEggServer", 
    OnInstanceAdded = function(v71) --[[ Line: 260 ]] --[[ Name: OnInstanceAdded ]]
        -- upvalues: v6 (copy)
        if not v71:IsDescendantOf(workspace) then
            return;
        else
            v6:RenderEgg(v71);
            return;
        end;
    end, 
    OnInstanceRemoved = function(v72) --[[ Line: 269 ]] --[[ Name: OnInstanceRemoved ]]
        -- upvalues: v6 (copy)
        v6:DerenderEgg(v72);
    end
});
l_EggReadyToHatch_RE_0.OnClientEvent:Connect(function(v73, v74) --[[ Line: 274 ]]
    -- upvalues: v21 (copy)
    v21[v74] = v73;
end);
l_PetEggService_0.OnClientEvent:Connect(function(v75, v76) --[[ Line: 278 ]]
    -- upvalues: v41 (copy)
    v41(v75, v76);
end);
local v77 = require(script.SkipEgg);
l_PetSkipped_0.OnClientEvent:Connect(function(v78) --[[ Line: 283 ]]
    -- upvalues: v77 (copy)
    v77(v78);
end);
return v6;