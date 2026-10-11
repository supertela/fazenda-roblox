-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Windy, time of decompilation: Sun Jun  8 12:59:15 2025 ]]
local v0 = {};
local v5 = RaycastParams.new();
v5.FilterDescendantsInstances = {
    workspace.Terrain, 
    workspace
};
v5.FilterType = Enum.RaycastFilterType.Include;
local _ = {};
local v7 = false;
local v8 = game.Lighting.ColorCorrection:Clone();
v8.Name = script.Name;
v8.Parent = game.Lighting;
local l_Sky_0 = script.Sky;
local v11 = require(game.ReplicatedStorage.Code.CameraShaker);
local v13 = v11.new(Enum.RenderPriority.Camera.Value, function(v12) --[[ Line: 24 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v12;
end);
local function v17()
    v7 = true;
    game.TweenService:Create(v8, TweenInfo.new(1), {
        Brightness = 0.1, 
        Contrast = -0.2, 
        Saturation = 0.2
    }):Play();
    v13:Start();
    v13:ShakeSustain(v11.Presets.HandheldCamera);
    --local v14 = game.ReplicatedStorage.Assets.WindyEffect:Clone();
    --v14.Parent = workspace;
    repeat
        task.wait();
    until v7 == false;
    --for _, v16 in v14:GetChildren() do
    --    v16.Enabled = false;
    --end;
    --v13:StopSustained(2);
    --game.Debris:AddItem(v14, 4);
    game.TweenService:Create(v8, TweenInfo.new(1), {
        Brightness = 0, 
        Contrast = 0, 
        Saturation = 0
    }):Play();
end;
workspace:GetAttributeChangedSignal("Windy"):Connect(function()
    if workspace:GetAttribute("Windy") then
        v17();
        return;
    else
        v7 = false;
        return;
    end;
end);

if workspace:GetAttribute("Windy") then
    task.defer(v17);
else
    v7 = false;
end;

return v0;