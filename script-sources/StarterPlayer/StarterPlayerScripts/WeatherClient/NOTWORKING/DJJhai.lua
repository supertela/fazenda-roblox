-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DJJhai, time of decompilation: Sun Jun  8 12:59:13 2025 ]]
local v0 = {};
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v7 = RaycastParams.new();
v7.FilterDescendantsInstances = {
	workspace.Terrain, 
	workspace
};
v7.FilterType = Enum.RaycastFilterType.Include;
local v9 = false;
local l_Sky_0 = script.Sky;
local v12 = game.Lighting.ColorCorrection:Clone();
v12.Name = script.Name;
v12.Parent = game.Lighting;
local function v23(v13) --[[ Line: 25 ]] --[[ Name: v23 ]]
	local v14 = game.ReplicatedStorage.ShootingStar:Clone();
	v14.CFrame = v13;
	v14.Parent = workspace;
	local v15 = script.Fire:Clone();
	v15.SoundId = "rbxassetid://113919877495546";
	v15.Parent = workspace;
	v15:Play();
	game.Debris:AddItem(v15, 5);
	local v16 = 0;
	while v16 < 1 do
		v16 = v16 + game:GetService("RunService").Heartbeat:Wait();
		v14:PivotTo(v13:Lerp(v13 * CFrame.new(0, 200, 0), v16));
	end;
	for _, v18 in v14:GetDescendants() do
		if v18:IsA("BillboardGui") then
			v18.Enabled = false;
		end;
	end;
	game.Debris:AddItem(v14, 4);
	local v19 = game.ReplicatedStorage.FireworkBoom:Clone();
	v19.Parent = workspace;
	v19.CFrame = v14.CFrame;
	for _, v21 in v19:GetDescendants() do
		if v21:IsA("ParticleEmitter") then
			v21:Emit(v21:GetAttribute("EmitCount"));
		end;
	end;
	local v22 = script.Boom:Clone();
	v22.SoundId = "rbxassetid://4583102108";
	v22.Parent = workspace;
	v22:Play();
	game.Debris:AddItem(v22, 5);
	game.Debris:AddItem(v19, 10);
