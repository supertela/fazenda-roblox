-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-06-14 12:59:11
-- Luau version 6, Types version 3
-- Time taken: 0.011190 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
local TrowelRemote_upvr = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("TrowelRemote")
local GetFarm_upvr = require(ReplicatedStorage.Modules.GetFarm)
local Notification_upvr = require(ReplicatedStorage.Modules.Notification)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local Trowel_Client_upvr = LocalPlayer_upvr.PlayerGui:WaitForChild("Trowel_Client")
local Cancel = Trowel_Client_upvr.Frame.CancelFrame:WaitForChild("Cancel")
local Rotate = Trowel_Client_upvr.Frame.RotateFrame:WaitForChild("Rotate")
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local Highlight_upvr = script.Highlight
local tbl_upvr = {}
local var20_upvw = false
local function _() -- Line 46, Named "GetTrowel"
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local class_Tool_2 = LocalPlayer_upvr.Character:FindFirstChildOfClass("Tool")
	local var22 = class_Tool_2
	if var22 then
		var22 = class_Tool_2.Name:match("Trowel")
	end
	return var22 and class_Tool_2
end
local function _(arg1) -- Line 53, Named "VerifyPlant"
	--[[ Upvalues[3]:
		[1]: GetFarm_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: CollectionService_upvr (readonly)
	]]
	local var7_result1 = GetFarm_upvr(LocalPlayer_upvr)
	if not var7_result1 then
		return false
	end
	if not arg1:IsDescendantOf(var7_result1) then
		return false
	end
	if not CollectionService_upvr:HasTag(arg1, "Growable") then
		return false
	end
	if arg1.Parent.Name == "Fruits" then
		return false
	end
	return true
end
local function PickupRaycast_upvr(arg1) -- Line 61, Named "PickupRaycast"
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: CollectionService_upvr (readonly)
	]]
	local any_ViewportPointToRay_result1_2 = CurrentCamera_upvr:ViewportPointToRay(arg1.X, arg1.Y)
	local RaycastParams_new_result1_2 = RaycastParams.new()
	RaycastParams_new_result1_2.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1_2.FilterDescendantsInstances = {CollectionService_upvr:GetTagged("ShovelIgnore")}
	local workspace_Raycast_result1_2 = workspace:Raycast(any_ViewportPointToRay_result1_2.Origin, any_ViewportPointToRay_result1_2.Direction * 500, RaycastParams_new_result1_2)
	if workspace_Raycast_result1_2 and workspace_Raycast_result1_2.Instance then
		return workspace_Raycast_result1_2
	end
