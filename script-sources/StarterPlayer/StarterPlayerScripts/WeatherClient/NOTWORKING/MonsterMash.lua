-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MonsterMash, time of decompilation: Sun Jun  8 12:59:13 2025 ]]
local v0 = {};
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v7 = require(game.ReplicatedStorage.Modules.NumberUtil);
local v8 = RaycastParams.new();
v8.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v8.FilterType = Enum.RaycastFilterType.Include;
local v10 = false;
local l_Sky_0 = script.Sky;
local v13 = game.Lighting.ColorCorrection:Clone();
v13.Name = script.Name;
v13.Parent = game.Lighting;
local l_SFOTH_0 = script.SFOTH;
local function v25(v15) --[[ Line: 27 ]] --[[ Name: v25 ]]
    local v16 = game.ReplicatedStorage.ShootingStar:Clone();
    v16.CFrame = v15;
    v16.Parent = workspace;
    local v17 = script.Fire:Clone();
    v17.Parent = workspace;
    v17:Play();
    game.Debris:AddItem(v17, 5);
    local v18 = 0;
    while v18 < 1 do
        v18 = v18 + game:GetService("RunService").Heartbeat:Wait();
        v16:PivotTo(v15:Lerp(v15 * CFrame.new(0, 200, 0), v18));
    end;
    for _, v20 in v16:GetDescendants() do
        if v20:IsA("BillboardGui") then
            v20.Enabled = false;
        end;
    end;
    game.Debris:AddItem(v16, 4);
    local v21 = game.ReplicatedStorage.FireworkBoom:Clone();
    v21.Parent = workspace;
    v21.CFrame = v16.CFrame;
    for _, v23 in v21:GetDescendants() do
        if v23:IsA("ParticleEmitter") then
            v23:Emit(v23:GetAttribute("EmitCount"));
        end;
    end;
    local v24 = script.Boom:Clone();
    v24.Parent = workspace;
    v24:Play();
    game.Debris:AddItem(v24, 5);
    game.Debris:AddItem(v21, 10);
