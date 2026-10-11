-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BeeNado, time of decompilation: Sun Jun  8 12:59:14 2025 ]]
local v0 = {};
local _ = {};
local v2 = false;
local l_Sky_0 = script.Sky;
local v5 = game.Lighting.ColorCorrection:Clone();
v5.Name = script.Name;
v5.Parent = game.Lighting;
local function v35() --[[ Line: 12 ]] --[[ Name: v35 ]]
    -- upvalues: v2 (ref), v4 (copy), l_Sky_0 (copy), v5 (copy)
    v2 = true;
	l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
        Ambient = Color3.fromRGB(222, 179, 69), 
        ExposureCompensation = 0.425, 
        Brightness = 0.7
    }):Play();
    game.TweenService:Create(v5, TweenInfo.new(3), {
        Brightness = 0.1, 
        TintColor = Color3.fromRGB(217, 204, 152)
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(255, 179, 0);
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.905, 
        Density = 0.083
    }):Play();
    local v8 = game.ReplicatedStorage.Assets.Beenado:Clone();
    v8.Parent = workspace;
    v8:PivotTo(game.ReplicatedStorage.StrikeLightningHere.CFrame);
    local l_PrimaryPart_0 = v8.PrimaryPart;
    local v10 = Random.new();
    local v11 = {};
    local function v16() --[[ Line: 39 ]] --[[ Name: v16 ]]
        -- upvalues: v8 (copy), v11 (copy), v10 (copy)
        local v12 = v8.Template:Clone();
        table.insert(v11, {
            CreationTime = tick(), 
            Template = v12, 
            Direction = Random.new():NextInteger(1, 2) == 2 and -1 or 1
        });
        v12.Name = tick();
        v12.Parent = v8;
        local v13 = v10:NextNumber(2.35, 4);
        for _, v15 in v12:GetDescendants() do
            if v15:IsA("Beam") then
                v15.Width0 = v13;
                v15.Width1 = v13;
            end;
        end;
        game.TweenService:Create(v12, TweenInfo.new(1.2), {
            Size = Vector3.new(60, 0.5, 60, 0)
        }):Play();
    end;
    local v17 = tick();
    local function v20(v18) --[[ Line: 61 ]] --[[ Name: v20 ]]
        -- upvalues: v8 (copy)
        if workspace.Visuals:FindFirstChild("BeenadoSpot") then
            v8:PivotTo(v8:GetPivot():Lerp(workspace.Visuals.BeenadoSpot.CFrame, v18 * 5));
            local l_SpinMe_0 = v8.SpinMe;
            l_SpinMe_0.CFrame = l_SpinMe_0.CFrame * CFrame.Angles(math.rad(180 * v18), 0, 0);
        end;
    end;
    v20(1);
    local v21 = false;
    local v22 = true;
    task.spawn(function() --[[ Line: 72 ]]
        -- upvalues: v22 (ref), v20 (copy), v11 (copy), l_PrimaryPart_0 (copy), v17 (ref), v10 (copy), v21 (ref), v16 (copy), v5 (ref)
        while v22 do
            local v23 = game:GetService("RunService").Heartbeat:Wait();
            v20(v23);
            for v24, v25 in v11 do
                local v26 = math.clamp((tick() - v25.CreationTime) / 1.2, 0, 1);
                local v27 = 1 - math.sin((math.rad(v26 * 180)));
                v25.Template.CFrame = l_PrimaryPart_0.CFrame * CFrame.new(0, v26 * 90, 0) * CFrame.Angles(0, math.rad(v26 * 720) * v25.Direction, 0) * CFrame.new(0, 0, v26 * 10);
                for _, v29 in v25.Template:GetChildren() do
                    local _ = v29:GetAttribute("Direction");
                    v29.Position = Vector3.new(v25.Template.Size.X, 0, v25.Template.Size.Z) / 2;
                    v29.Position = v29.Position * v29:GetAttribute("Direction");
                end;
                for _, v32 in v25.Template:GetDescendants() do
                    if v32:IsA("Beam") then
                        v32.Transparency = NumberSequence.new(v27);
                    end;
                end;
                if v26 == 1 then
                    v25.Template:Destroy();
                    table.remove(v11, v24);
                end;
            end;
            if tick() - v17 > v10:NextNumber(0.1, 0.2) and v21 == false then
                v16();
                v17 = tick();
            end;
        end;
        game.TweenService:Create(v5, TweenInfo.new(3), {
            Brightness = 0, 
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
            Ambient = game.Lighting:GetAttribute("DefaultAmbient"), 
            ExposureCompensation = game.Lighting:GetAttribute("DefaultExposure"), 
            Brightness = game.Lighting:GetAttribute("DefaultBrightness")
        }):Play();
        game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
            Cover = 0, 
            Density = 0
        }):Play();
        task.delay(3, function() --[[ Line: 114 ]]
            game.Workspace.Terrain.Clouds.Enabled = false;
            game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(22, 40, 70);
        end);
    end);
    repeat
        task.wait();
    until v2 == false;
	l_Sky_0.Parent = script
    v21 = true;
    task.wait(1);
    v22 = false;
    for _, v34 in v8:GetDescendants() do
        if v34:IsA("ParticleEmitter") then
            v34.Enabled = false;
        end;
    end;
    task.delay(4, function() --[[ Line: 131 ]]
        -- upvalues: v8 (copy)
        v8:Destroy();
    end);
end;
workspace:GetAttributeChangedSignal("BeenadoEvent"):Connect(function() --[[ Line: 136 ]]
    -- upvalues: v35 (copy), v2 (ref)
    if workspace:GetAttribute("BeenadoEvent") then
        v35();
        return;
    else
        v2 = false;
        return;
    end;
end);
if workspace:GetAttribute("BeenadoEvent") then
    task.defer(v35);
else
    v2 = false;
end;
return v0;