-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Rainbow, time of decompilation: Sun Jun  8 12:59:15 2025 ]]
local v0 = {};
local v2 = false;
local l_Sky_0 = script.Sky;
local v6 = game.Lighting.ColorCorrection:Clone();
v6.Name = script.Name;
v6.Parent = game.Lighting;

local function v14() --[[ Line: 14 ]] --[[ Name: v14 ]]
	-- upvalues: v2 (ref), v4 (copy), l_Sky_0 (copy)
	v2 = true;
	l_Sky_0.Parent = game.Lighting
	local _ = tick();
	local v8 = game.ReplicatedStorage.Assets.Rainbow:Clone();
	v8.Parent = workspace;
	local l_v8_FirstChild_0 = v8:FindFirstChild("Beam", true);
	(function() --[[ Line: 22 ]]
		-- upvalues: v8 (copy), l_v8_FirstChild_0 (copy)
		v8.End.PixelSmoke.Enabled = false;
		v8.Start.PixelSmoke.Enabled = false;
		local v10 = 0.001;
		v8.Start.PixelSmoke.Enabled = true;
		while v10 < 3 do
			v10 = v10 + game:GetService("RunService").Heartbeat:Wait();
			local v11 = math.clamp(math.clamp(game.TweenService:GetValue(v10 / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 0, 1) * 0.898 + 0.052, 0.052, 0.949);
			l_v8_FirstChild_0.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1), 
				NumberSequenceKeypoint.new(0.05, 1), 
				NumberSequenceKeypoint.new(0.051, 0), 
				NumberSequenceKeypoint.new(math.clamp(v11 - 0.1, 0.052, 0.95), 0), 
				NumberSequenceKeypoint.new(math.clamp(v11, 0.053, 0.95), 1), 
				NumberSequenceKeypoint.new(0.95, 1), 
				NumberSequenceKeypoint.new(1, 1)
			});
		end;
		v8.End.PixelSmoke.Enabled = true;
	end)();
	repeat
		task.wait(0.1);
	until v2 == false;
	l_Sky_0.Parent = script

	-- upvalues: v8 (copy), l_v8_FirstChild_0 (copy)
	v8.End.PixelSmoke.Enabled = false;
	v8.Start.PixelSmoke.Enabled = false;
	local v12 = 0;
	while v12 < 3 do
		v12 = v12 + game:GetService("RunService").Heartbeat:Wait();
		local v13 = math.clamp(game.TweenService:GetValue(v12 / 3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 0, 1);
		l_v8_FirstChild_0.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1), 
			NumberSequenceKeypoint.new(0.05, 1), 
			NumberSequenceKeypoint.new(0.051, v13), 
			NumberSequenceKeypoint.new(0.949, v13), 
			NumberSequenceKeypoint.new(0.95, 1), 
			NumberSequenceKeypoint.new(1, 1)
		});
	end;
	
	game.Debris:AddItem(v8, 4);
end;
workspace:GetAttributeChangedSignal("Rainbow"):Connect(function() --[[ Line: 67 ]]
	-- upvalues: v14 (copy), v2 (ref)
	if workspace:GetAttribute("Rainbow") then
		v14();
		return;
	else
		v2 = false;
		return;
	end;
end);
if workspace:GetAttribute("Rainbow") then
	task.defer(v14);
else
	v2 = false;
end;
return v0;