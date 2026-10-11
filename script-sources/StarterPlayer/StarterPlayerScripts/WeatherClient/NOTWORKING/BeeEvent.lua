-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BeeEvent, time of decompilation: Sun Jun  8 12:59:14 2025 ]]
local v0 = {};
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v7 = require(game.ReplicatedStorage.Modules.NumberUtil);
local v8 = require(game.ReplicatedStorage.Modules.CutsceneService);
local v9 = RaycastParams.new();
v9.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v9.FilterType = Enum.RaycastFilterType.Include;
local _ = {};
local v11 = false;
local l_Sky_0 = script.Sky;
local v14 = game.Lighting.ColorCorrection:Clone();
v14.Name = script.Name;
v14.Parent = game.Lighting;
local l_SFOTH_0 = script.SFOTH;
local function v26(v16) --[[ Line: 28 ]] --[[ Name: v26 ]]
    local v17 = game.ReplicatedStorage.ShootingStar:Clone();
    v17.CFrame = v16;
    v17.Parent = workspace;
    local v18 = script.Fire:Clone();
    v18.Parent = workspace;
    v18:Play();
    game.Debris:AddItem(v18, 5);
    local v19 = 0;
    while v19 < 1 do
        v19 = v19 + game:GetService("RunService").Heartbeat:Wait();
        v17:PivotTo(v16:Lerp(v16 * CFrame.new(0, 200, 0), v19));
    end;
    for _, v21 in v17:GetDescendants() do
        if v21:IsA("BillboardGui") then
            v21.Enabled = false;
        end;
    end;
    game.Debris:AddItem(v17, 4);
    local v22 = game.ReplicatedStorage.FireworkBoom:Clone();
    v22.Parent = workspace;
    v22.CFrame = v17.CFrame;
    for _, v24 in v22:GetDescendants() do
        if v24:IsA("ParticleEmitter") then
            v24:Emit(v24:GetAttribute("EmitCount"));
        end;
    end;
    local v25 = script.Boom:Clone();
    v25.Parent = workspace;
    v25:Play();
    game.Debris:AddItem(v25, 5);
    game.Debris:AddItem(v22, 10);
