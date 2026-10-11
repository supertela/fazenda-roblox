-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Blackhole, time of decompilation: Sun Jun  8 12:59:13 2025 ]]
local v0 = {};
local v5 = require(game.ReplicatedStorage.Code.CameraShaker);
local v7 = RaycastParams.new();
v7.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v7.FilterType = Enum.RaycastFilterType.Include;
local v9 = false;
local v11 = v5.new(Enum.RenderPriority.Camera.Value, function(v10) --[[ Line: 19 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v10;
end);
v11:Start();
local l_Sky_0 = script.Sky;
local v14 = game.Lighting.ColorCorrection:Clone();
v14.Name = script.Name;
v14.Parent = game.Lighting;
local l_BlackHoleOrbs_0 = game.ReplicatedStorage.Assets.BlackHoleOrbs;
local v16 = {};
local v17 = (game:GetService("UserInputService").TouchEnabled and "Mobile" or "PC") == "Mobile" and 0.025 or 0.015;
local function v43() --[[ Line: 32 ]] --[[ Name: v43 ]]
    -- upvalues: v9 (ref), v13 (copy), l_Sky_0 (copy), v11 (copy), v5 (copy), v14 (copy), l_BlackHoleOrbs_0 (copy), v16 (copy), v17 (copy)
    v9 = true;
    local v18 = script.Snap:Clone();
    v18.SoundId = "rbxassetid://119332409093320";
    v18.Parent = workspace;
    v18:Play();
    l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(3), {
        Density = 0.288, 
        Offset = 0.55, 
        Color = Color3.fromRGB(149, 0, 255), 
        Decay = Color3.fromRGB(86, 80, 255), 
        Glare = 1, 
        Haze = 1
    }):Play();
    game.Lighting.Ambient = Color3.fromRGB(88, 81, 159);
    game.Debris:AddItem(v18, 4);
    v11:Shake(v5.Presets.Bump);
    game.TweenService:Create(v14, TweenInfo.new(0.3), {
        TintColor = Color3.fromRGB(255, 233, 197), 
        Brightness = 0.5
    }):Play();
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = 90
    }):Play();
    task.wait(0.3);
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
        FieldOfView = 70
    }):Play();
    game.TweenService:Create(v14, TweenInfo.new(2), {
        TintColor = Color3.fromRGB(255, 255, 255), 
        Brightness = 0
    }):Play();
    task.wait(1.5);
    game.TweenService:Create(v14, TweenInfo.new(3), {
        Brightness = 0.15, 
        Contrast = 0.15, 
        Saturation = 0.2, 
        TintColor = Color3.fromRGB(196, 185, 255)
    }):Play();
    v11:ShakeSustain(v5.Presets.Earthquake);
    local v19 = script.EarthquakeStart:Clone();
    v19.Parent = workspace;
    v19:Play();
    game.Debris:AddItem(v19, 5);
    task.wait(1);
    local v20 = script.EarthquakeLoop:Clone();
    v20.Parent = workspace;
    game.TweenService:Create(v20, TweenInfo.new(1), {
        Volume = 0.5
    }):Play();
    v20:Play();
    local v21 = game.ReplicatedStorage.Assets.Blackhole:Clone();
    v21.Parent = workspace;
    local v22 = 0;
    for _, v24 in v21.Floor:GetDescendants() do
        v24.Enabled = true;
    end;
    game.TweenService:Create(workspace, TweenInfo.new(3), {
        Gravity = 20
    }):Play();
    while v22 < 3 do
        v22 = v22 + game:GetService("RunService").Heartbeat:Wait();
        v21.Model:ScaleTo(v22 / 3 * 2);
        for _, v26 in v21.Floor:GetDescendants() do
            v26.TimeScale = v22 / 3;
        end;
    end;
    v21.Model:ScaleTo(2);
    local function v30(v27) --[[ Line: 103 ]] --[[ Name: v30 ]]
        -- upvalues: l_BlackHoleOrbs_0 (ref), v21 (copy), v16 (ref)
        local v28 = l_BlackHoleOrbs_0:GetChildren()[math.random(1, 2)]:Clone();
        if not v21 then
            return;
        else
            local v29 = {
                Particle = v28, 
                lifetime = v27, 
                runTime = 0, 
                Target = v21.Model.Core.CFrame, 
                BasicAngle = CFrame.Angles(math.rad((math.random(0, 360))), math.rad((math.random(0, 360))), (math.rad((math.random(0, 360))))), 
                StartCFrame = v21.Model.Core.CFrame * CFrame.new(0, 0, math.random(42, 100) + v21.Model.Core.Size.Z / 2)
            };
            v28.CFrame = v29.StartCFrame;
            table.insert(v16, v29);
            v28.Parent = workspace.Visuals;
            return;
        end;
    end;
    local function _(v31) --[[ Line: 123 ]] --[[ Name: _ ]]
        -- upvalues: v16 (ref)
        v16[v31].Particle:Destroy();
        v16[v31] = nil;
    end;
    local v33 = 0;
    local v34 = 0;
    task.spawn(function() --[[ Line: 130 ]]
        -- upvalues: v17 (ref), v21 (copy), v33 (ref), v34 (ref), v30 (copy), v16 (ref)
        while true do
            local v35 = task.wait(v17);
            if v21 then
                v33 = v33 + v35;
                v34 = v34 + v35;
                if v34 >= 0.4 then
                    v34 = 0;
                    v30(5);
                end;
                for v36, v37 in pairs(v16) do
                    if v37.runTime >= v37.lifetime then
                        v16[v36].Particle:Destroy();
                        v16[v36] = nil;
                    else
                        v37.runTime = v37.runTime + v35;
                        local _ = 1 - v37.runTime / v37.lifetime;
                        local v39 = v37.runTime / v37.lifetime;
                        if v21 and v21:IsDescendantOf(workspace) then
                            v37.Particle.CFrame = v21.Model.Core.CFrame * v37.BasicAngle * CFrame.Angles(math.rad(v39 * 360), math.rad(v39 * 360), math.rad(v39 * 360), 0) * v37.StartCFrame:ToObjectSpace(v37.Target):Lerp(CFrame.new(0, 0, 0), v39);
                        else
                            break;
                        end;
                    end;
                end;
            else
                break;
            end;
        end;
    end);
    repeat
        task.wait();
    until v9 == false;
    for v40, _ in v16 do
        v16[v40].Particle:Destroy();
        v16[v40] = nil;
    end;
    local v42 = script.Snap:Clone();
    v42.SoundId = "rbxassetid://119332409093320";
    v42.Parent = workspace;
    v42:Play();
    l_Sky_0.Parent = script
    v11:StopSustained(1);
    v11:Shake(v5.Presets.Bump);
    v21:Destroy();
    v20:Destroy();
    game.TweenService:Create(v14, TweenInfo.new(0.3), {
        TintColor = Color3.fromRGB(255, 233, 197), 
        Brightness = 0.5
    }):Play();
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = 90
    }):Play();
    task.wait(0.3);
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
        FieldOfView = 70
    }):Play();
    game.TweenService:Create(v14, TweenInfo.new(2), {
        TintColor = Color3.fromRGB(255, 255, 255), 
        Brightness = 0
    }):Play();
    game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(1), {
        Density = 0, 
        Offset = 0, 
        Color = Color3.fromRGB(215, 244, 255), 
        Decay = Color3.fromRGB(190, 238, 255), 
        Glare = 0, 
        Haze = 0
    }):Play();
    game.Lighting.Ambient = Color3.fromRGB(138, 138, 138);
    game.TweenService:Create(v14, TweenInfo.new(1), {
        Brightness = 0, 
        Contrast = 0, 
        Saturation = 0, 
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
end;
workspace:GetAttributeChangedSignal("Blackhole"):Connect(function() --[[ Line: 211 ]]
    -- upvalues: v43 (copy), v9 (ref)
    if workspace:GetAttribute("Blackhole") then
        v43();
        return;
    else
        v9 = false;
        game.TweenService:Create(workspace, TweenInfo.new(3), {
            Gravity = 192.6
        }):Play();
        return;
    end;
end);
if workspace:GetAttribute("Blackhole") then
    task.defer(v43);
else
    v9 = false;
end;
local _ = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
return v0;