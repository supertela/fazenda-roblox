-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ActivePetInputService, time of decompilation: Wed Jun  4 21:32:00 2025 ]]
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local _ = game:GetService("CollectionService");
local _ = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local v7 = require(l_ReplicatedStorage_0.Modules.PetServices.PetInformationUserInterfaceService);
local v8 = require(l_ReplicatedStorage_0.Modules.PetServices.PetActionUserInterfaceService);
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 13 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local v10 = require(l_ReplicatedStorage_0.Modules.GetMouseToWorld);
local l_Highlight_0 = Instance.new("Highlight");
l_Highlight_0.FillTransparency = 1;
local v12 = nil;
local v13 = nil;
local function v14() --[[ Line: 22 ]] --[[ Name: v14 ]]
    -- upvalues: v13 (ref), l_TweenService_0 (copy), l_Highlight_0 (copy)
    if not v13 then
        return;
    else
        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.2), {
            OutlineTransparency = 0.8
        }):Play();
        return;
    end;
end;
local function v15() --[[ Line: 33 ]] --[[ Name: v15 ]]
    -- upvalues: v13 (ref), l_TweenService_0 (copy), l_Highlight_0 (copy), l_LocalPlayer_0 (copy), v8 (copy)
    if not v13 then
        return;
    else
        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.2), {
            OutlineTransparency = 0
        }):Play();
        if l_LocalPlayer_0:GetAttribute("DontOpenAction") then
            return;
        elseif v8.Target == v13 then
            v8:Toggle(false);
            return;
        else
            if v8.Target ~= nil then
                v8:Toggle(false);
            end;
            task.delay(0.1, function() --[[ Line: 50 ]]
                -- upvalues: v8 (ref), v13 (ref)
                v8:SetTarget(v13);
                v8:Toggle(true);
            end);
            return;
        end;
    end;
end;
local v17 = {
    [Enum.UserInputType.Touch] = {
        function(_) --[[ Line: 61 ]]
            -- upvalues: v14 (copy)
            v14();
        end
    }, 
    [Enum.UserInputType.MouseButton1] = {
        function() --[[ Line: 67 ]]
            -- upvalues: v14 (copy)
            v14();
        end
    }, 
    [Enum.KeyCode.ButtonR2] = {
        function() --[[ Line: 73 ]]
            -- upvalues: v14 (copy)
            v14();
        end
    }
};
local v19 = {
    [Enum.UserInputType.Touch] = {
        function(_) --[[ Line: 81 ]]
            -- upvalues: v15 (copy)
            v15();
        end
    }, 
    [Enum.UserInputType.MouseButton1] = {
        function() --[[ Line: 87 ]]
            -- upvalues: v15 (copy)
            v15();
        end
    }, 
    [Enum.KeyCode.ButtonR2] = {
        function() --[[ Line: 93 ]]
            -- upvalues: v15 (copy)
            v15();
        end
    }
};
l_UserInputService_0.InputBegan:Connect(function(v20, _) --[[ Line: 99 ]]
    -- upvalues: v17 (copy)
    local v22 = v17[v20.KeyCode] or v17[v20.UserInputType];
    if not v22 then
        return;
    else
        for _, v24 in v22 do
            task.spawn(function() --[[ Line: 106 ]]
                -- upvalues: v24 (copy), v20 (copy)
                v24(v20);
            end);
        end;
        return;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v25, _) --[[ Line: 114 ]]
    -- upvalues: v19 (copy)
    local v27 = v19[v25.KeyCode] or v19[v25.UserInputType];
    if not v27 then
        return;
    else
        for _, v29 in v27 do
            task.spawn(function() --[[ Line: 121 ]]
                -- upvalues: v29 (copy), v25 (copy)
                v29(v25);
            end);
        end;
        return;
    end;
end);
l_UserInputService_0.TouchTap:Connect(function() --[[ Line: 129 ]]
    -- upvalues: v14 (copy)
    v14();
end);
l_UserInputService_0.TouchEnded:Connect(function() --[[ Line: 133 ]]
    -- upvalues: v15 (copy)
    v15();
end);
l_Highlight_0.Parent = script;
task.spawn(function() --[[ Line: 138 ]]
    -- upvalues: v12 (ref), l_UserInputService_0 (copy), v10 (copy), v8 (copy), v7 (copy), v13 (ref), l_Highlight_0 (copy)
    while true do
        v12 = l_UserInputService_0:GetMouseLocation();
        local v30 = RaycastParams.new();
        v30.FilterDescendantsInstances = {};
        local v31 = v10(v30, 1000);
        local v32 = v31 and v31.Instance;
        local v33 = v32 and v32:FindFirstAncestor("PetMover");
        if not v8.Active then
            v7:SetTarget(v33);
            if v33 then
                v7:Toggle(true);
            else
                v7:Toggle(false);
            end;
        elseif v8.Target == v8.Target then
            v7:Toggle(false);
        end;
        if v33 and v33:FindFirstChildWhichIsA("Model", true) then
            v13 = v33;
            l_Highlight_0.Adornee = v33 and v33:FindFirstChildWhichIsA("Model", true);
        else
            v13 = nil;
            l_Highlight_0.Adornee = nil;
        end;
        task.wait(0.2);
    end;
end);
return {};