end
local function PlacementRaycast_upvr(arg1) -- Line 75, Named "PlacementRaycast"
	--[[ Upvalues[3]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: GetFarm_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(arg1.X, arg1.Y)
	local RaycastParams_new_result1_3 = RaycastParams.new()
	RaycastParams_new_result1_3.FilterType = Enum.RaycastFilterType.Include
	RaycastParams_new_result1_3.FilterDescendantsInstances = {GetFarm_upvr(LocalPlayer_upvr).Important.Plant_Locations:GetChildren()}
	local workspace_Raycast_result1 = workspace:Raycast(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction * 500, RaycastParams_new_result1_3)
	if workspace_Raycast_result1 and workspace_Raycast_result1.Instance then
		return workspace_Raycast_result1
	end
end
local function Cancel_upvr() -- Line 94, Named "Cancel"
	--[[ Upvalues[8]:
		[1]: var14_upvw (read and write)
		[2]: var20_upvw (read and write)
		[3]: var15_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: TrowelRemote_upvr (readonly)
		[6]: Notification_upvr (readonly)
		[7]: tbl_upvr (readonly)
		[8]: Highlight_upvr (readonly)
	]]
	if not var14_upvw or var20_upvw or not var15_upvw then
	else
		local var36 = var14_upvw
		var14_upvw = nil
		if LocalPlayer_upvr.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer_upvr.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
		end
		TrowelRemote_upvr:InvokeServer("Cancel", var15_upvw, var36)
		Notification_upvr:CreateNotification(`Canceled moving {var36.Name}!`)
		local var37 = tbl_upvr
		if not var37 then
			var37 = {}
		end
		for _, v in var37 do
			v.CanCollide = true
			v.CanQuery = true
		end
		Highlight_upvr.Adornee = nil
	end
end
local var39_upvw
RunService_upvr.RenderStepped:Connect(function() -- Line 118
	--[[ Upvalues[15]:
		[1]: Trowel_Client_upvr (readonly)
		[2]: var14_upvw (read and write)
		[3]: var15_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var39_upvw (read and write)
		[6]: Cancel_upvr (readonly)
		[7]: UserInputService_upvr (readonly)
		[8]: PlacementRaycast_upvr (readonly)
		[9]: var17_upvw (read and write)
		[10]: var16_upvw (read and write)
		[11]: PickupRaycast_upvr (readonly)
		[12]: GetFarm_upvr (readonly)
		[13]: CollectionService_upvr (readonly)
		[14]: Highlight_upvr (readonly)
		[15]: TweenService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var40
	if var14_upvw == nil then
		var40 = false
	else
		var40 = true
	end
	Trowel_Client_upvr.Enabled = var40
	var40 = LocalPlayer_upvr.Character:FindFirstChildOfClass("Tool")
	if var40 then
	end
	var15_upvw = var40.Name:match("Trowel") and var40
	if var15_upvw then
		if not var39_upvw then
			var40 = var15_upvw
			var39_upvw = var40.Destroying:Once(function() -- Line 129
				--[[ Upvalues[2]:
					[1]: var39_upvw (copied, read and write)
					[2]: Cancel_upvr (copied, readonly)
				]]
				var39_upvw:Disconnect()
				var39_upvw = nil
				Cancel_upvr()
			end)
		end
		local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()
		var40 = var14_upvw
		if var40 then
			var40 = PlacementRaycast_upvr(any_GetMouseLocation_result1)
			if var40 and var40.Position then
				var14_upvw:PivotTo(CFrame.new(var40.Position) * CFrame.new(0, 3, 0) * var17_upvw)
			else
				var14_upvw:PivotTo(var16_upvw)
			end
		end
		var40 = PickupRaycast_upvr(any_GetMouseLocation_result1)
		if not var40 then
		else
			local Instance = var40.Instance
			local Parent_2 = Instance.Parent
			local var7_result1_2 = GetFarm_upvr(LocalPlayer_upvr)
			if not var7_result1_2 then
				Instance = false
			elseif not Parent_2:IsDescendantOf(var7_result1_2) then
				Instance = false
			elseif not CollectionService_upvr:HasTag(Parent_2, "Growable") then
				Instance = false
			elseif Parent_2.Parent.Name == "Fruits" then
				Instance = false
			else
				Instance = true
			end
			if not Instance then
				Highlight_upvr.Adornee = nil
				return
			end
			if Highlight_upvr.Adornee ~= Parent_2 then
				Highlight_upvr.FillTransparency = 1
				TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(0.25), {
					FillTransparency = 0.65;
				}):Play()
			end
			Highlight_upvr.Adornee = Parent_2
		end
	end
	if var14_upvw then
		Cancel_upvr()
	end
	var40 = nil
	Highlight_upvr.Adornee = var40
end)
Cancel.Activated:Connect(Cancel_upvr)
Rotate.Activated:Connect(function() -- Line 89, Named "RotatePickedUp"
	--[[ Upvalues[2]:
		[1]: var14_upvw (read and write)
		[2]: var17_upvw (read and write)
	]]
	if not var14_upvw then
	else
		var17_upvw *= CFrame.Angles(0, 0.7853981633974483, 0)
	end
end)
local Default_upvr = require(ReplicatedStorage.Modules.EffectController.Libraries.Default)
local function ProcessInput(arg1, arg2) -- Line 177
	--[[ Upvalues[19]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var20_upvw (read and write)
		[3]: Notification_upvr (readonly)
		[4]: UserInputService_upvr (readonly)
		[5]: var14_upvw (read and write)
		[6]: PlacementRaycast_upvr (readonly)
		[7]: GetFarm_upvr (readonly)
		[8]: Highlight_upvr (readonly)
		[9]: var17_upvw (read and write)
		[10]: var16_upvw (read and write)
		[11]: RunService_upvr (readonly)
		[12]: TweenService_upvr (readonly)
		[13]: TrowelRemote_upvr (readonly)
		[14]: var15_upvw (read and write)
		[15]: Default_upvr (readonly)
		[16]: CurrentCamera_upvr (readonly)
		[17]: tbl_upvr (readonly)
		[18]: PickupRaycast_upvr (readonly)
		[19]: CollectionService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local var56
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [4] 4. Error Block 89 start (CF ANALYSIS FAILED)
	local class_Tool_3 = LocalPlayer_upvr.Character:FindFirstChildOfClass("Tool")
	local var58 = class_Tool_3
	if var58 then
		var58 = class_Tool_3.Name:match("Trowel")
	end
	var56 = var58 and class_Tool_3
	if not var56 or arg2 then
		-- KONSTANTERROR: [22] 18. Error Block 6 start (CF ANALYSIS FAILED)
		do
			return
		end
		-- KONSTANTERROR: [22] 18. Error Block 6 end (CF ANALYSIS FAILED)
	end
	var56 = var20_upvw
	if var56 then
		var56 = Notification_upvr:CreateNotification
		var56("Please wait before trying again!")
		return
	end
	var56 = arg1
	if not var56 then
		var56 = UserInputService_upvr:GetMouseLocation()
	end
	if var14_upvw then
		local PlacementRaycast_result1_upvr = PlacementRaycast_upvr(var56)
		if not PlacementRaycast_result1_upvr or PlacementRaycast_result1_upvr.Instance.Name ~= "Can_Plant" then
			Notification_upvr:CreateNotification("Can't place here!")
		else
			local RaycastParams_new_result1 = RaycastParams.new()
			RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Include
			RaycastParams_new_result1.FilterDescendantsInstances = {GetFarm_upvr(LocalPlayer_upvr).Important.Plants_Physical:GetChildren()}
			if workspace:Raycast(PlacementRaycast_result1_upvr.Position + Vector3.new(0, 20, 0), Vector3.new(0, -25, 0), RaycastParams_new_result1) then return end
			Highlight_upvr.Adornee = nil
			var20_upvw = true
			task.spawn(function() -- Line 214
				--[[ Upvalues[12]:
					[1]: PlacementRaycast_result1_upvr (readonly)
					[2]: var17_upvw (copied, read and write)
					[3]: var16_upvw (copied, read and write)
					[4]: var14_upvw (copied, read and write)
					[5]: RunService_upvr (copied, readonly)
					[6]: TweenService_upvr (copied, readonly)
					[7]: TrowelRemote_upvr (copied, readonly)
					[8]: var15_upvw (copied, read and write)
					[9]: Notification_upvr (copied, readonly)
					[10]: Default_upvr (copied, readonly)
					[11]: CurrentCamera_upvr (copied, readonly)
					[12]: var20_upvw (copied, read and write)
				]]
				local var63 = CFrame.new(PlacementRaycast_result1_upvr.Position) * CFrame.new(0, 3, 0) * var17_upvw
				local var64 = CFrame.new(PlacementRaycast_result1_upvr.Position.X, var16_upvw.Y, PlacementRaycast_result1_upvr.Position.Z) * var17_upvw
				local var65 = var14_upvw
				var65:PivotTo(var63)
				local const_number = 0
				while const_number < 0.15 do
					var65:PivotTo(var63:Lerp(var64, TweenService_upvr:GetValue((const_number + RunService_upvr.Heartbeat:Wait()) / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))
				end
				TrowelRemote_upvr:InvokeServer("Place", var15_upvw, var65, var64)
				Notification_upvr:CreateNotification(`Successfully moved {var65.Name}!`)
				Default_upvr:SetScale(Default_upvr:CreateEffect({
					Object = script.Place;
					Emit = true;
					Position = PlacementRaycast_result1_upvr.Position;
					DebrisTime = 1;
				}), 3, {})
				Default_upvr:PlaySound(script.PlantTrowel, CurrentCamera_upvr)
				task.wait(1)
				var20_upvw = false
			end)
			local var68 = tbl_upvr
			if not var68 then
				var68 = {}
			end
			for _, v_2 in var68 do
				v_2.CanCollide = true
				v_2.CanQuery = true
			end
			var14_upvw = nil
		end
	end
	PlacementRaycast_result1_upvr = PickupRaycast_upvr(var56)
	local var69 = PlacementRaycast_result1_upvr
	if not var69 then return end
	local Parent = var69.Instance.Parent
	local var7_result1_3 = GetFarm_upvr(LocalPlayer_upvr)
	if not var7_result1_3 then
		-- KONSTANTWARNING: GOTO [171] #136
	end
	if not Parent:IsDescendantOf(var7_result1_3) then
	elseif not CollectionService_upvr:HasTag(Parent, "Growable") then
	elseif Parent.Parent.Name == "Fruits" then
	else
	end
	if not true then
		Notification_upvr:CreateNotification("Can't move this!")
		return
	end
	if not var15_upvw or not var15_upvw.Name then
		Notification_upvr:CreateNotification("Trowel not detected, please try again or report if this is an error!")
		return
	end
	var20_upvw = true
	TrowelRemote_upvr:InvokeServer("Pickup", var15_upvw, Parent)
	var20_upvw = false
	Notification_upvr:CreateNotification(`Picked up {Parent.Name}!`)
	var16_upvw = Parent:GetPivot()
	var17_upvw = var16_upvw.Rotation
	local _, _, _ = Parent:GetDescendants()
	-- KONSTANTERROR: [4] 4. Error Block 89 end (CF ANALYSIS FAILED)
end
if UserInputService_upvr.TouchEnabled then
	UserInputService_upvr.TouchTapInWorld:Connect(ProcessInput)
else
	LocalPlayer_upvr:GetMouse().Button1Down:Connect(ProcessInput)
end
local RotateBG_upvr = Trowel_Client_upvr.Frame.RotateFrame.RotateBG
local CancelBG_upvr = Trowel_Client_upvr.Frame.CancelFrame.CancelBG
local TextLabel_upvr = Rotate:FindFirstChild("TextLabel")
local TextLabel_upvr_2 = Cancel:FindFirstChild("TextLabel")
local RotateIcon_upvr = RotateBG_upvr:FindFirstChild("RotateIcon")
local CancelIcon_upvr = CancelBG_upvr:FindFirstChild("CancelIcon")
local function UpdateButtonLabels() -- Line 326
	--[[ Upvalues[7]:
		[1]: TextLabel_upvr (readonly)
		[2]: TextLabel_upvr_2 (readonly)
		[3]: RotateIcon_upvr (readonly)
		[4]: CancelIcon_upvr (readonly)
		[5]: UserInputService_upvr (readonly)
		[6]: RotateBG_upvr (readonly)
		[7]: CancelBG_upvr (readonly)
	]]
	if not TextLabel_upvr or not TextLabel_upvr_2 then
	else
		if not RotateIcon_upvr or not CancelIcon_upvr then return end
		if UserInputService_upvr.TouchEnabled then
			TextLabel_upvr.Text = "Rotate"
			TextLabel_upvr_2.Text = "Cancel"
			RotateIcon_upvr.Visible = false
			CancelIcon_upvr.Visible = false
			return
		end
		if UserInputService_upvr.GamepadEnabled then
			local any_GetImageForKeyCode_result1 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.DPadRight)
			local any_GetImageForKeyCode_result1_2 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.ButtonB)
			TextLabel_upvr.Text = "Rotate"
			TextLabel_upvr_2.Text = "Cancel"
			if any_GetImageForKeyCode_result1 then
				RotateIcon_upvr.Image = any_GetImageForKeyCode_result1
				RotateBG_upvr.Visible = true
			else
				RotateBG_upvr.Visible = false
			end
			if any_GetImageForKeyCode_result1_2 then
				CancelIcon_upvr.Image = any_GetImageForKeyCode_result1_2
				CancelBG_upvr.Visible = true
			else
				CancelBG_upvr.Visible = false
			end
		end
		TextLabel_upvr.Text = "[R] Rotate"
		TextLabel_upvr_2.Text = "[C] Cancel"
		RotateBG_upvr.Visible = false
		CancelBG_upvr.Visible = false
	end
end
UpdateButtonLabels()
UserInputService_upvr.LastInputTypeChanged:Connect(UpdateButtonLabels)
local ProximityPromptController_upvr = require(ReplicatedStorage.Modules.ProximityPromptController)
local function var83_upvw() -- Line 377
	--[[ Upvalues[8]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: GetFarm_upvr (readonly)
		[3]: ProximityPromptController_upvr (readonly)
		[4]: UserInputService_upvr (readonly)
		[5]: var14_upvw (read and write)
		[6]: var17_upvw (read and write)
		[7]: Cancel_upvr (readonly)
		[8]: var83_upvw (read and write)
	]]
	local var85_upvw
	while not false do
		var85_upvw = LocalPlayer_upvr
		local class_Tool = var85_upvw.Character:FindFirstChildOfClass("Tool")
		var85_upvw = class_Tool
		if var85_upvw then
			var85_upvw = class_Tool.Name:match("Trowel")
		end
		local var87 = var85_upvw and class_Tool
		var85_upvw = LocalPlayer_upvr
		var85_upvw = nil
		if LocalPlayer_upvr.Character and var87 then
			var87.Equipped:Connect(function() -- Line 390
				--[[ Upvalues[6]:
					[1]: ProximityPromptController_upvr (copied, readonly)
					[2]: var85_upvw (read and write)
					[3]: UserInputService_upvr (copied, readonly)
					[4]: var14_upvw (copied, read and write)
					[5]: var17_upvw (copied, read and write)
					[6]: Cancel_upvr (copied, readonly)
				]]
				ProximityPromptController_upvr:AddDisabler("Trowel")
				var85_upvw = UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 394
					--[[ Upvalues[3]:
						[1]: var14_upvw (copied, read and write)
						[2]: var17_upvw (copied, read and write)
						[3]: Cancel_upvr (copied, readonly)
					]]
					if arg2 then
					else
						if arg1.KeyCode == Enum.KeyCode.R or arg1.KeyCode == Enum.KeyCode.DPadRight then
							if not var14_upvw then
							else
								var17_upvw *= CFrame.Angles(0, 0.7853981633974483, 0)
							end
						end
						if arg1.KeyCode == Enum.KeyCode.C or arg1.KeyCode == Enum.KeyCode.ButtonB then
							Cancel_upvr()
						end
					end
				end)
			end)
			var87.Unequipped:Connect(function() -- Line 406
				--[[ Upvalues[3]:
					[1]: ProximityPromptController_upvr (copied, readonly)
					[2]: Cancel_upvr (copied, readonly)
					[3]: var85_upvw (read and write)
				]]
				ProximityPromptController_upvr:RemoveDisabler("Trowel")
				Cancel_upvr()
				if var85_upvw and typeof(var85_upvw) == "RBXScriptConnection" then
					var85_upvw:Disconnect()
				end
			end)
			var87.Destroying:Once(var83_upvw)
		end
		task.wait(0.1)
	end
end
task.spawn(var83_upvw)