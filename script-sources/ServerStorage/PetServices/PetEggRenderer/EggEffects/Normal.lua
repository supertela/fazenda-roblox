-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Normal, time of decompilation: Wed Jun  4 21:32:02 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(game.ReplicatedStorage.Data.PetRegistry);
local v2 = require(l_ReplicatedStorage_0.Modules.SkinService);
local l_PetList_0 = v1.PetList;
local v4 = {
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
local function v8(v5) --[[ Line: 28 ]] --[[ Name: v8 ]]
    -- upvalues: v4 (copy)
    local l_Sound_0 = Instance.new("Sound");
    local v7 = v4[v5];
    if not v7 then
        warn((("PetEggRenderer:RenderEgg | No sound found for %*"):format(v5)));
        return;
    else
        l_Sound_0.SoundId = v7;
        l_Sound_0.Parent = workspace;
        l_Sound_0:Play();
        l_Sound_0.Ended:Once(function() --[[ Line: 39 ]]
            -- upvalues: l_Sound_0 (copy)
            l_Sound_0:Destroy();
        end);
        return;
    end;
end;
return function(v9, v10, v11) --[[ Line: 46 ]]
    -- upvalues: l_PetList_0 (copy), v2 (copy), v8 (copy)
    local v12 = script.EggExplode:Clone();
    v12:PivotTo(v9:GetPivot());
    local l_Core_0 = v12.Core;
    l_Core_0.Parent = workspace.Visuals;
    game.Debris:AddItem(l_Core_0, 60);
    v12.Parent = game.ReplicatedStorage;
    l_Core_0.NormalSFX:Play();
    task.wait(0.4);
    local v14 = 0;
    local l_v9_Pivot_0 = v9:GetPivot();
    local l_v9_ExtentsSize_0 = v9:GetExtentsSize();
    while v14 < 0.8 do
        v14 = v14 + game:GetService("RunService").Heartbeat:Wait();
        local v17 = (1 - v14 / 0.8) * math.sin(tick() * 90) * 7;
        v9:PivotTo(l_v9_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v17))));
    end;
    task.wait(0.5);
    local v18 = 0;
    while v18 < 0.8 do
        v18 = v18 + game:GetService("RunService").Heartbeat:Wait();
        local v19 = (1 - v18 / 0.8) * math.sin(tick() * 90) * 9;
        v9:PivotTo(l_v9_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v19))));
    end;
    task.wait(0.5);
    local v20 = 0;
    while v20 < 0.8 do
        v20 = v20 + game:GetService("RunService").Heartbeat:Wait();
        local v21 = (1 - v20 / 0.8) * math.sin(tick() * 90) * 13;
        v9:PivotTo(l_v9_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v21))));
    end;
    local l_v9_Attribute_0 = v9:GetAttribute("EggColor");
    local l_v9_Attribute_1 = v9:GetAttribute("EggMaterial");
    local l_v9_Attribute_2 = v9:GetAttribute("EggTransparency");
    local l_v9_Attribute_3 = v9:GetAttribute("EggMaterialVariant");
    v9:Destroy();
    v12.Parent = workspace.Visuals;
    for _, v27 in v12:GetDescendants() do
        if v27 ~= l_Core_0 and v27.Name ~= "RootPart" and v27:IsA("BasePart") then
            v27.Anchored = false;
        end;
    end;
    local v28 = nil;
    if v10 and v10 ~= "" then
        local v29 = l_PetList_0[v10];
        v28 = v29.Model:Clone();
        local l_Variant_0 = v29.Variant;
        if l_Variant_0 then
            v2:SetSkin(v28, l_Variant_0);
        end;
        if v28.PrimaryPart then
            v28.PrimaryPart.Anchored = true;
        end;
        local v31 = script.Highlight:Clone();
        v31.Parent = v28;
        v31.Adornee = v28;
        v28.Parent = workspace.Visuals;
        local v32 = 0;
        local l_v29_0 = v29 --[[ copy: 15 -> 25 ]];
        do
            local l_v32_0 = v32;
            task.spawn(function() --[[ Line: 108 ]]
                -- upvalues: l_v32_0 (ref), v28 (ref), v11 (copy), l_v9_Pivot_0 (copy), l_v9_ExtentsSize_0 (copy), l_v29_0 (copy)
                while l_v32_0 < 1 do
                    l_v32_0 = l_v32_0 + game:GetService("RunService").Heartbeat:Wait();
                    local l_Value_0 = game.TweenService:GetValue(l_v32_0 / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                    local function _(v36, v37, v38) --[[ Line: 113 ]] --[[ Name: _ ]]
                        return v36 + (v37 - v36) * v38;
                    end;
                    v28:ScaleTo(1 + (v11 - 1) * l_Value_0);
                    v28:PivotTo(l_v9_Pivot_0 * CFrame.new(0, -l_v9_ExtentsSize_0.Y / 2, 0) * CFrame.new(0, v28:GetExtentsSize().Y / 2, 0) * l_v29_0.WeldOffset);
                end;
            end);
            local l_Idle_0 = v29.Animations.Idle;
            if l_Idle_0 then
                v28.AnimationController:LoadAnimation(l_Idle_0):Play();
            end;
            for _, v42 in v28:GetDescendants() do
                if v42:IsA("BasePart") then
                    v42.CanCollide = false;
                    v42.CanQuery = false;
                end;
            end;
            game.TweenService:Create(v31, TweenInfo.new(0.5), {
                FillTransparency = 1
            }):Play();
            task.delay(0.5, function() --[[ Line: 133 ]]
                -- upvalues: v8 (ref), v10 (copy)
                v8(v10);
            end);
        end;
    end;
    for _, v44 in v12:GetDescendants() do
        if v44 ~= l_Core_0 and v44.Name ~= "RootPart" and v44:IsA("BasePart") then
            local l_Position_0 = v44.Position;
            local v46 = CFrame.new(l_Core_0.Position, l_Position_0).LookVector * 8;
            v44.Color = l_v9_Attribute_0 or v44.Color;
            v44.Material = l_v9_Attribute_1 or v44.Material;
            v44.MaterialVariant = l_v9_Attribute_3 or v44.MaterialVariant;
            v44.Transparency = l_v9_Attribute_2 or v44.Transparency;
            v44:ApplyImpulse(v46 * v44.AssemblyMass);
        end;
    end;
    task.delay(3, function() --[[ Line: 150 ]]
        -- upvalues: v12 (copy)
        for _, v48 in v12:GetChildren() do
            for _, v50 in v48:GetDescendants() do
                if v50:IsA("BasePart") then
                    game.TweenService:Create(v50, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
        game.Debris:AddItem(v12, 1);
    end);
    for _, v52 in l_Core_0.Attachment:GetDescendants() do
        if v52:IsA("ParticleEmitter") then
            v52:Emit(v52:GetAttribute("EmitCount"));
        end;
    end;
    task.wait(3);
    local v53 = game.ReplicatedStorage.Assets.EggPoof:Clone();
    v53.CFrame = l_v9_Pivot_0;
    v53.Parent = workspace.Visuals;
    v8("Poof");
    for _, v55 in v53:GetChildren() do
        v55:Emit(v55:GetAttribute("EmitCount"));
    end;
    game.Debris:AddItem(v53, 6);
    task.delay(0.2, function() --[[ Line: 177 ]]
        -- upvalues: v28 (ref)
        v28:Destroy();
    end);
end;