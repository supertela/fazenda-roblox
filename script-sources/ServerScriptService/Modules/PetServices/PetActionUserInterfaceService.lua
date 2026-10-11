-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetActionUserInterfaceService, time of decompilation: Wed Jun  4 21:31:57 2025 ]]
local _ = game:GetService("Selection");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v10 = require(l_Modules_0.WaitForDescendant);
local l_PetServices_0 = l_Modules_0:WaitForChild("PetServices");
local v12 = require(l_PetServices_0.ActivePetsService);
local v13 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local l_PetList_0 = v13.PetList;
local l_DefaultPetActions_0 = v13.DefaultPetActions;
local l_PetStatesRegistry_0 = v13.PetStatesRegistry;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_PetActionUI_0 = l_PlayerGui_0:WaitForChild("PetUI"):WaitForChild("PetActionUI");
local l_UIScale_0 = l_PetActionUI_0:WaitForChild("UIScale");
local v21 = v10(l_PetActionUI_0, "CLOSE_BUTTON");
local v22 = v10(l_PetActionUI_0, "OPTION_HOLDER");
local l_PetActionsHandlers_0 = script:WaitForChild("PetActionsHandlers");
local l_PetActionTemplates_0 = script:WaitForChild("PetActionTemplates");
local l_ScriptModules_0 = script:WaitForChild("ScriptModules");
local v26 = require(l_ReplicatedStorage_0.Modules.SetupHoverAnimations);
local v27 = require(l_ReplicatedStorage_0.Modules.SetupBrightnessAnimationImage);
local l_Radialize_0 = require(l_ScriptModules_0:WaitForChild("Radialize"));
local v29 = require(l_ReplicatedStorage_0.Modules.PlayHoverSound);
local v30 = require(l_ReplicatedStorage_0.Modules.PlayClickSound);
local v31 = {
    Active = false, 
    Target = nil, 
    LastStateBeforeInspection = nil
};
local v32 = nil;
local function v39() --[[ Line: 44 ]] --[[ Name: v39 ]]
    -- upvalues: l_CollectionService_0 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_PlayerGui_0 (copy)
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("PetActionButton");
    local _ = {};
    local v35 = l_UserInputService_0:GetMouseLocation() - l_GuiService_0:GetGuiInset();
    local l_l_PlayerGui_0_GuiObjectsAtPosition_0 = l_PlayerGui_0:GetGuiObjectsAtPosition(v35.X, v35.Y);
    for _, v38 in l_l_CollectionService_0_Tagged_0 do
        if v38:IsDescendantOf(l_PlayerGui_0) and table.find(l_l_PlayerGui_0_GuiObjectsAtPosition_0, v38) then
            return true;
        end;
    end;
    return false;
