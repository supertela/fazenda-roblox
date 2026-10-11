-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MeteorShower, time of decompilation: Sun Jun  8 12:59:12 2025 ]]
local v0 = {};
local _ = {};
local l_RainParticle_0 = game.ReplicatedStorage.RainParticle;
local _ = Random.new();
local _ = workspace.CurrentCamera;
local v5 = RaycastParams.new();
v5.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v5.FilterType = Enum.RaycastFilterType.Include;
local v6 = {};
local v7 = false;
local function _(v8) --[[ Line: 16 ]] --[[ Name: _ ]]
    -- upvalues: l_RainParticle_0 (copy), v6 (copy)
    local v9 = {
        particle = l_RainParticle_0:Clone(), 
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
local l_Sky_0 = script.Sky;
local v12 = game.Lighting.ColorCorrection:Clone();
v12.Name = script.Name;
v12.Parent = game.Lighting;
local function v13() --[[ Line: 35 ]] --[[ Name: v13 ]]
    -- upvalues: v7 (ref)
    v7 = true;
    task.spawn(function() --[[ Line: 38 ]]

    end);
end;
workspace:GetAttributeChangedSignal("MeteorShower"):Connect(function() --[[ Line: 42 ]]
    -- upvalues: v7 (ref)
    if workspace:GetAttribute("MeteorShower") then
        v7 = true;
        task.spawn(function() --[[ Line: 46 ]]

        end);
        return;
    else
        v7 = false;
        return;
    end;
end);
game.ReplicatedStorage.RainSplash:Clone().Parent = workspace.WeatherVisuals;
local l_GameEvents_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
if workspace:GetAttribute("MeteorShower") then
    task.defer(v13);
else
    v7 = false;
end;
local v16 = require(game.ReplicatedStorage.Code.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(v15) --[[ Line: 62 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v15;
end);
local function v23(v17, v18) --[[ Line: 65 ]] --[[ Name: v23 ]]
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Anchored = true;
    l_Part_0.CanCollide = false;
    l_Part_0.Transparency = 1;
    l_Part_0.Size = Vector3.new(1, 1, 1, 0);
    l_Part_0.CFrame = CFrame.new(v17 + Vector3.new(0, 4, 0, 0));
    l_Part_0.Parent = workspace.WeatherVisuals;
    local v20 = Instance.new("Attachment", l_Part_0);
    local l_Attachment_0 = Instance.new("Attachment");
    l_Attachment_0.Name = "MeteorTracker";
    l_Attachment_0.Parent = v18;
    local l_Beam_0 = Instance.new("Beam");
    l_Beam_0.Attachment0 = v20;
    l_Beam_0.Attachment1 = l_Attachment_0;
    l_Beam_0.Width0 = 0.5;
    l_Beam_0.Width1 = 0.1;
    l_Beam_0.LightEmission = 1;
    l_Beam_0.TextureSpeed = 5;
    l_Beam_0.Color = ColorSequence.new(Color3.fromRGB(100, 200, 255));
    l_Beam_0.Transparency = NumberSequence.new(0.2);
    l_Beam_0.FaceCamera = true;
    l_Beam_0.Parent = l_Part_0;
    return l_Part_0;
end;
local function v48(v24, v25) --[[ Line: 90 ]] --[[ Name: v49 ]]
    -- upvalues: v23 (copy), v16 (copy)
    local v26 = math.rad((math.random(0, 360)));
    local v27 = Vector3.new(math.cos(v26), 0, (math.sin(v26)));
    local v28 = math.random(300, 500);
    local v29 = math.random(250, 350);
    local v30 = v24 + (v27 * v28 + Vector3.new(0, v29, 0));
    local v31 = v25 or v24;
    local v32 = game.ReplicatedStorage.ShootingStar:Clone();
    v32.CFrame = CFrame.new(v30, v24);
    v32.Parent = workspace.WeatherVisuals;
    local v33 = nil;
    if v25 then
        v33 = v23(v25, v32);
    end;
    local v34 = (v31 - v30).Magnitude / 300;
    local v35 = 0;
    local v36 = false;
    local l_v24_0 = v24;
    local v38 = false;
    while v35 < v34 do
        local v39 = task.wait();
        v35 = v35 + v39;
        if v34 - v35 < 3.5 and not v38 then
            v38 = true;
            if Random.new():NextInteger(1, 2) == 1 then
                v32.StarFallSFX_02_GrowAGarden:Play();
            else
                v32.StarFallSFX_01_GrowAGarden:Play();
            end;
        end;
        local l_Position_0 = v32.Position;
        local l_Magnitude_0 = (v31 - l_Position_0).Magnitude;
        if v25 and not v36 and l_Magnitude_0 <= 80 then
            l_v24_0 = v31;
            v36 = true;
        end;
        local v42 = l_Position_0 + (l_v24_0 - l_Position_0).Unit * 300 * v39;
        v32.CFrame = CFrame.new(v42, l_v24_0);
    end;
    for _, v44 in v32:GetDescendants() do
        if v44:IsA("BillboardGui") then
            v44.Enabled = false;
        end;
    end;
    v16:Shake(v16.Presets.Explosion);
    local v45 = game.ReplicatedStorage.StarHit:Clone();
    v45.CFrame = CFrame.new(v31);
    v45.Parent = workspace.WeatherVisuals;
    for _, v47 in v45:GetDescendants() do
        if v47:IsA("ParticleEmitter") then
            v47:Emit(v47:GetAttribute("EmitCount"));
        elseif v47:IsA("Sound") then
            v47:Play();
        elseif v47:IsA("PointLight") then
            game.TweenService:Create(v47, TweenInfo.new(3), {
                Range = 0
            }):Play();
        end;
    end;
    game.Debris:AddItem(v32, 3);
    game.Debris:AddItem(v45, 3);
    if v33 then
        game.Debris:AddItem(v33, 1);
    end;
end;
l_GameEvents_0.MeteorShower.OnClientEvent:Connect(function(v49, v50) --[[ Line: 157 ]]
    -- upvalues: v48 (copy)
    v48(v49, v50);
end);
return v0;