end;
local function v62() --[[ Line: 60 ]] --[[ Name: v62 ]]
	-- upvalues: v9 (ref), v12 (copy), v11 (copy), l_Sky_0 (copy), l_CurrentCamera_0 (copy), v23 (copy)
	v9 = true;
	game.TweenService:Create(v12, TweenInfo.new(2), {
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
	local v26 = l_l_DJJhai_0_Pivot_0 * CFrame.new(0, 85, 0);
	local v27 = 0;
	local l_Animator_0 = l_DJJhai_0:WaitForChild("jhailatte"):WaitForChild("Humanoid"):WaitForChild("Animator");
	local v29 = l_Animator_0:LoadAnimation(script.Animation);
	v29:Play();
	local v30 = game.ReplicatedStorage.Assets.DanceFloor:Clone();
	local l_v30_Pivot_0 = v30:GetPivot();
	v30.Parent = workspace;
	local function v34() --[[ Line: 87 ]] --[[ Name: v34 ]]
		-- upvalues: v30 (copy)
		for _, v33 in v30.Colour:GetChildren() do
			v33.Color = Color3.fromHSV(Random.new():NextNumber(0, 1), Random.new():NextNumber(0, 1), 1);
		end;
	end;
	task.spawn(function() --[[ Line: 93 ]]
		-- upvalues: v34 (copy)
		while workspace:GetAttribute("DJJhai") do
			v34();
			task.wait(1);
		end;
	end);
	while v27 < 2 do
		v27 = v27 + game:GetService("RunService").Heartbeat:Wait();
		local l_Value_0 = game.TweenService:GetValue(v27, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		l_DJJhai_0:PivotTo(l_l_DJJhai_0_Pivot_0:Lerp(v26, l_Value_0));
		v30:PivotTo(l_v30_Pivot_0:Lerp(l_v30_Pivot_0 * CFrame.new(0, 2, 0), l_Value_0));
	end;
	local l_Sound_0 = Instance.new("Sound");
	local v37 = {
		104445637963020, 
		5410086218, 
		118939739460633, 
		99445078556609, 
		121336636707861
	};
	l_Sound_0.SoundId = "rbxassetid://" .. v37[Random.new():NextInteger(1, #v37)];
	l_Sound_0.Volume = 0.6;
	l_Sound_0.Looped = true;
	l_Sound_0.Parent = workspace;
	l_Sound_0.SoundGroup = game.SoundService.Music;
	l_Sound_0:Play();
	local v38 = l_Animator_0:LoadAnimation(script.Up);
	local v39 = 0;
	local v40 = false;
	task.spawn(function() --[[ Line: 123 ]]
		-- upvalues: l_Sound_0 (copy), v40 (ref), l_DJJhai_0 (copy), l_CurrentCamera_0 (ref), v39 (ref), v38 (copy), v12 (ref), v23 (ref)
		local v41 = nil;
		while true do
			task.wait(0);
			local v42 = math.clamp((l_Sound_0.PlaybackLoudness - 200) / 700, 0, 1);
			if v41 and l_Sound_0.PlaybackLoudness / 1000 - v41 > 0.2 and not v40 then
				for _, v44 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
					v44:Emit(v44:GetAttribute("EmitCount"));
				end;
				local _, v46 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
				if v46 then
					game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
						FieldOfView = 68
					}):Play();
					task.delay(0.2, function() --[[ Line: 138 ]]
						game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
							FieldOfView = 70
						}):Play();
					end);
				end;
			end;
			v41 = l_Sound_0.PlaybackLoudness / 1000;
			if v42 > 0.45 then
				local v47 = tick();
				v39 = v47;
				if not v40 then
					v40 = true;
					v38:Play();
					game.TweenService:Create(v12, TweenInfo.new(0.3), {
						TintColor = Color3.fromRGB(226, 192, 255), 
						Brightness = 0.5
					}):Play();
					game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {
						FieldOfView = 90
					}):Play();
					for _, v49 in l_DJJhai_0.Pyro:GetDescendants() do
						if v49:IsA("ParticleEmitter") then
							v49.Enabled = true;
							task.delay(1.5, function() --[[ Line: 162 ]]
								-- upvalues: v49 (copy)
								v49.Enabled = false;
							end);
						end;
					end;
					for _, v51 in l_DJJhai_0.Confetti:GetDescendants() do
						v51:Emit(v51:GetAttribute("EmitCount"));
					end;
					task.spawn(function() --[[ Line: 171 ]]
						-- upvalues: l_DJJhai_0 (ref), v23 (ref)
						for _, v53 in l_DJJhai_0.SpawnPoints:GetChildren() do
							task.spawn(function() --[[ Line: 174 ]]
								-- upvalues: v23 (ref), v53 (copy)
								v23(v53.CFrame);
							end);
							task.wait(0.1);
						end;
					end);
					task.delay(3, function() --[[ Line: 181 ]]
						-- upvalues: v12 (ref)
						game.TweenService:Create(v12, TweenInfo.new(3), {
							TintColor = Color3.fromRGB(255, 255, 255), 
							Brightness = 0.1
						}):Play();
					end);
					task.spawn(function() --[[ Line: 188 ]]
						-- upvalues: v40 (ref), l_DJJhai_0 (ref), l_CurrentCamera_0 (ref)
						while v40 do
							for _, v55 in l_DJJhai_0.jhailatte.HumanoidRootPart.Attachment:GetChildren() do
								v55:Emit(v55:GetAttribute("EmitCount"));
							end;
							local _, v57 = l_CurrentCamera_0:WorldToScreenPoint(l_DJJhai_0:GetPivot().p);
							if v57 then
								game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2), {
									FieldOfView = 68
								}):Play();
								task.delay(0.2, function() --[[ Line: 199 ]]
									game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.3), {
										FieldOfView = 70
									}):Play();
								end);
							end;
							task.wait(0.5);
						end;
					end);
				end;
				task.delay(1, function() --[[ Line: 209 ]]
					-- upvalues: v39 (ref), v47 (copy), v40 (ref), v38 (ref)
					if v39 == v47 then
						v40 = false;
						v38:Stop();
					end;
				end);
			end;
			for _, v59 in l_DJJhai_0.DJBooth.Speakers:GetChildren() do
				if v59:IsA("BasePart") then
					v59.Mesh.Offset = Vector3.new(0, v42 * -1.4, 0);
					v59.Mesh.Scale = Vector3.new(1, 1, 1, 0) * (v42 * 0.4 + 1);
				end;
			end;
		end;
	end);
	task.spawn(function()
		repeat
			task.wait();
		until not workspace:GetAttribute("DJJhai");
		game.TweenService:Create(l_Sound_0, TweenInfo.new(1), {
			Volume = 0
		}):Play();
		task.delay(2, function() --[[ Line: 236 ]]
			-- upvalues: l_Sound_0 (ref)
			l_Sound_0:Destroy();
		end);
		local v60 = 0;
		while v60 < 2 do
			v60 = v60 + game:GetService("RunService").Heartbeat:Wait();
			local l_Value_1 = game.TweenService:GetValue(v60, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			l_DJJhai_0:PivotTo(v26:Lerp(l_l_DJJhai_0_Pivot_0, l_Value_1));
			v30:PivotTo((l_v30_Pivot_0 * CFrame.new(0, 2, 0)):Lerp(l_v30_Pivot_0, l_Value_1));
		end;
		v30:Destroy();
		v38:Destroy();
		v29:Destroy();
		l_DJJhai_0:Destroy();
		l_Sky_0.Parent = script
		game.TweenService:Create(v12, TweenInfo.new(3), {
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
end;
workspace:GetAttributeChangedSignal("DJJhai"):Connect(function() --[[ Line: 272 ]]
	-- upvalues: v62 (copy), v9 (ref)
	if workspace:GetAttribute("DJJhai") then
		v62();
		return;
	else
		v9 = false;
		return;
	end;
end);
if workspace:GetAttribute("DJJhai") then
	task.defer(v62);
else
	v9 = false;
end;
return v0;