end;
local v40 = require(game.ReplicatedStorage.Frame_Popup_Module);
local l_ConfirmPetEggPurchase_0 = l_PlayerGui_0:WaitForChild("ConfirmPetEggPurchase");
local function v53(v42) --[[ Line: 59 ]] --[[ Name: v53 ]]
    -- upvalues: l_PetActionTemplates_0 (copy), l_PetActionsHandlers_0 (copy), v31 (copy), v22 (copy), v26 (copy), v27 (copy), v40 (copy), l_ConfirmPetEggPurchase_0 (copy), l_LocalPlayer_0 (copy), v30 (copy), v29 (copy)
    local l_l_PetActionTemplates_0_FirstChild_0 = l_PetActionTemplates_0:FindFirstChild(v42);
    local l_l_PetActionsHandlers_0_FirstChild_0 = l_PetActionsHandlers_0:FindFirstChild(v42);
    if not l_l_PetActionsHandlers_0_FirstChild_0 then
        return warn("No handler for", v42);
    else
        local v45 = require(l_l_PetActionsHandlers_0_FirstChild_0);
        local l_Verifier_0 = v45.Verifier;
        if l_Verifier_0 and not l_Verifier_0(v31.Target) then
            return;
        else
            local v47 = l_l_PetActionTemplates_0_FirstChild_0:Clone();
            v47.Parent = v22;
            local l_Inner_0 = v47:FindFirstChild("Inner");
            local v49 = v26(l_Inner_0);
            v27(l_Inner_0);
            v49.ZIndex = 1000;
            local function v51() --[[ Line: 77 ]] --[[ Name: v51 ]]
                -- upvalues: v45 (copy), v31 (ref), v40 (ref), l_ConfirmPetEggPurchase_0 (ref), l_LocalPlayer_0 (ref), v30 (ref)
                local l_Activate_0 = v45.Activate;
                if l_Activate_0 then
                    l_Activate_0(v31.Target);
                end;
                v40.Hide(l_ConfirmPetEggPurchase_0);
                v31:Toggle(false);
                l_LocalPlayer_0:SetAttribute("DontOpenAction", true);
                task.delay(0.3, function() --[[ Line: 86 ]]
                    -- upvalues: l_LocalPlayer_0 (ref)
                    l_LocalPlayer_0:SetAttribute("DontOpenAction", false);
                end);
                v30();
            end;
            v49.MouseButton1Down:Connect(v51);
            v49.InputBegan:Connect(function(v52) --[[ Line: 93 ]]
                -- upvalues: v51 (copy)
                if v52.UserInputState == Enum.UserInputState.Begin and v52.KeyCode == Enum.KeyCode.ButtonR2 then
                    v51();
                end;
            end);
            v49.MouseEnter:Connect(function() --[[ Line: 99 ]]
                -- upvalues: v29 (ref)
                v29();
            end);
            return;
        end;
    end;
end;
v31.SetTarget = function(_, v55) --[[ Line: 107 ]]
    -- upvalues: v32 (ref), v31 (copy), v22 (copy), v12 (copy), l_PetList_0 (copy), v53 (copy), l_DefaultPetActions_0 (copy), l_Radialize_0 (copy)
    v32 = nil;
    if v31.Target == v55 then
        return;
    else
        v31.Target = v55;
        if not v55 then
            return;
        else
            for _, v57 in v22:GetChildren() do
                if v57:HasTag("PetActionButton") then
                    v57:Destroy();
                end;
            end;
            local l_v12_PetDataFromPetObject_0 = v12:GetPetDataFromPetObject(v55);
            if not l_v12_PetDataFromPetObject_0 then
                return;
            else
                for _, v60 in l_PetList_0[l_v12_PetDataFromPetObject_0.PetType].Actions do
                    v53(v60);
                end;
                for _, v62 in l_DefaultPetActions_0 do
                    v53(v62);
                end;
                l_Radialize_0(v22);
                return;
            end;
        end;
    end;
end;
local v63 = nil;
v31.Toggle = function(_, v65) --[[ Line: 139 ]]
    -- upvalues: v31 (copy), l_TweenService_0 (copy), l_UIScale_0 (copy), l_PetStatesRegistry_0 (copy), v12 (copy), v63 (ref), v21 (copy), l_UserInputService_0 (copy)
    if v31.Active == v65 then
        return;
    else
        v31.Active = v65;
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.1), {
            Scale = v65 and 1 or 0
        }):Play();
        local l_Target_0 = v31.Target;
        if l_Target_0 then
            local l_l_Target_0_Attribute_0 = l_Target_0:GetAttribute("UUID");
            local l_l_Target_0_Attribute_1 = l_Target_0:GetAttribute("OWNER");
            if v65 then
                v31.LastStateBeforeInspection = l_PetStatesRegistry_0[v12:GetServerState(l_l_Target_0_Attribute_1, l_l_Target_0_Attribute_0).CurrentState];
                v63 = tick();
                game.Workspace:SetAttribute("LastMenu", v63);
                game:GetService("GamepadService"):EnableGamepadCursor(v21);
                if l_UserInputService_0.GamepadEnabled and l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Gamepad1 then
                    game:GetService("RunService"):BindToRenderStep("LockOn", Enum.RenderPriority.Camera.Value + 1, function(v69) --[[ Line: 158 ]]
                        -- upvalues: l_Target_0 (copy)
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.Position, l_Target_0:GetPivot().Position), v69 * 2);
                    end);
                    return;
                end;
            elseif not v65 then
                v31.Target = nil;
                if v31.LastStateBeforeInspection then
                    if game.Workspace:GetAttribute("LastMenu") == v63 then
                        game:GetService("GamepadService"):DisableGamepadCursor();
                    end;
                    task.spawn(function() --[[ Line: 170 ]]
                        game:GetService("RunService"):UnbindFromRenderStep("LockOn");
                    end);
                end;
            end;
        end;
        return;
    end;
