-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Rare, time of decompilation: Wed Jun  4 21:32:02 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.SkinService);
local l_PetList_0 = require(game.ReplicatedStorage.Data.PetRegistry).PetList;
local v3 = {
    ["Black Bunny"] = "rbxassetid://137209605666415", 
    Bunny = "rbxassetid://104391359688443", 
    Caterpillar = "rbxassetid://74906642952986", 
    Deer = "rbxassetid://113898066898530", 
    Cow = "rbxassetid://80626295210133", 
    ["Giant Ant"] = "rbxassetid://110042917722868", 
    Cat = "rbxassetid://74848025639589", 
    Dog = "rbxassetid://88539564087126", 
    ["Golden Lab"] = "rbxassetid://125173635572785", 
    Monkey = "rbxassetid://83148221430148", 
    Pig = "rbxassetid://110554034996387", 
    ["Praying Mantis"] = "rbxassetid://80710971415313", 
    ["Polar Bear"] = "rbxassetid://97880140636687", 
    Snail = "rbxassetid://100791898582300", 
    ["Silver Monkey"] = "rbxassetid://106847532475922", 
    ["Purple Dragonfly"] = "rbxassetid://96794025089185", 
    Turtle = "rbxassetid://93929754369579", 
    ["Orange Tabby"] = "rbxassetid://96707297910956", 
    Poof = "rbxassetid://80584356758887"
};
local function v7(v4) --[[ Line: 27 ]] --[[ Name: v7 ]]
    -- upvalues: v3 (copy)
    local l_Sound_0 = Instance.new("Sound");
    local v6 = v3[v4];
    if not v6 then
        warn((("PetEggRenderer:RenderEgg | No sound found for %*"):format(v4)));
        return;
    else
        l_Sound_0.SoundId = v6;
        l_Sound_0.Parent = workspace;
        l_Sound_0:Play();
        l_Sound_0.Ended:Once(function() --[[ Line: 38 ]]
            -- upvalues: l_Sound_0 (copy)
            l_Sound_0:Destroy();
        end);
        return;
    end;
