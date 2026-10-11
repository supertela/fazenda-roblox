-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JandelLazer, time of decompilation: Sun Jun  8 12:59:13 2025 ]]
local v0 = {};
local v2 = false;
local l_Sky_0 = script.Sky;
local v5 = require(game.ReplicatedStorage.Code.CameraShaker);
local v6 = game.Lighting.ColorCorrection:Clone();
v6.Name = script.Name;
v6.Parent = game.Lighting;
local v8 = v5.new(Enum.RenderPriority.Camera.Value, function(v7) --[[ Line: 12 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v7;
end);
v8:Start();
local function v39()
    v2 = true;
    task.spawn(function() --[[ Line: 20 ]]
        -- upvalues: v8 (ref), v5 (ref), v6 (ref)
        v8:Shake(v5.Presets.Explosion);
        game.TweenService:Create(v6, TweenInfo.new(0.3), {
            TintColor = Color3.fromRGB(255, 219, 201), 
            Brightness = 0.5
        }):Play();
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
            FieldOfView = 90
        }):Play();
        task.wait(0.3);
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
            FieldOfView = 70
        }):Play();
        game.TweenService:Create(v6, TweenInfo.new(3), {
            TintColor = Color3.fromRGB(255, 255, 255), 
            Brightness = 0
        }):Play();
    end);
	local v10 = script.jandel
	v10.Parent = workspace.Visuals
    local v12 = game.ReplicatedStorage.LazerEyes:Clone();
    v12.Parent = workspace.Visuals;
    local v13 = game.ReplicatedStorage.Assets.beamTrail:Clone();
    v13.Parent = workspace.Visuals;
    local function v29(v14) --[[ Line: 45 ]] --[[ Name: v29 ]]
        -- upvalues: v12 (copy), v10 (copy), v13 (copy)
        local v15 = RaycastParams.new();
        v15.FilterDescendantsInstances = {
            workspace.Baseplate.TopBaseplate
        };
        v15.FilterType = Enum.RaycastFilterType.Include;
        if workspace.Visuals:FindFirstChild("LazerSpot") then
            local v16 = v12:GetPivot():Lerp(workspace.Visuals.LazerSpot.CFrame, v14 * 5);
            local v17 = CFrame.new(v16.Position, v10:GetPivot().p);
            local l_v10_Pivot_1 = v10:GetPivot();
            local v19 = CFrame.new(l_v10_Pivot_1.Position, workspace.Visuals.LazerSpot.Position);
            local l_Unit_0 = (v10.Head.CFrame.LookVector + CFrame.new(v10.Head.Position, v16.Position).LookVector * 150).Unit;
            local v21 = (v10.Head.Position - workspace.Visuals.LazerSpot.Position).Magnitude * 1.2;
            local v22 = workspace:Raycast(v10.Head.CFrame.Position, l_Unit_0 * v21, v15);
            if not v22 then
                v10:PivotTo(l_v10_Pivot_1:Lerp(v19, v14 * 5));
                v12:PivotTo(v17);
                for _, v24 in v13:GetChildren() do
                    if v24:IsA("Trail") then
                        v24.Enabled = false;
                    end;
                end;
                v13.CFrame = CFrame.new(v12:GetPivot().Position) * CFrame.new(0, 0, -0.1);
                return;
            else
                v10:PivotTo(l_v10_Pivot_1:Lerp(v19, v14 * 5));
                v12:PivotTo(CFrame.new(v22.Position, v10:GetPivot().p) * CFrame.Angles(0, 4.71238898038469, 0));
                for _, v26 in v13:GetChildren() do
                    if v26:IsA("Trail") then
                        v26.Enabled = true;
                    end;
                end;
                local l_CFrame_0 = v13.CFrame;
                local v28 = CFrame.new(v12:GetPivot().Position, l_CFrame_0.Position).LookVector * Vector3.new(1, 0, 1, 0);
                v13.CFrame = CFrame.new(v12:GetPivot().Position, v12:GetPivot().Position + v22.Normal + v28) * CFrame.new(0, 0, -0.1);
            end;
        end;
    end;
    local _ = v10:GetPivot().Position;
    local l_v12_FirstChild_0 = v12:FindFirstChild("LeftEye", true);
    local l_v12_FirstChild_1 = v12:FindFirstChild("RightEye", true);
    for _, v34 in l_v12_FirstChild_0:GetDescendants() do
        if v34:IsA("Beam") then
            v34.Attachment0 = v10:FindFirstChild("LeftEye", true);
        end;
    end;
    for _, v36 in l_v12_FirstChild_1:GetDescendants() do
        if v36:IsA("Beam") then
            v36.Attachment0 = v10:FindFirstChild("RightEye", true);
        end;
    end;
    v29(1);
    local v37 = false;
    task.spawn(function() --[[ Line: 99 ]]
        -- upvalues: v2 (ref), v29 (copy), v12 (copy), v13 (copy), v4 (ref), l_Sky_0 (ref), v6 (ref)
        while v2 do
            local v38 = game:GetService("RunService").Heartbeat:Wait();
            v29(v38);
        end;
        v12:Destroy();
        game.Debris:AddItem(v13, 10);
		l_Sky_0.Parent = script
        game.TweenService:Create(v6, TweenInfo.new(3), {
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
        task.delay(3, function() --[[ Line: 121 ]]
            game.Workspace.Terrain.Clouds.Enabled = false;
        end);
    end);
    repeat
        task.wait();
    until v2 == false;
	v37 = true;
	v10.Parent = script
    game.Debris:AddItem(v13, 3);
    v12:Destroy();
end;
workspace:GetAttributeChangedSignal("JandelLazer"):Connect(function() --[[ Line: 132 ]]
    -- upvalues: v39 (copy), v2 (ref)
    if workspace:GetAttribute("JandelLazer") then
        v39();
        return;
    else
        v2 = false;
        return;
    end;
end);
if workspace:GetAttribute("JandelLazer") then
    task.defer(v39);
else
    v2 = false;
end;
return v0;