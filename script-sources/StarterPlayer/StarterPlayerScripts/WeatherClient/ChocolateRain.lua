-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ChocolateRain, time of decompilation: Sun Jun  8 12:59:12 2025 ]]
local v0 = {};
local _ = {};
local l_ChocParticle_0 = game.ReplicatedStorage.ChocParticle;
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
local v8 = game.Lighting.ColorCorrection:Clone();
v8.Name = script.Name;
v8.Parent = game.Lighting;
local function v11(v9) --[[ Line: 19 ]] --[[ Name: v11 ]]
    -- upvalues: l_ChocParticle_0 (copy), v6 (copy)
    local v10 = {
        particle = l_ChocParticle_0:Clone(), 
        position = v9, 
        spawnTime = os.clock(), 
        visible = false, 
        lastupdate = 0
    };
    game.TweenService:Create(v10.particle, TweenInfo.new(0.7), {
        Transparency = 0.2
    }):Play();
    table.insert(v6, v10);
end;
local _ = function(v12, v13, v14) --[[ Line: 33 ]]
    -- upvalues: v5 (copy)
    local _ = v13 - v12.spawnTime + v14;
    local l_position_0 = v12.position;
    local v17 = Vector3.new(0, -20 * v14, 0);
    local v18 = workspace:Spherecast(l_position_0, 0.15, v17, v5);
    if v18 then
        return v18.Position, true;
    else
        v12.position = l_position_0 + v17;
        return l_position_0;
    end;
end;
local l_Sky_0 = script.Sky;
local v22 = game.ReplicatedStorage.ChocolateRainEmitter:Clone();
v22.Parent = workspace.WeatherVisuals;
local function v28() --[[ Line: 51 ]] --[[ Name: v28 ]]
    -- upvalues: v7 (ref), v21 (copy), l_Sky_0 (copy), v8 (copy), v22 (copy), v6 (copy), v3 (copy), l_CurrentCamera_0 (copy), v11 (copy)
    v7 = true;
	l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
        Ambient = Color3.fromRGB(243, 194, 255), 
        ExposureCompensation = 0.4, 
        Brightness = 1
    }):Play();
    game.TweenService:Create(v8, TweenInfo.new(3), {
        Brightness = 0.1, 
        TintColor = Color3.fromRGB(241, 226, 255)
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(29, 13, 6);
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.765, 
        Density = 0.729
    }):Play();
    task.spawn(function() --[[ Line: 70 ]]
        -- upvalues: v22 (ref), v7 (ref), v6 (ref), v3 (ref), l_CurrentCamera_0 (ref), v11 (ref), v21 (ref), l_Sky_0 (ref), v8 (ref)
        v22.ParticleEmitter.Enabled = true;
        while v7 do
            task.wait(0.05);
            if #v6 <= 200 then
                for _ = 1, 3 do
                    local v24 = v3:NextNumber(10, 180);
                    local v25 = 2 * v24 * math.tan((math.rad(l_CurrentCamera_0.FieldOfView / 2)));
                    local v26 = v25 * (l_CurrentCamera_0.ViewportSize.X / l_CurrentCamera_0.ViewportSize.Y);
                    local v27 = l_CurrentCamera_0.CFrame * CFrame.new(v3:NextNumber(-v26 / 2, v26 / 2), v3:NextNumber(-v25 / 2, v25 / 2 + 20), -v24);
                    if not workspace:Raycast(v27.Position, (Vector3.new(0, 150, 0, 0))) then
                        v11(v27.Position);
                    end;
                end;
            end;
        end;
		l_Sky_0.Parent = script
        v22.ParticleEmitter.Enabled = false;
        game.TweenService:Create(v8, TweenInfo.new(3), {
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
            game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(22, 40, 70);
        end);
    end);
end;
workspace:GetAttributeChangedSignal("ChocolateRain"):Connect(function() --[[ Line: 108 ]]
    -- upvalues: v28 (copy), v7 (ref)
    if workspace:GetAttribute("ChocolateRain") then
        v28();
        return;
    else
        v7 = false;
        return;
    end;
end);
local v29 = game.ReplicatedStorage.ChocSplash:Clone();
v29.Parent = workspace.WeatherVisuals;
task.spawn(function() --[[ Line: 120 ]]
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
            local v40 = Vector3.new(0, v35 * -20, 0);
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
if workspace:GetAttribute("ChocolateRain") then
    task.defer(v28);
else
    v7 = false;
end;
return v0;