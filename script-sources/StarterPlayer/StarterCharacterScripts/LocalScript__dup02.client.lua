-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Character_0 = l_LocalPlayer_0.Character;
local v2 = false;
while l_Character_0 == nil do
    task.wait();
    l_Character_0 = l_LocalPlayer_0.Character;
end;
l_Character_0.ChildAdded:Connect(function(v3) --[[ Line: 9 ]]
    -- upvalues: l_Character_0 (ref), v2 (ref)
    if l_Character_0:FindFirstChildWhichIsA("Tool") and v3:FindFirstChild("Weight") then
        v2 = true;
    end;
end);
l_Character_0.ChildRemoved:Connect(function(_) --[[ Line: 17 ]]
    -- upvalues: l_Character_0 (ref), v2 (ref)
    local l_Tool_0 = l_Character_0:FindFirstChildWhichIsA("Tool");
    if l_Tool_0 == nil then
        v2 = false;
        return;
    else
        if l_Tool_0:FindFirstChild("Weight") == nil then
            v2 = false;
        end;
        return;
    end;
end);
task.spawn(function() --[[ Line: 27 ]]
    -- upvalues: v2 (ref)
    while true do
        task.wait(0.1);
        if v2 == true then
            for _, v7 in pairs(game.Players:GetChildren()) do
                if v7.Name ~= game.Players.LocalPlayer.Name then
                    if v7 and v7.Character and v7.Character.PrimaryPart then
						local l_HumanoidRootPart_0 = v7.Character:FindFirstChild("HumanoidRootPart");
                        if l_HumanoidRootPart_0 then
                            for _, v10 in pairs(l_HumanoidRootPart_0:GetChildren()) do
                                if v10:IsA("ProximityPrompt") then
                                    v10.Enabled = true;
                                end;
                            end;
                        end;
                    end;
                elseif v7 and v7.Character and v7.Character.PrimaryPart then
					local l_HumanoidRootPart_1 = v7.Character:FindFirstChild("HumanoidRootPart");
                    if l_HumanoidRootPart_1 then
                        for _, v13 in pairs(l_HumanoidRootPart_1:GetChildren()) do
                            if v13:IsA("ProximityPrompt") then
                                v13.Enabled = false;
                            end;
                        end;
                    end;
                end;
            end;
        else
            for _, v15 in pairs(game.Players:GetChildren()) do
                if v15 and v15.Character and v15.Character.PrimaryPart then
					local l_HumanoidRootPart_2 = v15.Character:FindFirstChild("HumanoidRootPart");
                    if l_HumanoidRootPart_2 then
                        for _, v18 in pairs(l_HumanoidRootPart_2:GetChildren()) do
                            if v18:IsA("ProximityPrompt") then
                                v18.Enabled = false;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end);