end;
local function v87() --[[ Line: 60 ]] --[[ Name: v87 ]]
    -- upvalues: v10 (ref), v13 (copy), v12 (copy), l_Sky_0 (copy), l_CurrentCamera_0 (copy), v25 (copy), l_SFOTH_0 (copy), v7 (copy)
    v10 = true;
    game.TweenService:Create(v13, TweenInfo.new(2), {
        Brightness = 0.1
    }):Play();
    game.TweenService:Create(game.Lighting, TweenInfo.new(2), {
        Ambient = Color3.fromRGB(60, 162, 230), 
        Brightness = 1
    }):Play();
    game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(2), {
        Density = 0.436, 
        Offset = 1, 
        Color = Color3.fromRGB(215, 244, 255), 
        Decay = Color3.fromRGB(190, 238, 255)
    }):Play();
	l_Sky_0.Parent = game.Lighting
    local l_DJJhai_0 = workspace.Visuals:WaitForChild("DJJhai");
    local l_l_DJJhai_0_Pivot_0 = l_DJJhai_0:GetPivot();
    local v28 = l_l_DJJhai_0_Pivot_0 * CFrame.new(0, 85, 0);
    local v29 = 0;
    local l_Humanoid_0 = l_DJJhai_0:WaitForChild("jhailatte"):WaitForChild("Humanoid");
    local v31 = l_Humanoid_0.Animator:LoadAnimation(script.Mash);
    v31.Priority = Enum.AnimationPriority.Action4;
    local v32 = l_Humanoid_0.Animator:LoadAnimation(script.Animation);
    v32:Play();
    local v33 = game.ReplicatedStorage.Assets.DanceFloor:Clone();
    local l_v33_Pivot_0 = v33:GetPivot();
    v33.Parent = workspace;
    local function v37() --[[ Line: 89 ]] --[[ Name: v37 ]]
        -- upvalues: v33 (copy)
        for _, v36 in v33.Colour:GetChildren() do
            v36.Color = Color3.fromHSV(Random.new():NextNumber(0, 1), Random.new():NextNumber(0, 1), 1);
        end;
    end;
    task.spawn(function() --[[ Line: 95 ]]
        -- upvalues: v37 (copy)
        while workspace:GetAttribute("MonsterMash") do
            v37();
            task.wait(1);
        end;
    end);
    while v29 < 2 do
        v29 = v29 + game:GetService("RunService").Heartbeat:Wait();
        local l_Value_0 = game.TweenService:GetValue(v29, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        l_DJJhai_0:PivotTo(l_l_DJJhai_0_Pivot_0:Lerp(v28, l_Value_0));
        v33:PivotTo(l_v33_Pivot_0:Lerp(l_v33_Pivot_0 * CFrame.new(0, 2, 0), l_Value_0));
    end;
    local _ = workspace:GetAttribute("MonsterMashTimer");
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.Volume = 0.6;
    l_Sound_0.Parent = workspace;
    l_Sound_0.SoundId = "rbxassetid://79451196298919";
    l_Sound_0.Looped = true;
    l_Sound_0:Play();
    repeat
        task.wait();
    until workspace:GetAttribute("MonsterMashTimer") or not workspace:GetAttribute("MonsterMash");
    l_Sound_0.Looped = false;
    local v41 = l_Humanoid_0.Animator:LoadAnimation(script.Up);
    local v42 = 0;
    local v43 = false;
    local v44 = false;
    task.spawn(function() --[[ Line: 123 ]]
        -- upvalues: v10 (ref), l_DJJhai_0 (copy), l_Sound_0 (copy), v44 (ref), v43 (ref), l_CurrentCamera_0 (ref), v42 (ref), v32 (copy), v31 (copy), v41 (copy), v13 (ref), v25 (ref)
        local v45 = nil;
        while v10 do
            task.wait(0);
            if l_DJJhai_0:IsDescendantOf(workspace) and l_DJJhai_0:FindFirstChild("DJBooth") then
                l_DJJhai_0.DJBooth.Light.Attachment.PointLight.Color = Color3.fromHSV(tick() / 3 % 1, 1, 1);
            end;
            local v46 = math.clamp((l_Sound_0.PlaybackLoudness - 200) / 700, 0, 1);
            if v44 == true then
                v46 = math.clamp(l_Sound_0.PlaybackLoudness / 700, 0, 1);
            end;
            if v45 and l_Sound_0.PlaybackLoudness / 1000 - v45 > 0.2 and not v43 then
                for _, v48 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
                    v48:Emit(v48:GetAttribute("EmitCount"));
                end;
                local _, v50 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
                if v50 then
                    game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
                        FieldOfView = 68
                    }):Play();
                    task.delay(0.2, function() --[[ Line: 144 ]]
                        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
                            FieldOfView = 70
                        }):Play();
                    end);
                end;
            end;
            v45 = l_Sound_0.PlaybackLoudness / 1000;
            if v46 > 0.45 then
                local v51 = tick();
                v42 = v51;
                if not v43 then
                    v43 = true;
                    if v44 then
                        v32:Stop();
                        v31:Play(0, 10);
                    else
                        v41:Play();
                    end;
                    game.TweenService:Create(v13, TweenInfo.new(0.3), {
                        TintColor = Color3.fromRGB(226, 192, 255), 
                        Brightness = 0.5
                    }):Play();
                    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
                        FieldOfView = 90
                    }):Play();
                    for _, v53 in l_DJJhai_0.Pyro:GetDescendants() do
                        if v53:IsA("ParticleEmitter") then
                            v53.Enabled = true;
                            task.delay(1.5, function() --[[ Line: 173 ]]
                                -- upvalues: v53 (copy)
                                v53.Enabled = false;
                            end);
                        end;
                    end;
                    for _, v55 in l_DJJhai_0.Confetti:GetDescendants() do
                        v55:Emit(v55:GetAttribute("EmitCount"));
                    end;
                    task.spawn(function() --[[ Line: 182 ]]
                        -- upvalues: l_DJJhai_0 (ref), v25 (ref)
                        for _, v57 in l_DJJhai_0.SpawnPoints:GetChildren() do
                            task.spawn(function() --[[ Line: 185 ]]
                                -- upvalues: v25 (ref), v57 (copy)
                                v25(v57.CFrame);
                            end);
                            task.wait(0.1);
                        end;
                    end);
                    task.delay(3, function() --[[ Line: 192 ]]
                        -- upvalues: v13 (ref)
                        game.TweenService:Create(v13, TweenInfo.new(3), {
                            TintColor = Color3.fromRGB(255, 255, 255), 
                            Brightness = 0.1
                        }):Play();
                    end);
                    task.spawn(function() --[[ Line: 199 ]]
                        -- upvalues: v43 (ref), l_DJJhai_0 (ref), l_CurrentCamera_0 (ref)
                        while v43 and l_DJJhai_0 and l_DJJhai_0:IsDescendantOf(workspace) do
                            for _, v59 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
                                v59:Emit(v59:GetAttribute("EmitCount"));
                            end;
                            local _, v61 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
                            if v61 then
                                game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
                                    FieldOfView = 68
                                }):Play();
                                task.delay(0.2, function() --[[ Line: 210 ]]
                                    game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
                                        FieldOfView = 70
                                    }):Play();
                                end);
                            end;
                            task.wait(0.5);
                        end;
                    end);
                end;
                task.delay(1, function() --[[ Line: 220 ]]
                    -- upvalues: v42 (ref), v51 (copy), v44 (ref), v43 (ref), v41 (ref), v31 (ref), v32 (ref)
                    if v42 == v51 then
                        if v44 then
                            repeat
                                task.wait();
                            until v44 == false;
                        end;
                        v43 = false;
                        v41:Stop();
                        v31:Stop();
                        v32:Play();
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
        until not workspace:GetAttribute("MonsterMash");
        game.TweenService:Create(l_Sound_0, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(2, function() --[[ Line: 254 ]]
            -- upvalues: l_Sound_0 (ref)
            l_Sound_0:Destroy();
        end);
        local v64 = 0;
        while v64 < 2 do
            v64 = v64 + game:GetService("RunService").Heartbeat:Wait();
            local l_Value_1 = game.TweenService:GetValue(v64, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            l_DJJhai_0:PivotTo(v28:Lerp(l_l_DJJhai_0_Pivot_0, l_Value_1));
            v33:PivotTo((l_v33_Pivot_0 * CFrame.new(0, 2, 0)):Lerp(l_v33_Pivot_0, l_Value_1));
        end;
        v33:Destroy();
        v41:Destroy();
        v32:Destroy();
        if l_DJJhai_0 then
            l_DJJhai_0:Destroy();
        end;
		l_Sky_0.Parent = script
		l_SFOTH_0.Parent = script
        game.TweenService:Create(v13, TweenInfo.new(3), {
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
        if workspace:GetAttribute("MonsterMashCurrentClock") then
            l_FirstChild_0.Text = v7.compactFormat(workspace:GetAttribute("MonsterMashCurrentClock"));
        end;
        task.wait(1);
    until workspace:GetAttribute("MonsterMashCurrentClock") <= 0;
    game.TweenService:Create(l_DJJhai_0.Screen, TweenInfo.new(1), {
        CFrame = l_DJJhai_0.Screen.CFrame * CFrame.new(0, -200, 0)
    }):Play();
    l_DJJhai_0.Screen:Destroy();
    game.TweenService:Create(l_Sound_0, TweenInfo.new(1), {
        Volume = 0
    }):Play();
    task.delay(0.3, function() --[[ Line: 306 ]]
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
        task.delay(0.05, function() --[[ Line: 338 ]]
            game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.05), {
                FieldOfView = 70
            }):Play();
        end);
        task.wait(0.15);
    end;
    for _, v74 in l_DJJhai_0.Pyro:GetDescendants() do
        if v74:IsA("ParticleEmitter") then
            v74.Enabled = true;
            task.delay(1.5, function() --[[ Line: 348 ]]
                -- upvalues: v74 (copy)
                v74.Enabled = false;
            end);
        end;
    end;
    task.spawn(function() --[[ Line: 354 ]]
        -- upvalues: l_DJJhai_0 (copy), v25 (ref)
        local v75 = {};
        for v76, v77 in l_DJJhai_0.SpawnPoints:GetChildren() do
            task.spawn(function() --[[ Line: 358 ]]
                -- upvalues: v25 (ref), v77 (copy)
                v25(v77.CFrame);
            end);
            v75[#l_DJJhai_0.SpawnPoints:GetChildren() - (v76 - 1)] = v77.CFrame;
            task.wait(0.1);
        end;
        for _, v79 in v75 do
            task.spawn(function() --[[ Line: 366 ]]
                -- upvalues: v25 (ref), v79 (copy)
                v25(v79);
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
        game.TweenService:Create(v13, TweenInfo.new(0.3), {
            TintColor = Color3.fromRGB(219, 188, 255), 
            Brightness = 0.3
        }):Play();
        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = 68
        }):Play();
        task.delay(0.05, function() --[[ Line: 388 ]]
            -- upvalues: v13 (ref)
            game.TweenService:Create(v13, TweenInfo.new(0.3), {
                TintColor = Color3.fromRGB(255, 255, 255), 
                Brightness = 0.1
            }):Play();
            game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.4), {
                FieldOfView = 70
            }):Play();
        end);
    end;
    task.wait(0.5);
    l_Sound_0.SoundId = "rbxassetid://95780928979580";
    l_Sound_0.TimePosition = 0;
    l_Sound_0.Volume = 3;
    l_Sound_0:Play();
    task.delay(30, function() --[[ Line: 404 ]]
        -- upvalues: l_DJJhai_0 (copy), v44 (ref), v13 (ref), v12 (ref), l_Sky_0 (ref), l_SFOTH_0 (ref)
        for _, v83 in l_DJJhai_0.jhailatte:GetDescendants() do
            if v83:IsA("ParticleEmitter") then
                v83.Color = ColorSequence.new(Color3.fromRGB(254, 119, 0));
            end;
        end;
        v44 = true;
        for _, v85 in l_DJJhai_0.BassDrop:GetDescendants() do
            if v85:IsA("ParticleEmitter") then
                v85:Emit(v85:GetAttribute("EmitCount"));
            end;
        end;
        game.TweenService:Create(game.Lighting, TweenInfo.new(0.3), {
            Ambient = Color3.fromRGB(230, 145, 26)
        }):Play();
        game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.3), {
            Density = 0.338, 
            Offset = 0, 
            Color = Color3.fromRGB(255, 157, 0), 
            Decay = Color3.fromRGB(255, 204, 2)
        }):Play();
        game.TweenService:Create(v13, TweenInfo.new(0.3), {
            TintColor = Color3.fromRGB(255, 169, 83), 
            Brightness = 0.7
        }):Play();
        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = 90
        }):Play();
        task.delay(0.3, function() --[[ Line: 433 ]]
            -- upvalues: v12 (ref), l_Sky_0 (ref), l_SFOTH_0 (ref), l_DJJhai_0 (ref), v13 (ref)
			l_Sky_0.Parent = script
			l_SFOTH_0.Parent = game.Lighting
            l_DJJhai_0.DJBooth.Smoke.OutwardSmoke.Enabled = true;
            game.TweenService:Create(v13, TweenInfo.new(1), {
                TintColor = Color3.fromRGB(255, 255, 255), 
                Brightness = 0.1
            }):Play();
            game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
        end);
        local v86 = game.ReplicatedStorage.Assets.DJJhaiFence:Clone();
        v86.Parent = workspace;
        repeat
            task.wait();
        until not workspace:GetAttribute("MonsterMash");
        v86:Destroy();
    end);
end;
workspace:GetAttributeChangedSignal("MonsterMash"):Connect(function() --[[ Line: 454 ]]
    -- upvalues: v87 (copy), v10 (ref)
    if workspace:GetAttribute("MonsterMash") then
        v87();
        return;
    else
        v10 = false;
        return;
    end;
end);
if workspace:GetAttribute("MonsterMash") then
    task.defer(v87);
else
    v10 = false;
end;
return v0;