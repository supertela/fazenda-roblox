-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Tornado, time of decompilation: Sun Jun  8 12:59:12 2025 ]]
local v0 = {};
local _ = {};
local v2 = false;
local l_Sky_0 = script.Sky;
local v5 = game.Lighting.ColorCorrection:Clone();
v5.Name = script.Name;
v5.Parent = game.Lighting;
local function v34() --[[ Line: 11 ]] --[[ Name: v34 ]]
    -- upvalues: v2 (ref), v4 (copy), l_Sky_0 (copy), v5 (copy)
    v2 = true;
    l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
        Ambient = Color3.fromRGB(162, 162, 162), 
        ExposureCompensation = 0.425, 
        Brightness = 0.7
    }):Play();
    game.TweenService:Create(v5, TweenInfo.new(3), {
        Brightness = 0.1, 
        TintColor = Color3.fromRGB(217, 217, 217)
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.905, 
        Density = 0.083
    }):Play();
    local _ = {};
    local _ = {};
    local v8 = game.ReplicatedStorage.Assets.Tornado:Clone();
    v8.Parent = workspace;
    v8:PivotTo(game.ReplicatedStorage.StrikeLightningHere.CFrame);
    local l_PrimaryPart_0 = v8.PrimaryPart;
    local v10 = Random.new();
    local v11 = {};
    local function v16() --[[ Line: 37 ]] --[[ Name: v16 ]]
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
    local function _(v18) --[[ Line: 59 ]] --[[ Name: _ ]]
        -- upvalues: v8 (copy)
        if workspace.Visuals:FindFirstChild("TornadoSpot") then
            v8:PivotTo(v8:GetPivot():Lerp(workspace.Visuals.TornadoSpot.CFrame, v18 * 5));
        end;
    end;
    if workspace.Visuals:FindFirstChild("TornadoSpot") then
        v8:PivotTo(v8:GetPivot():Lerp(workspace.Visuals.TornadoSpot.CFrame, 5));
    end;
    local v20 = false;
    local v21 = true;
    task.spawn(function() --[[ Line: 70 ]]
        -- upvalues: v21 (ref), v8 (copy), v11 (copy), l_PrimaryPart_0 (copy), v17 (ref), v10 (copy), v20 (ref), v16 (copy), v4 (ref), l_Sky_0 (ref), v5 (ref)
        while v21 do
            local v22 = game:GetService("RunService").Heartbeat:Wait();
            if workspace.Visuals:FindFirstChild("TornadoSpot") then
                v8:PivotTo(v8:GetPivot():Lerp(workspace.Visuals.TornadoSpot.CFrame, v22 * 5));
            end;
            for v23, v24 in v11 do
                local v25 = math.clamp((tick() - v24.CreationTime) / 1.2, 0, 1);
                local v26 = 1 - math.sin((math.rad(v25 * 180)));
                v24.Template.CFrame = l_PrimaryPart_0.CFrame * CFrame.new(0, v25 * 90, 0) * CFrame.Angles(0, math.rad(v25 * 720) * v24.Direction, 0) * CFrame.new(0, 0, v25 * 10);
                for _, v28 in v24.Template:GetChildren() do
                    local _ = v28:GetAttribute("Direction");
                    v28.Position = Vector3.new(v24.Template.Size.X, 0, v24.Template.Size.Z) / 2;
                    v28.Position = v28.Position * v28:GetAttribute("Direction");
                end;
                for _, v31 in v24.Template:GetDescendants() do
                    if v31:IsA("Beam") then
                        v31.Transparency = NumberSequence.new(v26);
                    end;
                end;
                if v25 == 1 then
                    v24.Template:Destroy();
                    table.remove(v11, v23);
                end;
            end;
            if tick() - v17 > v10:NextNumber(0.1, 0.2) and v20 == false then
                v16();
                v17 = tick();
            end;
        end;
		l_Sky_0.Parent = script
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
        task.delay(3, function() --[[ Line: 115 ]]
            game.Workspace.Terrain.Clouds.Enabled = false;
        end);
    end);
    repeat
        task.wait();
    until v2 == false;
    v20 = true;
    task.wait(1);
    v21 = false;
    for _, v33 in v8:GetDescendants() do
        if v33:IsA("ParticleEmitter") then
            v33.Enabled = false;
        end;
    end;
    task.delay(4, function() --[[ Line: 130 ]]
        -- upvalues: v8 (copy)
        v8:Destroy();
    end);
end;
workspace:GetAttributeChangedSignal("TornadoEvent"):Connect(function() --[[ Line: 135 ]]
    -- upvalues: v34 (copy), v2 (ref)
    if workspace:GetAttribute("TornadoEvent") then
        v34();
        return;
    else
        v2 = false;
        return;
    end;
end);
if workspace:GetAttribute("TornadoEvent") then
    task.defer(v34);
else
    v2 = false;
end;
return v0;