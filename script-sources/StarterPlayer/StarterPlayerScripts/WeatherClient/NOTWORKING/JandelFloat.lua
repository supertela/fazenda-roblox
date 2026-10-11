-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JandelFloat, time of decompilation: Sun Jun  8 12:59:14 2025 ]]
local v0 = {};
local _ = {};
local v2 = false;
local l_Sky_0 = script.Sky;
local v4 = require(game.ReplicatedStorage.Modules.SkyboxManager);
local _ = require(game.ReplicatedStorage.Code.CameraShaker);
local v6 = game.Lighting.ColorCorrection:Clone();
v6.Name = script.Name;
v6.Parent = game.Lighting;
v4.AddSkybox(l_Sky_0, 0);
local function v16() --[[ Line: 14 ]] --[[ Name: v16 ]]
    -- upvalues: v2 (ref), v4 (copy), l_Sky_0 (copy), v6 (copy)
    v2 = true;
    v4.UpdateSkybox(l_Sky_0, 2);
    local _ = tick();
    local l_jandel_0 = workspace.Visuals:WaitForChild("jandel");
    local l_l_jandel_0_Pivot_0 = l_jandel_0:GetPivot();
    local v10 = 0;
    local v11 = l_l_jandel_0_Pivot_0 * CFrame.new(0, 160, 0);
    game.TweenService:Create(v6, TweenInfo.new(2), {
        Brightness = 0.15, 
        TintColor = Color3.fromRGB(255, 234, 215)
    }):Play();
    local l_Humanoid_0 = l_jandel_0:WaitForChild("Humanoid");
    local l_Animation_0 = Instance.new("Animation");
    l_Animation_0.AnimationId = "rbxassetid://136004572376763";
    local v14 = l_Humanoid_0:LoadAnimation(l_Animation_0);
    v14.Looped = true;
    v14:Play();
    game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
        Ambient = Color3.fromRGB(163, 151, 109)
    }):Play();
    while v10 < 3 do
        v10 = v10 + game:GetService("RunService").Heartbeat:Wait();
        l_jandel_0:PivotTo((l_l_jandel_0_Pivot_0:Lerp(v11, (game.TweenService:GetValue(v10 / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))));
    end;
    repeat
        task.wait();
    until v2 == false;
    game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
        Ambient = game.Lighting:GetAttribute("DefaultAmbient")
    }):Play();
    game.TweenService:Create(v6, TweenInfo.new(2), {
        Brightness = 0, 
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local v15 = 0;
    while v15 < 3 do
        v15 = v15 + game:GetService("RunService").Heartbeat:Wait();
        l_jandel_0:PivotTo((v11:Lerp(l_l_jandel_0_Pivot_0, (game.TweenService:GetValue(v15 / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))));
    end;
    l_jandel_0:Destroy();
    v4.UpdateSkybox(l_Sky_0, 0);
end;
workspace:GetAttributeChangedSignal("JandelFloat"):Connect(function() --[[ Line: 58 ]]
    -- upvalues: v16 (copy), v2 (ref)
    if workspace:GetAttribute("JandelFloat") then
        v16();
        return;
    else
        v2 = false;
        return;
    end;
end);
if workspace:GetAttribute("JandelFloat") then
    task.defer(v16);
else
    v2 = false;
end;
return v0;