end;
local function _(v70) --[[ Line: 179 ]] --[[ Name: _ ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    if not v70 then
        return;
    else
        local v71, v72 = l_CurrentCamera_0:WorldToScreenPoint(v70);
        return UDim2.fromOffset(v71.X, v71.Y), v72;
    end;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 188 ]]
    -- upvalues: v31 (copy), l_CurrentCamera_0 (ref), l_PetActionUI_0 (copy)
    if not v31.Active then
        return;
    elseif not v31.Target then
        v31:Toggle(false);
        return;
    else
        local v74 = v31.Target.Position + Vector3.new(0, 2.5 + v31.Target.Size.Y / 2, 0);
        local v75 = nil;
        local v76 = nil;
        if not v74 then
            v76 = nil;
            v75 = nil;
        else
            local v77, v78 = l_CurrentCamera_0:WorldToScreenPoint(v74);
            v76 = UDim2.fromOffset(v77.X, v77.Y);
            v75 = v78;
        end;
        l_PetActionUI_0.Position = v75 and v76 or UDim2.fromScale(2, 2);
        return;
    end;
end);
v26(v21).MouseButton1Down:Connect(function() --[[ Line: 210 ]]
    -- upvalues: v31 (copy), l_LocalPlayer_0 (copy)
    v31:Toggle(false);
    l_LocalPlayer_0:SetAttribute("DontOpenAction", true);
    task.delay(0.3, function() --[[ Line: 214 ]]
        -- upvalues: l_LocalPlayer_0 (ref)
        l_LocalPlayer_0:SetAttribute("DontOpenAction", false);
    end);
end);
local function v79() --[[ Line: 219 ]] --[[ Name: v79 ]]
    -- upvalues: v39 (copy), v31 (copy), l_LocalPlayer_0 (copy)
    if v39() then
        return;
    else
        v31:Toggle(false);
        l_LocalPlayer_0:SetAttribute("DontOpenAction", true);
        task.delay(0.3, function() --[[ Line: 226 ]]
            -- upvalues: l_LocalPlayer_0 (ref)
            l_LocalPlayer_0:SetAttribute("DontOpenAction", false);
        end);
        return;
    end;
end;
local v80 = {
    [Enum.UserInputType.MouseButton1] = {
        Activate = function() --[[ Line: 235 ]] --[[ Name: Activate ]]

        end
    }
};
local v81 = {
    [Enum.UserInputType.MouseButton1] = {
        Deactivate = function() --[[ Line: 242 ]] --[[ Name: Deactivate ]]
            -- upvalues: v79 (copy)
            v79();
        end
    }
};
l_UserInputService_0.InputBegan:Connect(function(v82, v83) --[[ Line: 248 ]]
    -- upvalues: v80 (copy)
    if v83 then
        return;
    else
        local v84 = v80[v82.KeyCode] or v80[v82.UserInputType];
        if not v84 then
            return;
        else
            for _, v86 in v84 do
                task.spawn(v86);
            end;
            return;
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v87, v88) --[[ Line: 264 ]]
    -- upvalues: v81 (copy)
    if v88 then
        return;
    else
        local v89 = v81[v87.KeyCode] or v81[v87.UserInputType];
        if not v89 then
            return;
        else
            for _, v91 in v89 do
                task.spawn(v91);
            end;
            return;
        end;
    end;
end);
l_UserInputService_0.TouchTap:Connect(function() --[[ Line: 280 ]]
    -- upvalues: v79 (copy)
    v79();
end);
return v31;