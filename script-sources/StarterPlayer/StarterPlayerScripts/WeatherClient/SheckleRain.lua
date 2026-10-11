-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SheckleRain, time of decompilation: Sun Jun  8 12:59:11 2025 ]]
local v0 = {};
local _ = {};
local l_SheckleParticle_0 = game.ReplicatedStorage.SheckleParticle;
local v3 = Random.new();
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v5 = RaycastParams.new();
v5.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v5.FilterType = Enum.RaycastFilterType.Include;
local v6 = {};
local v7 = false;
local function v10(v8) --[[ Line: 16 ]] --[[ Name: v10 ]]
    -- upvalues: l_SheckleParticle_0 (copy), v6 (copy)
    local v9 = {
        particle = l_SheckleParticle_0:Clone(), 
        position = v8, 
        spawnTime = os.clock(), 
        visible = false, 
        lastupdate = 0
    };
    game.TweenService:Create(v9.particle, TweenInfo.new(0.7), {
        Transparency = 0.2
    }):Play();
    table.insert(v6, v9);
end;
local _ = function(v11, v12, v13) --[[ Line: 30 ]]
    -- upvalues: v5 (copy)
    local _ = v12 - v11.spawnTime + v13;
    local l_position_0 = v11.position;
    local v16 = Vector3.new(0, -5 * v13, 0);
    local v17 = workspace:Spherecast(l_position_0, 0.15, v16, v5);
    if v17 then
        return v17.Position, true;
    else
        v11.position = l_position_0 + v16;
        return l_position_0;
    end;
end;
local v19 = game.ReplicatedStorage.SheckleRainEmitter:Clone();
v19.Parent = workspace.WeatherVisuals;
local l_Sky_0 = script.Sky;
local v22 = game.Lighting.ColorCorrection:Clone();
v22.Name = script.Name;
v22.Parent = game.Lighting;
local function v28() --[[ Line: 51 ]] --[[ Name: v28 ]]
    -- upvalues: v7 (ref), v19 (copy), v21 (copy), l_Sky_0 (copy), v22 (copy), v6 (copy), v3 (copy), l_CurrentCamera_0 (copy), v10 (copy)
    v7 = true;
    v19.ParticleEmitter.Enabled = true;
	l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
        Ambient = Color3.fromRGB(255, 206, 138), 
        ExposureCompensation = 0.4, 
        Brightness = 0.7
    }):Play();
    game.TweenService:Create(v22, TweenInfo.new(3), {
        Brightness = 0.1, 
        TintColor = Color3.fromRGB(252, 255, 193)
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.624, 
        Density = 1, 
        Color = Color3.fromRGB(255, 245, 167)
    }):Play();
    task.spawn(function() --[[ Line: 71 ]]
        -- upvalues: v7 (ref), v6 (ref), v3 (ref), l_CurrentCamera_0 (ref), v10 (ref), v21 (ref), l_Sky_0 (ref), v19 (ref), v22 (ref)
        while v7 do
            task.wait(0.05);
            if #v6 <= 400 then
                for _ = 1, 3 do
                    local v24 = v3:NextNumber(10, 180);
                    local v25 = 2 * v24 * math.tan((math.rad(l_CurrentCamera_0.FieldOfView / 2)));
                    local v26 = v25 * (l_CurrentCamera_0.ViewportSize.X / l_CurrentCamera_0.ViewportSize.Y);
                    local v27 = l_CurrentCamera_0.CFrame * CFrame.new(v3:NextNumber(-v26 / 2, v26 / 2), v3:NextNumber(-v25 / 2, v25 / 2 + 20), -v24);
                    if not workspace:Raycast(v27.Position, (Vector3.new(0, 150, 0, 0))) then
                        v10(v27.Position);
                    end;
                end;
            end;
        end;
		l_Sky_0.Parent = script
        v19.ParticleEmitter.Enabled = false;
        game.TweenService:Create(v22, TweenInfo.new(3), {
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
        task.delay(3, function() --[[ Line: 102 ]]
            game.Workspace.Terrain.Clouds.Enabled = false;
        end);
    end);
end;
workspace:GetAttributeChangedSignal("SheckleRain"):Connect(function() --[[ Line: 107 ]]
    -- upvalues: v28 (copy), v7 (ref)
    if workspace:GetAttribute("SheckleRain") then
        v28();
        return;
    else
        v7 = false;
        return;
    end;
end);
local v29 = game.ReplicatedStorage.SheckleSplash:Clone();
v29.Parent = workspace.WeatherVisuals;
task.spawn(function() --[[ Line: 119 ]]
    -- upvalues: v6 (copy), v5 (copy), l_CurrentCamera_0 (copy), v29 (copy), v3 (copy)
    while true do
        local v30 = game:GetService("RunService").RenderStepped:Wait();
        local v31 = os.clock();
        local v32 = {};
        local v33 = {};
        local v34 = v30 * 3;
        local v35 = math.min(1, v30 * 5);
        for v36, v37 in v6 do
            local v38 = v31 - v37.spawnTime + v35;
            local l_position_1 = v37.position;
            local v40 = Vector3.new(0, v35 * -5, 0);
            local v41 = workspace:Spherecast(l_position_1, 0.15, v40, v5);
            local v42 = nil;
            local v43 = nil;
            if v41 then
                v42 = v41.Position;
                v43 = true;
            else
                v37.position = l_position_1 + v40;
                v42 = l_position_1;
                v43 = nil;
            end;
            local v44 = nil;
            local v45, v46 = l_CurrentCamera_0:WorldToScreenPoint(v42);
            v44 = v45;
            v38 = v46;
            l_position_1 = v37.visible;
            v40 = (l_CurrentCamera_0.CFrame.Position - v42).Magnitude / 120;
            v41 = v40 * v40;
            v45 = 1 / math.random(60, 120);
            v46 = v34 * v41 + 0.016666666666666666;
            if v40 > 1.5 then
                v37.particle:Destroy();
                table.remove(v6, v36);
            elseif v46 < v31 - v37.lastupdate + v45 then
                v37.lastupdate = v31;
                if v38 and v44.Z < 200 then
                    v37.visible = true;
                    table.insert(v32, v37.particle);
                    table.insert(v33, CFrame.new(v42, l_CurrentCamera_0.CFrame.Position) * CFrame.Angles(1.5707963267948966, 0, 0));
                else
                    v37.visible = false;
                end;
                if v37.visible ~= l_position_1 then
                    if v37.visible then
                        v37.particle.Parent = workspace.WeatherVisuals;
                    else
                        v37.particle.Parent = nil;
                    end;
                end;
                if v43 then
                    v37.particle:Destroy();
                    v29.CFrame = CFrame.new(v42);
                    v29.Attachment.ParticleEmitter:Emit(v3:NextInteger(1, 2));
                    table.remove(v6, v36);
                elseif os.clock() - v37.spawnTime > 7 then
                    game.Debris:AddItem(v37.particle, 0.3);
                    game.TweenService:Create(v37.particle, TweenInfo.new(0.3), {
                        Transparency = 1
                    }):Play();
                    table.remove(v6, v36);
                end;
            end;
        end;
        debug.profilebegin("Weather_" .. script.Name);
        workspace:BulkMoveTo(v32, v33, Enum.BulkMoveMode.FireCFrameChanged);
        debug.profileend();
    end;
end);
if workspace:GetAttribute("SheckleRain") then
    task.defer(v28);
else
    v7 = false;
end;
return v0;