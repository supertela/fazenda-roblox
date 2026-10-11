-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Script, time of decompilation: Sun Jun  8 12:59:12 2025 ]]
local _ = {};
local _ = {};
local l_PrimaryPart_0 = script.Parent.PrimaryPart;
local _ = Random.new();
local v4 = {};
local function v6() --[[ Line: 8 ]] --[[ Name: v6 ]]
    -- upvalues: v4 (copy)
    local v5 = script.Parent.Template:Clone();
    table.insert(v4, {
        CreationTime = tick(), 
        Template = v5, 
        Direction = Random.new():NextInteger(1, 2) == 2 and -1 or 1
    });
    v5.Name = tick();
    v5.Parent = script.Parent;
    game.TweenService:Create(v5, TweenInfo.new(1.2), {
        Size = Vector3.new(20, 0.5, 20, 0)
    }):Play();
end;
local v7 = tick();
task.spawn(function() --[[ Line: 23 ]]
    -- upvalues: v4 (copy), l_PrimaryPart_0 (copy), v7 (ref), v6 (copy)
    while true do
        local _ = game:GetService("RunService").Heartbeat:Wait();
        for v9, v10 in v4 do
            local v11 = math.clamp((tick() - v10.CreationTime) / 1.2, 0, 1);
            v10.Template.CFrame = l_PrimaryPart_0.CFrame * CFrame.new(0, v11 * 35, 0) * CFrame.Angles(0, math.rad(v11 * 720) * v10.Direction, 0) * CFrame.new(0, 0, v11 * 2);
            for _, v13 in v10.Template:GetChildren() do
                local _ = v13:GetAttribute("Direction");
                v13.Position = Vector3.new(v10.Template.Size.X, 0, v10.Template.Size.Z) / 2;
                v13.Position = v13.Position * v13:GetAttribute("Direction");
            end;
            if v11 == 1 then
                v10.Template:Destroy();
                table.remove(v4, v9);
            end;
        end;
        if tick() - v7 > 0.25 then
            v6();
            v7 = tick();
        end;
    end;
end);