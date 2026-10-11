-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BloodMoon, time of decompilation: Sun Jun  8 12:59:16 2025 ]]
local v0 = {};
local l_Sky_0 = script.Sky;
local v5 = script.Ambience:Clone();
local v6 = false;
l_Sky_0:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 11 ]]
	print("Test");
end);
local function v9(v8) --[[ Line: 15 ]] --[[ Name: v9 ]]
	-- upvalues: v6 (ref), v3 (copy), l_Sky_0 (copy), v5 (copy)
	if v6 == true then
		return;
	else
		v6 = true;
		if v8 then
			game.Lighting.ClockTime = 16;
			game.TweenService:Create(game.Lighting, TweenInfo.new(0.1), {
				Ambient = Color3.fromRGB(138, 107, 107), 
				ExposureCompensation = 1, 
				Brightness = 0.6, 
				OutdoorAmbient = Color3.fromRGB(62, 16, 16)
			}):Play();
			game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(0.1), {
				Brightness = 0.05, 
				TintColor = Color3.fromRGB(255, 226, 226), 
				Contrast = 0.1
			}):Play();
			game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.1), {
				Density = 0.357, 
				Offset = 0.721
			}):Play();
			game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(0.1), {
				Cover = 0.657, 
				Density = 1, 
				Color = Color3.fromRGB(45, 1, 1)
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
				Ambient = Color3.fromRGB(138, 107, 107), 
				ExposureCompensation = 0.6, 
				Brightness = 0.6, 
				ClockTime = 16, 
				OutdoorAmbient = Color3.fromRGB(62, 16, 16)
			}):Play();
			game.Lighting:SetAttribute("DefaultAmbient", Color3.fromRGB(138, 107, 107));
			game.Lighting:SetAttribute("DefaultExposure", 1);
			game.Lighting:SetAttribute("DefaultBrightness", 0.6);
			game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(5), {
				Density = 0.357, 
				Offset = 0.721
			}):Play();
			game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(5), {
				Brightness = 0.05, 
				TintColor = Color3.fromRGB(255, 203, 158), 
				Contrast = 0.1
			}):Play();
			game.Lighting.SunRays.Enabled = true;
			v5.Parent = workspace;
			v5:Play();
			game.TweenService:Create(v5, TweenInfo.new(1), {
				Volume = 0.1
			}):Play();
			game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(5), {
				Cover = 0.657, 
				Density = 1, 
				Color = Color3.fromRGB(45, 1, 1)
			}):Play();
			task.delay(5, function() --[[ Line: 86 ]]
				game.TweenService:Create(game.Lighting.SunRays, TweenInfo.new(2), {
					Intensity = 0.01
				}):Play();
			end);
			return;
		end;
	end;
end;
local function v11(v10) --[[ Line: 95 ]] --[[ Name: v11 ]]
	-- upvalues: v6 (ref), v5 (copy), v3 (copy), l_Sky_0 (copy)
	if v6 == false then
		return;
	else
		v6 = false;
		if v10 then
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
			game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(5), {
				Density = 0, 
				Offset = 0
			}):Play();
			game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(5), {
				Cover = 0, 
				Density = 0, 
				Color = Color3.fromRGB(22, 40, 70)
			}):Play();
			task.wait(5);
			game.TweenService:Create(v5, TweenInfo.new(1), {
				Volume = 0
			}):Play();
			task.delay(1, function() --[[ Line: 128 ]]
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
				ClockTime = 14, 
				OutdoorAmbient = Color3.fromRGB(128, 128, 128)
			}):Play();
			task.delay(6, function() --[[ Line: 145 ]]
				game.Lighting.SunRays.Enabled = false;
			end);
			return;
		end;
	end;
end;
workspace:GetAttributeChangedSignal("BloodMoonEvent"):Connect(function() --[[ Line: 152 ]]
	-- upvalues: v9 (copy), v11 (copy)
	if workspace:GetAttribute("BloodMoonEvent") then
		v9(workspace:GetAttribute("Instant"));
		return;
	else
		v11();
		return;
	end;
end);
if workspace:GetAttribute("BloodMoonEvent") then
	task.defer(function() --[[ Line: 163 ]]
		-- upvalues: v9 (copy)
		v9(true);
	end);
else
	v11(true);
end;
return v0;