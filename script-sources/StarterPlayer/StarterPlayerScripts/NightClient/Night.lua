-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Night, time of decompilation: Sun Jun  8 12:59:16 2025 ]]
local v0 = {};
local l_Sky_0 = script.Sky;
local v5 = script.Ambience:Clone();
local v6 = false;
l_Sky_0:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 11 ]]
    print("Test");
end);
local function v8(v7) --[[ Line: 14 ]] --[[ Name: v8 ]]
    -- upvalues: v6 (ref), v3 (copy), l_Sky_0 (copy), v5 (copy)
    if v6 == true then
        return;
    else
        v6 = true;
        if v7 then
            game.Lighting.ClockTime = 16;
            game.TweenService:Create(game.Lighting, TweenInfo.new(0.1), {
                Ambient = Color3.fromRGB(110, 61, 138), 
                ExposureCompensation = 1, 
                Brightness = 0.6
            }):Play();
            game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(0.1), {
                Brightness = 0.15, 
                TintColor = Color3.fromRGB(206, 178, 255), 
                Contrast = 0.1
            }):Play();
            game.Lighting.SunRays.Intensity = 0.028;
            l_Sky_0.Parent = game.Lighting
            v5.Parent = workspace;
            v5:Play();
            v5.Volume = 0.1;
            return;
        else
            game.TweenService:Create(game.Lighting, TweenInfo.new(5), {
                ClockTime = 21
            }):Play();
            task.wait(5);
			l_Sky_0.Parent = game.Lighting
            game.Lighting.ClockTime = 3;
            game.TweenService:Create(game.Lighting, TweenInfo.new(5), {
                Ambient = Color3.fromRGB(110, 61, 138), 
                ExposureCompensation = 1, 
                Brightness = 0.6, 
                ClockTime = 16
            }):Play();
            game.Lighting:SetAttribute("DefaultAmbient", Color3.fromRGB(110, 61, 138));
            game.Lighting:SetAttribute("DefaultExposure", 1);
            game.Lighting:SetAttribute("DefaultBrightness", 0.6);
            game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(5), {
                Brightness = 0.15, 
                TintColor = Color3.fromRGB(206, 178, 255), 
                Contrast = 0.1
            }):Play();
            game.Lighting.SunRays.Enabled = true;
            v5.Parent = workspace;
            v5:Play();
            game.TweenService:Create(v5, TweenInfo.new(1), {
                Volume = 0.1
            }):Play();
            task.delay(13, function() --[[ Line: 65 ]]
                game.TweenService:Create(game.Lighting.SunRays, TweenInfo.new(2), {
                    Intensity = 0.028
                }):Play();
            end);
            return;
        end;
    end;
end;
local function v10(v9) --[[ Line: 74 ]] --[[ Name: v10 ]]
    -- upvalues: v6 (ref), v5 (copy), v3 (copy), l_Sky_0 (copy)
    if v6 == false then
        return;
    else
        v6 = false;
        if v9 then
            return;
        else
            game.TweenService:Create(game.Lighting, TweenInfo.new(5), {
                ClockTime = 21
            }):Play();
            game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(5), {
                Brightness = 0, 
                Contrast = 0, 
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            game.TweenService:Create(game.Lighting.SunRays, TweenInfo.new(2), {
                Intensity = 0
            }):Play();
            task.wait(5);
            game.TweenService:Create(v5, TweenInfo.new(1), {
                Volume = 0
            }):Play();
            task.delay(1, function() --[[ Line: 98 ]]
                -- upvalues: v5 (ref)
                v5.Parent = script;
                v5:Stop();
            end);
			l_Sky_0.Parent = script
            game.Lighting.ClockTime = 3;
            game.Lighting:SetAttribute("DefaultAmbient", Color3.fromRGB(138, 138, 138));
            game.Lighting:SetAttribute("DefaultExposure", 0.2);
            game.Lighting:SetAttribute("DefaultBrightness", 2);
            game.TweenService:Create(game.Lighting, TweenInfo.new(5), {
                Ambient = Color3.fromRGB(138, 138, 138), 
                ExposureCompensation = 0.2, 
                Brightness = 2, 
                ClockTime = 14
            }):Play();
            task.delay(6, function() --[[ Line: 114 ]]
                game.Lighting.SunRays.Enabled = false;
            end);
            return;
        end;
    end;
end;
workspace:GetAttributeChangedSignal("NightEvent"):Connect(function() --[[ Line: 121 ]]
    -- upvalues: v8 (copy), v10 (copy)
    if workspace:GetAttribute("NightEvent") then
        v8();
        return;
    else
        v10();
        return;
    end;
end);
if workspace:GetAttribute("NightEvent") then
    task.defer(function() --[[ Line: 132 ]]
        -- upvalues: v8 (copy)
        v8(true);
    end);
else
    v10(true);
end;
return v0;