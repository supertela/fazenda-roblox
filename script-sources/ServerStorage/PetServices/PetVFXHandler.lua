-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetVFXHandler, time of decompilation: Wed Jun  4 21:32:04 2025 ]]
local v0 = {};
v0.__index = v0;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = workspace:WaitForChild("PetsPhysical");
local v3 = {
    Dog = {
        Dig = {
            effect = "DigEffect", 
            duration = 1.5
        }
    }, 
    ["Golden Lab"] = {
        Dig = {
            effect = "DigEffect", 
            duration = 1.5
        }
    }, 
    Cat = {
        Nap = {
            effect = "ZzzEffect", 
            duration = 10
        }
    }, 
    ["Orange Tabby"] = {
        Nap = {
            effect = "ZzzEffect", 
            duration = 10
        }
    }, 
    Bunny = {
        Chomp = {
            effect = "CarrotParticles", 
            duration = 1.5
        }
    }, 
    ["Black Bunny"] = {
        Chomp = {
            effect = "CarrotParticles", 
            duration = 1.5
        }
    }, 
    Panda = {
        Chomp = {
            effect = "BambooParticles", 
            duration = 1.5
        }
    }, 
    Pig = {
        Frenzy = {
            effect = "MudSplashEffect", 
            duration = 15
        }
    }, 
    ["Polar Bear"] = {
        Roar = {
            effect = "FrostBreath", 
            duration = 3
        }
    }, 
    ["Praying Mantis"] = {
        Pray = {
            effect = "ShinyEffect", 
            duration = 10
        }
    }, 
    Kiwi = {
        Nurse = {
            effect = "MusicNotes", 
            duration = 3
        }
    }, 
    Mole = {
        DigDown = {
            effect = "DigAroundEffect", 
            duration = 2
        }, 
        DigUp = {
            effect = "DigAroundEffect", 
            duration = 2
        }
    }, 
    Frog = {
        Croak = {
            effect = "Shockwave", 
            duration = 2
        }
    }, 
    ["Echo Frog"] = {
        Croak = {
            effect = "ShockwaveCool", 
            duration = 2
        }
    }, 
    ["Blood Kiwi"] = {
        Nurse = {
            effect = "RedMusicNotes", 
            duration = 3
        }
    }
};
v0.new = function(v4, v5, v6) --[[ Line: 103 ]]
    -- upvalues: v0 (copy)
    local v7 = setmetatable({}, v0);
    v7.PetType = v4;
    v7.PetModel = v5;
    v7.UUID = v6;
    v7.ActiveEmitters = {};
    v7.CurrentAnimation = nil;
    return v7;
end;
v0.cleanupVFX = function(v8, v9) --[[ Line: 113 ]]
    if v8.ActiveEmitters[v9] then
        for _, v11 in pairs(v8.ActiveEmitters[v9]) do
            v11:Destroy();
        end;
        v8.ActiveEmitters[v9] = nil;
    end;
end;
v0.playVFX = function(v12, v13) --[[ Line: 121 ]]
    -- upvalues: v3 (copy), l_ReplicatedStorage_0 (copy)
    if v12.CurrentAnimation == v13 then
        return;
    else
        if v12.CurrentAnimation then
            v12:cleanupVFX(v12.CurrentAnimation);
        end;
        v12.CurrentAnimation = v13;
        local v14 = v3[v12.PetType];
        if not v14 then
            return;
        else
            local v15 = v14[v13];
            if not v15 then
                return;
            else
                local l_effect_0 = v15.effect;
                if not l_effect_0 then
                    return;
                else
                    local l_FirstChild_0 = l_ReplicatedStorage_0:FindFirstChild("Assets"):FindFirstChild("PetVFX"):FindFirstChild(l_effect_0);
                    if not l_FirstChild_0 then
                        return;
                    else
                        local v18 = l_FirstChild_0:Clone();
                        v18.Parent = v12.PetModel.PrimaryPart or v12.PetModel;
                        v18.Name = l_effect_0;
                        if not v12.ActiveEmitters[v13] then
                            v12.ActiveEmitters[v13] = {};
                        end;
                        table.insert(v12.ActiveEmitters[v13], v18);
                        if v15.duration then
                            task.delay(v15.duration, function() --[[ Line: 154 ]]
                                -- upvalues: v18 (copy), v12 (copy), v13 (copy)
                                if v18 and v18.Parent then
                                    local v19 = tick();
                                    local v20 = nil;
                                    do
                                        local l_v20_0 = v20;
                                        l_v20_0 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 161 ]]
                                            -- upvalues: v19 (copy), v18 (ref), l_v20_0 (ref), v12 (ref), v13 (ref)
                                            local v22 = math.clamp((tick() - v19) / 1, 0, 1);
                                            v18.Transparency = NumberSequence.new({
                                                NumberSequenceKeypoint.new(0, v22), 
                                                NumberSequenceKeypoint.new(1, v22)
                                            });
                                            if v22 >= 1 then
                                                l_v20_0:Disconnect();
                                                if v18 and v18.Parent then
                                                    v18:Destroy();
                                                    local l_pairs_0 = pairs;
                                                    local v24 = v12.ActiveEmitters[v13] or {};
                                                    for v25, v26 in l_pairs_0(v24) do
                                                        if v26 == v18 then
                                                            table.remove(v12.ActiveEmitters[v13], v25);
                                                            return;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end);
                                    end;
                                end;
                            end);
                        end;
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
v0.destroy = function(v27) --[[ Line: 194 ]]
    for _, v29 in pairs(v27.ActiveEmitters) do
        for _, v31 in pairs(v29) do
            v31:Destroy();
        end;
    end;
    v27.ActiveEmitters = {};
end;
return v0;