end;
return function(v8, v9, v10) --[[ Line: 45 ]]
    -- upvalues: l_PetList_0 (copy), v1 (copy), v7 (copy)
    local v11 = script.EggExplode:Clone();
    v11:PivotTo(v8:GetPivot());
    local l_Core_0 = v11.Core;
    l_Core_0.Parent = workspace.Visuals;
    game.Debris:AddItem(l_Core_0, 60);
    v11.Parent = game.ReplicatedStorage;
    l_Core_0.RareSFX:Play();
    task.wait(0.4);
    local v13 = 0;
    local l_v8_Pivot_0 = v8:GetPivot();
    local l_v8_ExtentsSize_0 = v8:GetExtentsSize();
    while v13 < 0.8 do
        v13 = v13 + game:GetService("RunService").Heartbeat:Wait();
        local v16 = (1 - v13 / 0.8) * math.sin(tick() * 90) * 7;
        v8:PivotTo(l_v8_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v16))));
    end;
    task.wait(0.5);
    local v17 = 0;
    while v17 < 0.8 do
        v17 = v17 + game:GetService("RunService").Heartbeat:Wait();
        local v18 = (1 - v17 / 0.8) * math.sin(tick() * 90) * 9;
        v8:PivotTo(l_v8_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v18))));
    end;
    task.wait(0.5);
    local v19 = 0;
    while v19 < 0.8 do
        v19 = v19 + game:GetService("RunService").Heartbeat:Wait();
        local v20 = (1 - v19 / 0.8) * math.sin(tick() * 90) * 13;
        v8:PivotTo(l_v8_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v20))));
    end;
    local l_v8_Attribute_0 = v8:GetAttribute("EggColor");
    local l_v8_Attribute_1 = v8:GetAttribute("EggMaterial");
    local l_v8_Attribute_2 = v8:GetAttribute("EggTransparency");
    local l_v8_Attribute_3 = v8:GetAttribute("EggMaterialVariant");
    v8:Destroy();
    v11.Parent = workspace.Visuals;
    for _, v26 in v11:GetDescendants() do
        if v26 ~= l_Core_0 and v26.Name ~= "RootPart" and v26:IsA("BasePart") then
            v26.Anchored = false;
        end;
    end;
    local v27 = nil;
    if v9 and v9 ~= "" then
        local v28 = l_PetList_0[v9];
        v27 = v28.Model:Clone();
        local l_Variant_0 = v28.Variant;
        if l_Variant_0 then
            v1:SetSkin(v27, l_Variant_0);
        end;
        if v27.PrimaryPart then
            v27.PrimaryPart.Anchored = true;
        end;
        local v30 = script.Highlight:Clone();
        v30.Parent = v27;
        v30.Adornee = v27;
        v27.Parent = workspace.Visuals;
        local v31 = 0;
        local l_v28_0 = v28 --[[ copy: 15 -> 27 ]];
        do
            local l_v31_0 = v31;
            task.spawn(function() --[[ Line: 107 ]]
                -- upvalues: l_v31_0 (ref), v27 (ref), v10 (copy), l_v8_Pivot_0 (copy), l_v8_ExtentsSize_0 (copy), l_v28_0 (copy)
                while l_v31_0 < 1 do
                    l_v31_0 = l_v31_0 + game:GetService("RunService").Heartbeat:Wait();
                    local l_Value_0 = game.TweenService:GetValue(l_v31_0 / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                    local function _(v35, v36, v37) --[[ Line: 112 ]] --[[ Name: _ ]]
                        return v35 + (v36 - v35) * v37;
                    end;
                    v27:ScaleTo(1 + (v10 - 1) * l_Value_0);
                    v27:PivotTo(l_v8_Pivot_0 * CFrame.new(0, -l_v8_ExtentsSize_0.Y / 2, 0) * CFrame.new(0, v27:GetExtentsSize().Y / 2, 0) * l_v28_0.WeldOffset);
                end;
            end);
            local l_Idle_0 = v28.Animations.Idle;
            if l_Idle_0 then
                v27.AnimationController:LoadAnimation(l_Idle_0):Play();
            end;
            for _, v41 in v27:GetDescendants() do
                if v41:IsA("BasePart") then
                    v41.CanCollide = false;
                    v41.CanQuery = false;
                end;
            end;
            game.TweenService:Create(v30, TweenInfo.new(0.5), {
                FillTransparency = 1
            }):Play();
            task.delay(0.5, function() --[[ Line: 132 ]]
                -- upvalues: v7 (ref), v9 (copy)
                v7(v9);
            end);
        end;
    end;
    for _, v43 in v11:GetChildren() do
        if not v43:IsA("BasePart") then
            local l_v43_BoundingBox_0, v45 = v43:GetBoundingBox();
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Transparency = 1;
            l_Part_0.CanCollide = false;
            l_Part_0.CanQuery = false;
            l_Part_0.CanTouch = false;
            l_Part_0.CFrame = l_v43_BoundingBox_0;
            l_Part_0.Size = v45;
            local l_WeldConstraint_0 = Instance.new("WeldConstraint");
            l_WeldConstraint_0.Part0 = l_Part_0;
            l_WeldConstraint_0.Part1 = v43.PrimaryPart;
            l_WeldConstraint_0.Parent = l_Part_0;
            l_Part_0.Parent = v43;
            local l_Attachment_0 = Instance.new("Attachment");
            local l_Attachment_1 = Instance.new("Attachment");
            l_Attachment_0.Parent = l_Part_0;
            l_Attachment_1.Parent = l_Part_0;
            l_Attachment_0.Position = Vector3.new(0, v45.Y / 2, 0);
            l_Attachment_1.Position = Vector3.new(0, -v45.Y / 2, 0);
            local v50 = script.Trail:Clone();
            v50.Attachment0 = l_Attachment_0;
            v50.Attachment1 = l_Attachment_1;
            v50.Color = ColorSequence.new(l_v8_Attribute_0);
            v50.Parent = l_Attachment_0;
            v50.Enabled = true;
        end;
    end;
    for _, v52 in v11:GetDescendants() do
        if v52 ~= l_Core_0 and v52.Name ~= "RootPart" and v52:IsA("BasePart") then
            local l_Position_0 = v52.Position;
            local v54 = CFrame.new(l_Core_0.Position, l_Position_0).LookVector * 16;
            v52.Color = l_v8_Attribute_0 or v52.Color;
            v52.Material = l_v8_Attribute_1 or v52.Material;
            v52.MaterialVariant = l_v8_Attribute_3 or v52.MaterialVariant;
            v52.Transparency = l_v8_Attribute_2 or v52.Transparency;
            v52:ApplyImpulse(v54 * v52.AssemblyMass);
        end;
    end;
    task.delay(3, function() --[[ Line: 178 ]]
        -- upvalues: v11 (copy)
        for _, v56 in v11:GetChildren() do
            for _, v58 in v56:GetDescendants() do
                if v58:IsA("BasePart") then
                    game.TweenService:Create(v58, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
        game.Debris:AddItem(v11, 1);
    end);
    for _, v60 in l_Core_0.Attachment:GetDescendants() do
        if v60:IsA("ParticleEmitter") then
            if v60.Name == "ColorMe" then
                v60.Color = ColorSequence.new(l_v8_Attribute_0);
            end;
            v60:Emit(v60:GetAttribute("EmitCount"));
        end;
    end;
    for _, v62 in l_Core_0.Rare:GetDescendants() do
        if v62:IsA("ParticleEmitter") then
            v62.Color = ColorSequence.new(l_v8_Attribute_0);
            v62:Emit(v62:GetAttribute("EmitCount"));
        end;
    end;
    task.wait(3);
    local v63 = game.ReplicatedStorage.Assets.EggPoof:Clone();
    v63.CFrame = l_v8_Pivot_0;
    v63.Parent = workspace.Visuals;
    v7("Poof");
    for _, v65 in v63:GetChildren() do
        v65:Emit(v65:GetAttribute("EmitCount"));
    end;
    game.Debris:AddItem(v63, 6);
    task.delay(0.2, function() --[[ Line: 214 ]]
        -- upvalues: v27 (ref)
        v27:Destroy();
    end);
end;