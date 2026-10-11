-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JandelStorm, time of decompilation: Sun Jun  8 12:59:12 2025 ]]
local v0 = {};
local l_RainParticle_0 = game.ReplicatedStorage.RainParticle;
local v5 = require(game.ReplicatedStorage.Code.CameraShaker);
local v6 = require(game.ReplicatedStorage.Code.LightningBolt);
local v7 = RaycastParams.new();
v7.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v7.FilterType = Enum.RaycastFilterType.Include;
local v8 = {};
local v9 = false;
local v11 = v5.new(Enum.RenderPriority.Camera.Value, function(v10) --[[ Line: 18 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v10;
end);
v11:Start();
local l_Sky_0 = script.Sky;
local v25 = game.Lighting.ColorCorrection:Clone();
v25.Name = script.Name;
v25.Parent = game.Lighting;
local function v26() --[[ Line: 55 ]] --[[ Name: v26 ]]
    -- upvalues: v9 (ref), v11 (copy), v5 (copy), v25 (copy), v24 (copy), l_Sky_0 (copy)
    v9 = true;
    v11:Shake(v5.Presets.Explosion);
    game.TweenService:Create(v25, TweenInfo.new(0.3), {
        TintColor = Color3.fromRGB(190, 236, 255), 
        Brightness = 0.5
    }):Play();
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = 90
    }):Play();
    task.wait(0.3);
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
        FieldOfView = 70
    }):Play();
	l_Sky_0.Parent = game.Lighting
    game.TweenService:Create(game.Lighting, TweenInfo.new(3), {}):Play();
    game.TweenService:Create(v25, TweenInfo.new(2), {
        Brightness = 0.1, 
        TintColor = Color3.fromRGB(255, 238, 203)
    }):Play();
    game.Workspace.Terrain.Clouds.Enabled = true;
    game.Workspace.Terrain.Clouds.Color = Color3.fromRGB(255, 241, 207);
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(3), {
        Cover = 0.701, 
        Density = 0
    }):Play();
    task.spawn(function() --[[ Line: 82 ]]
        -- upvalues: v24 (ref), l_Sky_0 (ref), v25 (ref)
        repeat
            task.wait();
        until not workspace:GetAttribute("JanzenStorm");
		l_Sky_0.Parent = script
        game.TweenService:Create(v25, TweenInfo.new(3), {
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
        task.delay(3, function() --[[ Line: 101 ]]
            game.Workspace.Terrain.Clouds.Enabled = false;
        end);
    end);
end;
workspace:GetAttributeChangedSignal("JanzenStorm"):Connect(function() --[[ Line: 106 ]]
    -- upvalues: v26 (copy), v9 (ref)
    if workspace:GetAttribute("JanzenStorm") then
        v26();
        return;
    else
        v9 = false;
        return;
    end;
end);
if workspace:GetAttribute("JanzenStorm") then
    task.defer(v26);
else
    v9 = false;
end;
local function v34(v27, v28) --[[ Line: 121 ]] --[[ Name: v34 ]]
    -- upvalues: v6 (copy)
    local v29 = v6.new(v27, v28, 30);
    v29.Thickness = 1.5;
    v29.Color = Color3.fromRGB(139, 205, 255);
    v29.Frequency = 15;
    v29.MinThicknessMultiplier = 0.1;
    v29.MaxThicknessMultiplier = 1;
    task.wait(0.65);
    local v30 = game.ReplicatedStorage.LightningHit:Clone();
    v30.CFrame = CFrame.new(v28.WorldPosition);
    local v31 = workspace:Raycast(v30.CFrame.p, (Vector3.new(-0, -50, -0, -0)));
    if v31 and v31.Position then
        v30.CFrame = CFrame.new(v31.Position);
    end;
    v30.Parent = workspace.WeatherVisuals;
    for _, v33 in pairs(v30:GetDescendants()) do
        if v33:IsA("ParticleEmitter") then
            v33:Emit(v33:GetAttribute("EmitCount"));
        elseif v33:IsA("Sound") then
            v33:Play();
        elseif v33:IsA("PointLight") then
            game.TweenService:Create(v33, TweenInfo.new(3), {
                Range = 0
            }):Play();
        end;
    end;
    v29:DestroyDissipate(0.7);
    game.Debris:AddItem(v30, 3);
end;
local l_GameEvents_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
l_GameEvents_0.LightningBoltWithNoFlash.OnClientEvent:Connect(function(v36) --[[ Line: 152 ]]
    -- upvalues: v34 (copy)
    local l_Attachment_0 = Instance.new("Attachment");
    local l_Attachment_1 = Instance.new("Attachment");
    l_Attachment_0.Parent = workspace.Terrain;
    l_Attachment_1.Parent = workspace.Terrain;
    l_Attachment_1.WorldPosition = v36 + Vector3.new(0, 200, 0, 0);
    l_Attachment_0.WorldPosition = v36;
    v34(l_Attachment_1, l_Attachment_0);
    task.delay(5, function() --[[ Line: 161 ]]
        -- upvalues: l_Attachment_1 (copy), l_Attachment_0 (copy)
        l_Attachment_1:Destroy();
        l_Attachment_0:Destroy();
    end);
end);
l_GameEvents_0.JandelCharge.OnClientEvent:Connect(function(v39) --[[ Line: 167 ]]
    -- upvalues: v6 (copy)
    local l_Lightning_0 = v39["Right Arm"].Lightning;
    local l_Lightning_1 = v39["Left Arm"].Lightning;
    task.wait(0.5);
    local v42 = v6.new(l_Lightning_1, l_Lightning_0, 30);
    v42.Thickness = 30;
    v42.Color = Color3.fromRGB(167, 229, 255);
    v42.Frequency = 15;
    v42.MinThicknessMultiplier = 0.1;
    v42.MaxThicknessMultiplier = 1;
    task.wait(0.5);
    v42:DestroyDissipate(0.3);
end);
return v0;