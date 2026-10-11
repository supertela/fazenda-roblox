-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-06-14 12:49:02
-- Luau version 6, Types version 3
-- Time taken: 0.006690 seconds

local TweenService_upvr = game:GetService("TweenService")
local Debris_upvr = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenInfo_new_result1_upvr = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
local Chalk_upvr = require(ReplicatedStorage.Modules.Chalk)
local Parent_upvr = script.Parent.Parent.Parent
local LocalPlayer_upvr = game.Players.LocalPlayer
local Top_Text_upvr = require(game.ReplicatedStorage.Top_Text)
local NPC_MOD_upvr = require(game.ReplicatedStorage.NPC_MOD)
local var11_upvw
local var12_upvw = false
local var13_upvw = true
local var14_upvw = false
local var15_upvw
local function waitForDuration_upvr(arg1) -- Line 38, Named "waitForDuration"
	--[[ Upvalues[1]:
		[1]: var14_upvw (read and write)
	]]
	while time() - time() < arg1 do
		task.wait()
		if var14_upvw then
			return false
		end
	end
	return true
end
local function cancelYes_upvr() -- Line 50, Named "cancelYes"
	--[[ Upvalues[11]:
		[1]: var14_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: Top_Text_upvr (readonly)
		[4]: Parent_upvr (readonly)
		[5]: LocalPlayer_upvr (readonly)
		[6]: var11_upvw (read and write)
		[7]: TweenService_upvr (readonly)
		[8]: TweenInfo_new_result1_upvr (readonly)
		[9]: Debris_upvr (readonly)
		[10]: NPC_MOD_upvr (readonly)
		[11]: var15_upvw (read and write)
	]]
	var14_upvw = true
	var13_upvw = true
	Top_Text_upvr.TakeAwayResponses(Parent_upvr, LocalPlayer_upvr)
	if var11_upvw then
		TweenService_upvr:Create(var11_upvw, TweenInfo_new_result1_upvr, {
			OutlineTransparency = 1;
		}):Play()
		Debris_upvr:AddItem(var11_upvw, TweenInfo_new_result1_upvr.Time)
	end
	NPC_MOD_upvr.End_Speak(LocalPlayer_upvr)
	var15_upvw = nil
	task.wait(0.7)
	script.Parent.Enabled = true
end
local function EndInteraction_upvr() -- Line 69, Named "EndInteraction"
	--[[ Upvalues[8]:
		[1]: var12_upvw (read and write)
		[2]: waitForDuration_upvr (readonly)
		[3]: cancelYes_upvr (readonly)
		[4]: Top_Text_upvr (readonly)
		[5]: Parent_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var13_upvw (read and write)
		[8]: NPC_MOD_upvr (readonly)
	]]
	var12_upvw = false
	if not waitForDuration_upvr(math.random(0.4, 0.5)) then
		return cancelYes_upvr()
	end
	task.wait(0.5)
	Top_Text_upvr.TakeAwayResponses(Parent_upvr, LocalPlayer_upvr)
	waitForDuration_upvr(0.5)
	var13_upvw = true
	script.Parent.Enabled = true
	NPC_MOD_upvr.End_Speak(LocalPlayer_upvr)
