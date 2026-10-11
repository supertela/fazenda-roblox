-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SkipEgg, time of decompilation: Wed Jun  4 21:32:01 2025 ]]
local function v2(v0) --[[ Line: 3 ]] --[[ Name: v2 ]]
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundId = v0;
    l_Sound_0.Parent = workspace;
    l_Sound_0:Play();
    l_Sound_0.Ended:Once(function() --[[ Line: 8 ]]
        -- upvalues: l_Sound_0 (copy)
        l_Sound_0:Destroy();
    end);
end;
return function(v3) --[[ Line: 13 ]]
    -- upvalues: v2 (copy)
    local l_v3_Pivot_0 = v3:GetPivot();
    v2("rbxassetid://80226669144059");
    local function _(v5, v6, v7) --[[ Line: 17 ]] --[[ Name: _ ]]
        return v5 + (v6 - v5) * v7;
    end;
    local v9 = 0;
    local v10 = script.Part.Attachment:Clone();
    v10.Parent = workspace.Terrain;
    for _, v12 in v10:GetDescendants() do
        v12.Enabled = true;
    end;
    v10.WorldCFrame = l_v3_Pivot_0 * CFrame.Angles(0, 0, 3.141592653589793);
    while v9 < 1.2 do
        v9 = v9 + game:GetService("RunService").Heartbeat:Wait();
        local l_Value_0 = game:GetService("TweenService"):GetValue(v9 / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        v3:PivotTo(l_v3_Pivot_0 * CFrame.Angles(0, math.rad(l_Value_0 * 1080), 0) * CFrame.Angles(0, 0, (math.rad(math.sin(1080 * l_Value_0) * 35 * (1 - l_Value_0)))));
    end;
    for _, v15 in v10:GetDescendants() do
        v15.Enabled = false;
    end;
    game.Debris:AddItem(v10, 5);
end;