end;
local function v82() --[[ Line: 61 ]] --[[ Name: v82 ]]
    -- upvalues: v11 (ref), v14 (copy), v13 (copy), l_Sky_0 (copy), l_CurrentCamera_0 (copy), v26 (copy), l_SFOTH_0 (copy), v7 (copy), v8 (copy)
    v11 = true;
    game.TweenService:Create(v14, TweenInfo.new(2), {
        Brightness = 0
    }):Play();
    game.TweenService:Create(game.Lighting, TweenInfo.new(2), {
        Ambient = Color3.fromRGB(230, 211, 141), 
        Brightness = 1
    }):Play();
	l_Sky_0.Parent = game.Lighting
    local l_DJJhai_0 = workspace.Visuals:WaitForChild("DJJhai");
    local l_l_DJJhai_0_Pivot_0 = l_DJJhai_0:GetPivot();
    local v29 = l_l_DJJhai_0_Pivot_0 * CFrame.new(0, 85, 0);
    local v30 = 0;
    local l_Humanoid_0 = l_DJJhai_0:WaitForChild("jhailatte"):WaitForChild("Humanoid");
    local v32 = l_Humanoid_0.Animator:LoadAnimation(script.Mash);
    v32.Priority = Enum.AnimationPriority.Action4;
    local v33 = l_Humanoid_0.Animator:LoadAnimation(script.Animation);
    v33:Play();
    local v34 = game.ReplicatedStorage.Assets.DanceFloor:Clone();
    local l_v34_Pivot_0 = v34:GetPivot();
    v34.Parent = workspace;
    local function v38() --[[ Line: 84 ]] --[[ Name: v38 ]]
        -- upvalues: v34 (copy)
        for _, v37 in v34.Colour:GetChildren() do
            v37.Color = Color3.fromHSV(Random.new():NextNumber(0, 1), Random.new():NextNumber(0, 1), 1);
        end;
    end;
    task.spawn(function() --[[ Line: 90 ]]
        -- upvalues: v38 (copy)
        while workspace:GetAttribute("BeeEvent") do
            v38();
            task.wait(1);
        end;
    end);
    while v30 < 2 do
        v30 = v30 + game:GetService("RunService").Heartbeat:Wait();
        local l_Value_0 = game.TweenService:GetValue(v30, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        l_DJJhai_0:PivotTo(l_l_DJJhai_0_Pivot_0:Lerp(v29, l_Value_0));
        v34:PivotTo(l_v34_Pivot_0:Lerp(l_v34_Pivot_0 * CFrame.new(0, 2, 0), l_Value_0));
    end;
    local _ = workspace:GetAttribute("BeeEventTimer");
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.Volume = 0.6;
    l_Sound_0.Parent = workspace;
    l_Sound_0.SoundId = "rbxassetid://138407858204990";
    l_Sound_0.Looped = true;
    l_Sound_0:Play();
    repeat
        task.wait();
    until workspace:GetAttribute("BeeEventTimer") or not workspace:GetAttribute("BeeEvent");
    local v42 = l_Humanoid_0.Animator:LoadAnimation(script.Up);
    local v43 = 0;
    local v44 = false;
    task.spawn(function() --[[ Line: 116 ]]
        -- upvalues: v11 (ref), l_DJJhai_0 (copy), l_Sound_0 (copy), v44 (ref), l_CurrentCamera_0 (ref), v43 (ref), v42 (copy), v14 (ref), v26 (ref), v32 (copy), v33 (copy)
        local v45 = nil;
        while v11 do
            task.wait(0);
            if l_DJJhai_0:IsDescendantOf(workspace) and l_DJJhai_0:FindFirstChild("DJBooth") then
                l_DJJhai_0.DJBooth.Light.Attachment.PointLight.Color = Color3.fromHSV(tick() / 3 % 1, 1, 1);
            end;
            local v46 = math.clamp((l_Sound_0.PlaybackLoudness - 200) / 700, 0, 1);
            if v45 and l_Sound_0.PlaybackLoudness / 1000 - v45 > 0.2 and not v44 then
                for _, v48 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
                    v48:Emit(v48:GetAttribute("EmitCount"));
                end;
                local _, v50 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
                if v50 then
                    game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
                        FieldOfView = 68
                    }):Play();
                    task.delay(0.2, function() --[[ Line: 134 ]]
                        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
                            FieldOfView = 70
                        }):Play();
                    end);
                end;
            end;
            v45 = l_Sound_0.PlaybackLoudness / 1000;
            if v46 > 0.45 then
                local v51 = tick();
                v43 = v51;
                if not v44 then
                    v44 = true;
                    v42:Play();
                    game.TweenService:Create(v14, TweenInfo.new(0.3), {
                        TintColor = Color3.fromRGB(255, 250, 176), 
                        Brightness = 0.2
                    }):Play();
                    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
                        FieldOfView = 90
                    }):Play();
                    for _, v53 in l_DJJhai_0.Pyro:GetDescendants() do
                        if v53:IsA("ParticleEmitter") then
                            v53.Enabled = true;
                            task.delay(1.5, function() --[[ Line: 158 ]]
                                -- upvalues: v53 (copy)
                                v53.Enabled = false;
                            end);
                        end;
                    end;
                    for _, v55 in l_DJJhai_0.Confetti:GetDescendants() do
                        v55:Emit(v55:GetAttribute("EmitCount"));
                    end;
                    task.spawn(function() --[[ Line: 167 ]]
                        -- upvalues: l_DJJhai_0 (ref), v26 (ref)
                        for _, v57 in l_DJJhai_0.SpawnPoints:GetChildren() do
                            task.spawn(function() --[[ Line: 170 ]]
                                -- upvalues: v26 (ref), v57 (copy)
                                v26(v57.CFrame);
                            end);
                            task.wait(0.1);
                        end;
                    end);
                    task.delay(3, function() --[[ Line: 177 ]]
                        -- upvalues: v14 (ref)
                        game.TweenService:Create(v14, TweenInfo.new(3), {
                            TintColor = Color3.fromRGB(255, 255, 255), 
                            Brightness = 0
                        }):Play();
                    end);
                    task.spawn(function() --[[ Line: 184 ]]
                        -- upvalues: v44 (ref), l_DJJhai_0 (ref), l_CurrentCamera_0 (ref)
                        while v44 and l_DJJhai_0 and l_DJJhai_0:IsDescendantOf(workspace) do
                            for _, v59 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
                                v59:Emit(v59:GetAttribute("EmitCount"));
                            end;
                            local _, v61 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
                            if v61 then
                                game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
                                    FieldOfView = 68
                                }):Play();
                                task.delay(0.2, function() --[[ Line: 195 ]]
                                    game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
                                        FieldOfView = 70
                                    }):Play();
                                end);
                            end;
                            task.wait(0.5);
                        end;
                    end);
                end;
                task.delay(1, function() --[[ Line: 205 ]]
                    -- upvalues: v43 (ref), v51 (copy), v44 (ref), v42 (ref), v32 (ref), v33 (ref)
                    if v43 == v51 then
                        v44 = false;
                        v42:Stop();
                        v32:Stop();
                        v33:Play();
                    end;
                end);
            end;
            for _, v63 in l_DJJhai_0.DJBooth.Speakers:GetChildren() do
                if v63:IsA("BasePart") then
                    v63.Mesh.Offset = Vector3.new(0, v46 * -1.4, 0);
                    v63.Mesh.Scale = Vector3.new(1, 1, 1, 0) * (v46 * 0.4 + 1);
                end;
            end;
        end;
    end);
    task.spawn(function()
        repeat
            task.wait();
        until not workspace:GetAttribute("BeeEvent");
        game.TweenService:Create(l_Sound_0, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(2, function() --[[ Line: 234 ]]
            -- upvalues: l_Sound_0 (ref)
            l_Sound_0:Destroy();
        end);
        local v64 = 0;
        while v64 < 2 do
            v64 = v64 + game:GetService("RunService").Heartbeat:Wait();
            local l_Value_1 = game.TweenService:GetValue(v64, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            l_DJJhai_0:PivotTo(v29:Lerp(l_l_DJJhai_0_Pivot_0, l_Value_1));
            v34:PivotTo((l_v34_Pivot_0 * CFrame.new(0, 2, 0)):Lerp(l_v34_Pivot_0, l_Value_1));
        end;
        v34:Destroy();
        v42:Destroy();
        v33:Destroy();
        if l_DJJhai_0 then
            l_DJJhai_0:Destroy();
        end;
		l_Sky_0.Parent = script
		l_SFOTH_0.Parent = script
        game.TweenService:Create(v14, TweenInfo.new(3), {
            Brightness = 0, 
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
            Ambient = game.Lighting:GetAttribute("DefaultAmbient"), 
            ExposureCompensation = game.Lighting:GetAttribute("DefaultExposure"), 
            Brightness = game.Lighting:GetAttribute("DefaultBrightness")
        }):Play();
        game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(3), {
            Density = 0, 
            Offset = 0, 
            Color = Color3.fromRGB(215, 244, 255), 
            Decay = Color3.fromRGB(190, 238, 255)
        }):Play();
    end);
    local l_FirstChild_0 = l_DJJhai_0.Screen:FindFirstChild("Timer", true);
    repeat
        if workspace:GetAttribute("BeeEventCurrentClock") then
            l_FirstChild_0.Text = v7.compactFormat(workspace:GetAttribute("BeeEventCurrentClock"));
        end;
        task.wait(1);
    until workspace:GetAttribute("BeeEventCurrentClock") <= 0;
    game.TweenService:Create(l_DJJhai_0.Screen, TweenInfo.new(1), {
        CFrame = l_DJJhai_0.Screen.CFrame * CFrame.new(0, -200, 0)
    }):Play();
    l_DJJhai_0.Screen:Destroy();
    game.TweenService:Create(l_Sound_0, TweenInfo.new(1), {
        Volume = 0
    }):Play();
    task.delay(0.3, function() --[[ Line: 286 ]]
        -- upvalues: l_Sound_0 (copy)
        l_Sound_0:Stop();
    end);
    local v67 = script["Dj Scratch Effect"]:Clone();
    v67.SoundId = "rbxassetid://1846552051";
    v67.Parent = workspace;
    v67:Play();
    game.Debris:AddItem(v67, 5);
    game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(2), {
        FieldOfView = 65
    }):Play();
    task.wait(2);
    local v68 = script.Impact:Clone();
    v68.SoundId = "rbxassetid://9125402735";
    v68.Parent = workspace;
    v68:Play();
    game.Debris:AddItem(v68, 7);
    for _ = 1, 4 do
        for _, v71 in l_DJJhai_0.Pyro:GetDescendants() do
            if v71:IsA("ParticleEmitter") then
                v71:Emit(15);
            end;
        end;
        local v72 = script["Air Horn Sound Effect"]:Clone();
        v72.SoundId = "rbxassetid://1542459939";
        v72.Parent = workspace;
        game.Debris:AddItem(v72, 4);
        v72:Play();
        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.1), {
            FieldOfView = 68
        }):Play();
        task.delay(0.05, function() --[[ Line: 318 ]]
            game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.05), {
                FieldOfView = 70
            }):Play();
        end);
        task.wait(0.15);
    end;
    for _, v74 in l_DJJhai_0.Pyro:GetDescendants() do
        if v74:IsA("ParticleEmitter") then
            v74.Enabled = true;
            task.delay(1.5, function() --[[ Line: 328 ]]
                -- upvalues: v74 (copy)
                v74.Enabled = false;
            end);
        end;
    end;
    task.spawn(function() --[[ Line: 334 ]]
        -- upvalues: l_DJJhai_0 (copy), v26 (ref)
        local v75 = {};
        for v76, v77 in l_DJJhai_0.SpawnPoints:GetChildren() do
            task.spawn(function() --[[ Line: 338 ]]
                -- upvalues: v26 (ref), v77 (copy)
                v26(v77.CFrame);
            end);
            v75[#l_DJJhai_0.SpawnPoints:GetChildren() - (v76 - 1)] = v77.CFrame;
            task.wait(0.1);
        end;
        for _, v79 in v75 do
            task.spawn(function() --[[ Line: 346 ]]
                -- upvalues: v26 (ref), v79 (copy)
                v26(v79);
            end);
            task.wait(0.1);
        end;
    end);
    task.wait(2);
    local v80 = script.Countdown:Clone();
    v80.SoundId = "rbxassetid://122907949849153";
    v80.Parent = workspace;
    v80:Play();
    game.Debris:AddItem(v80, 5);
    for _ = 1, 5 do
        task.wait(1);
        game.TweenService:Create(v14, TweenInfo.new(0.3), {
            TintColor = Color3.fromRGB(255, 226, 111), 
            Brightness = 0.2
        }):Play();
        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = 68
        }):Play();
        task.delay(0.05, function() --[[ Line: 368 ]]
            -- upvalues: v14 (ref)
            game.TweenService:Create(v14, TweenInfo.new(0.3), {
                TintColor = Color3.fromRGB(255, 255, 255), 
                Brightness = 0
            }):Play();
            game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.4), {
                FieldOfView = 70
            }):Play();
        end);
    end;
    task.wait(0.5);
    print("Play Bee Cutscene");
    v8.Play(game.ReplicatedStorage.Assets.Cutscenes.BeeCutscene);
end;
workspace:GetAttributeChangedSignal("BeeEvent"):Connect(function() --[[ Line: 383 ]]
    -- upvalues: v82 (copy), v11 (ref)
    if workspace:GetAttribute("BeeEvent") then
        v82();
        return;
    else
        v11 = false;
        return;
    end;
end);
if workspace:GetAttribute("BeeEvent") then
    task.defer(v82);
else
    v11 = false;
end;
return v0;