end
local var17_upvr = Chalk_upvr.color(Color3.fromRGB(255, 149, 0))("Honey")
local HoneyCrafterRemoteEvent_upvr = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("HoneyCrafterRemoteEvent")
local function yes_upvr() -- Line 83, Named "yes"
	--[[ Upvalues[17]:
		[1]: var13_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var15_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: NPC_MOD_upvr (readonly)
		[6]: var11_upvw (read and write)
		[7]: TweenService_upvr (readonly)
		[8]: TweenInfo_new_result1_upvr (readonly)
		[9]: Debris_upvr (readonly)
		[10]: var14_upvw (read and write)
		[11]: Top_Text_upvr (readonly)
		[12]: Parent_upvr (readonly)
		[13]: var17_upvr (readonly)
		[14]: waitForDuration_upvr (readonly)
		[15]: cancelYes_upvr (readonly)
		[16]: HoneyCrafterRemoteEvent_upvr (readonly)
		[17]: EndInteraction_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 48 start (CF ANALYSIS FAILED)
	if not var13_upvw then
	else
		var13_upvw = false
		var12_upvw = true
		var15_upvw = LocalPlayer_upvr
		NPC_MOD_upvr.Start_Speak(LocalPlayer_upvr)
		if var11_upvw then
			TweenService_upvr:Create(var11_upvw, TweenInfo_new_result1_upvr, {
				OutlineTransparency = 1;
			}):Play()
			Debris_upvr:AddItem(var11_upvw, TweenInfo_new_result1_upvr.Time)
		end
		var14_upvw = false
		script.Parent.Enabled = false
		Top_Text_upvr.NpcText(Parent_upvr, `I'm the {var17_upvr} Crafter`, false)
		if not waitForDuration_upvr(math.random(1, 1.5)) then
			return cancelYes_upvr()
		end
		if var14_upvw then
			return cancelYes_upvr()
		end
		local var49_upvw = ""
		for _, v in pairs(Top_Text_upvr.ShowChoices(LocalPlayer_upvr, {"How do I craft?", "Lets Craft!", "Nevermind"})) do
			local Frame_upvr_2 = v:FindFirstChild("Frame")
			if Frame_upvr_2 then
				local ImageButton = Frame_upvr_2:FindFirstChild("ImageButton")
				if ImageButton then
					local var56_upvw = ""
					table.insert({}, ImageButton.MouseButton1Click:Connect(function() -- Line 125
						--[[ Upvalues[3]:
							[1]: var56_upvw (read and write)
							[2]: Frame_upvr_2 (readonly)
							[3]: var49_upvw (read and write)
						]]
						var56_upvw = Frame_upvr_2.Frame.Text_Element:GetAttribute("Text")
						if var56_upvw == "How do I craft?" then
							var49_upvw = "How"
						else
							if var56_upvw == "Lets Craft!" then
								var49_upvw = "Craft"
								return
							end
							var49_upvw = "Nevermind"
						end
					end))
				end
			end
		end
		while var49_upvw == "" do
			task.wait()
			if var14_upvw then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				for _, v_2 in pairs({}) do
					Frame_upvr_2 = v_2:Disconnect
					Frame_upvr_2()
				end
				return cancelYes_upvr()
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		for i_3, v_3 in pairs({}) do
			v_3:Disconnect()
		end
		if var14_upvw then
			return cancelYes_upvr()
		end
		Top_Text_upvr.RemovePlayerSideFrame(LocalPlayer_upvr)
		if LocalPlayer_upvr.Character then
			i_3 = true
			Top_Text_upvr.PlayerResponse(LocalPlayer_upvr.Character, var56_upvw, i_3)
		else
			return cancelYes_upvr()
		end
		if not waitForDuration_upvr(math.sqrt(string.len(var56_upvw) * 0.07)) then
			return cancelYes_upvr()
		end
		if var49_upvw == "How" then
			Top_Text_upvr.NpcText(Parent_upvr, "Place honey and plants in front of me.", true)
			task.wait(2)
			Top_Text_upvr.NpcText(Parent_upvr, "Then let me know", true)
			task.wait(2)
			Top_Text_upvr.NpcText(Parent_upvr, "And I'll whip you up something good", true)
			task.wait(2)
			-- KONSTANTWARNING: GOTO [274] #223
		end
		if var49_upvw == "Craft" then
			Top_Text_upvr.NpcText(Parent_upvr, "Time to cook!", true)
			task.wait(0.5)
			Top_Text_upvr.TakeAwayResponses(Parent_upvr, LocalPlayer_upvr)
			HoneyCrafterRemoteEvent_upvr:FireServer("CraftItem")
			task.wait(0.5)
		else
			Top_Text_upvr.NpcText(Parent_upvr, "Goodbye!", true)
		end
		-- KONSTANTERROR: [0] 1. Error Block 48 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [274] 223. Error Block 37 start (CF ANALYSIS FAILED)
		EndInteraction_upvr()
		-- KONSTANTERROR: [274] 223. Error Block 37 end (CF ANALYSIS FAILED)
	end
end
script.Parent.Triggered:Connect(function() -- Line 206
	--[[ Upvalues[3]:
		[1]: NPC_MOD_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: yes_upvr (readonly)
	]]
	if NPC_MOD_upvr.Can_Speak(LocalPlayer_upvr) then
		yes_upvr()
	end
end)
local Click_upvr = game.SoundService.Click
script.Parent.PromptButtonHoldBegan:Connect(function() -- Line 214
	--[[ Upvalues[1]:
		[1]: Click_upvr (readonly)
	]]
	Click_upvr.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click_upvr.Playing = true
	Click_upvr.TimePosition = 0
end)
local Position_upvr = script.Parent.Parent.Position
task.spawn(function() -- Line 223
	--[[ Upvalues[9]:
		[1]: var15_upvw (read and write)
		[2]: Position_upvr (readonly)
		[3]: var13_upvw (read and write)
		[4]: var12_upvw (read and write)
		[5]: Top_Text_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: Parent_upvr (readonly)
		[8]: NPC_MOD_upvr (readonly)
		[9]: cancelYes_upvr (readonly)
	]]
	while true do
		task.wait(0.1)
		if var15_upvw and var15_upvw.Character and var15_upvw.Character.PrimaryPart and 17 < (var15_upvw.Character.PrimaryPart.Position - Position_upvr).Magnitude and not var13_upvw and var12_upvw then
			Top_Text_upvr.RemovePlayerSideFrame(LocalPlayer_upvr)
			Top_Text_upvr.NpcText(Parent_upvr, "Goodbye!", true)
			NPC_MOD_upvr.End_Speak(LocalPlayer_upvr)
			cancelYes_upvr()
		end
	end
end)
script.Parent.PromptShown:Connect(function() -- Line 240
	--[[ Upvalues[4]:
		[1]: var11_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: TweenService_upvr (readonly)
		[4]: TweenInfo_new_result1_upvr (readonly)
	]]
	var11_upvw = Instance.new("Highlight", Parent_upvr)
	var11_upvw.DepthMode = Enum.HighlightDepthMode.Occluded
	var11_upvw.FillTransparency = 1
	var11_upvw.OutlineTransparency = 1
	var11_upvw.Adornee = Parent_upvr
	TweenService_upvr:Create(var11_upvw, TweenInfo_new_result1_upvr, {
		OutlineTransparency = 0;
	}):Play()
end)
local Notification_upvr = game.SoundService.Notification
local Arrow_Module_upvr = require(game.ReplicatedStorage.Arrow_Module)
local function TriggerReadyCookDialogue_upvr() -- Line 250, Named "TriggerReadyCookDialogue"
	--[[ Upvalues[7]:
		[1]: DataService_upvr (readonly)
		[2]: Chalk_upvr (readonly)
		[3]: Top_Text_upvr (readonly)
		[4]: Parent_upvr (readonly)
		[5]: Notification_upvr (readonly)
		[6]: Arrow_Module_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
	]]
	local HoneyCrafterEventData = DataService_upvr:GetData().HoneyCrafterEventData
	if HoneyCrafterEventData.HoneyRequirementMet and HoneyCrafterEventData.PlantRequirementMet then
		Top_Text_upvr.NpcText(Parent_upvr, `{Chalk_upvr.color(Color3.fromRGB(255, 149, 0))("Thanks! I'm ready to cook!")}`, true)
		Notification_upvr.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Notification_upvr.Playing = true
		Notification_upvr.TimePosition = 0
		task.wait(8)
		Arrow_Module_upvr.Remove_Arrow(Arrow_Module_upvr.GenerateArrow(LocalPlayer_upvr, Parent_upvr.PrimaryPart.Position, math.random(1, 1000000)))
	end
end
task.spawn(function() -- Line 272
	--[[ Upvalues[2]:
		[1]: DataService_upvr (readonly)
		[2]: TriggerReadyCookDialogue_upvr (readonly)
	]]
	task.spawn(function() -- Line 273
		--[[ Upvalues[2]:
			[1]: DataService_upvr (copied, readonly)
			[2]: TriggerReadyCookDialogue_upvr (copied, readonly)
		]]
		local any_GetPathSignal_result1_2 = DataService_upvr:GetPathSignal("HoneyCrafterEventData/@")
		if any_GetPathSignal_result1_2 then
			any_GetPathSignal_result1_2:Connect(TriggerReadyCookDialogue_upvr)
		end
		local any_GetPathSignal_result1 = DataService_upvr:GetPathSignal("HoneyCrafterEventData")
		if any_GetPathSignal_result1 then
			any_GetPathSignal_result1:Connect(TriggerReadyCookDialogue_upvr)
		end
	end)
end)
script.Parent.PromptHidden:Connect(function() -- Line 287
	--[[ Upvalues[4]:
		[1]: var11_upvw (read and write)
		[2]: TweenService_upvr (readonly)
		[3]: TweenInfo_new_result1_upvr (readonly)
		[4]: Debris_upvr (readonly)
	]]
	if var11_upvw then
		TweenService_upvr:Create(var11_upvw, TweenInfo_new_result1_upvr, {
			OutlineTransparency = 1;
		}):Play()
		Debris_upvr:AddItem(var11_upvw, TweenInfo_new_result1_upvr.Time)
	end
end)