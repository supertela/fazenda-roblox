-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Framework, time of decompilation: Thu Jun  5 11:11:12 2025 ]]
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local v4 = require(l_ReplicatedStorage_0.Modules.SessionTimeLuckController);
local v5 = require(l_ReplicatedStorage_0.Modules.PlayerLuck);
local l_SendClientWeatherEvents_0 = l_ReplicatedStorage_0.GameEvents:WaitForChild("SendClientWeatherEvents");
local l_WeatherEventStarted_0 = l_ReplicatedStorage_0.GameEvents:WaitForChild("WeatherEventStarted");
local l_BottomFrame_0 = script.Parent:WaitForChild("BottomFrame");
local l_Holder_0 = l_BottomFrame_0:WaitForChild("Holder");
local l_Info_0 = l_BottomFrame_0:WaitForChild("Info");
local v11 = {
    Rain = {
        Title = "Rain", 
        Description = "+50% Grow Speed! Higher <font color=\"#0055ff\">WET</font> Fruit Chance!"
    }, 
    ChocolateRain = {
        Title = "Chocolate Rain", 
        Description = "Higher <font color=\"#666633\">Chocolate</font> Fruit Chance!"
    }, 
    Thunderstorm = {
        Title = "Thunderstorm", 
        Description = "+50% Grow Speed! Higher <font color=\"#0055ff\">SHOCKED</font> Fruit Chance!"
    }, 
    Frost = {
        Title = "Frost", 
        Description = "+50% Grow Speed! Higher <font color=\"#66ccff\">CHILLED</font> and <font color=\"#00e5ff\">FROZEN</font> Fruit Chance!"
    }, 
    Night = {
        Title = "Night", 
        Description = "Your fruit can become <font color=\"#a347fd\">MOONLIT</font>!"
    }, 
    BloodMoon = {
        Title = "Blood Moon", 
        Description = "Your fruit can become <font color=\"#550000\">BLOODLIT</font>!"
    }, 
    MeteorShower = {
        Title = "Meteor Shower", 
        Description = "Higher <font color=\"#0055ff\">CELESTIAL</font> Fruit Chance!"
    }, 
    Tornado = {
        Title = "Tornado", 
        Description = "Higher <font color=\"#D3D3D3\">TWISTED</font> Fruit Chance!"
    }, 
    Disco = {
        Title = "DISCO", 
        Description = "Small chance for fruit to turn <font color=\"#FF007F\">D</font><font color=\"#FFD700\">I</font><font color=\"#00FFFF\">S</font><font color=\"#00FF00\">C</font><font color=\"#8A2BE2\">O</font>!"
    }, 
    Luck = {
        Title = "Luck", 
        Description = function() --[[ Line: 55 ]] --[[ Name: Description ]]
            -- upvalues: v4 (copy)
            return ("+%*%% Playtime Luck"):format((math.floor(v4:GetCurrentLuck() * 100)));
        end
    }, 
    ServerLuck = {
        Title = "Server Luck", 
        Description = function() --[[ Line: 61 ]] --[[ Name: Description ]]
            if game.ReplicatedStorage.ServerLuck.Value == 1 then
                return "Increase it! Right now its at 0%";
            else
                return ("+%*%% Server Luck"):format((math.floor((game.ReplicatedStorage.ServerLuck.Value - 1) * 100)));
            end;
        end
    }
};
local v12 = false;
local v13 = {};
local v14 = {};
local function v49() --[[ Line: 95 ]] --[[ Name: updateEventDisplay ]]
    -- upvalues: v13 (copy), v12 (ref), l_Holder_0 (copy), l_TweenService_0 (copy), l_Info_0 (copy)
    if #v13 == 0 and v12 then
        v12 = false;
        local v31 = {
            Position = UDim2.fromScale(1, 1.2)
        };
        local l_Quint_0 = Enum.EasingStyle.Quint;
        local l_In_0 = Enum.EasingDirection.In;
        l_TweenService_0:Create(l_Holder_0, TweenInfo.new(0.25, l_Quint_0 or Enum.EasingStyle.Linear, l_In_0 or Enum.EasingDirection.InOut, 0, false, 0), v31):Play();
        l_Info_0.Visible = false;
        task.delay(0.25, function() --[[ Line: 105 ]]
            -- upvalues: l_Holder_0 (ref)
            l_Holder_0.Visible = false;
        end);
        return;
    else
        if not v12 and #v13 > 0 then
            v12 = true;
            l_Holder_0.Position = UDim2.fromScale(0.5, -0.25);
            l_Holder_0.Visible = true;
            for _, v35 in l_Holder_0.List:GetChildren() do
                if v35:IsA("Frame") then
                    v35.Visible = false;
                end;
            end;
            local v36 = {
                Position = UDim2.fromScale(1, 1)
            };
            local l_Back_0 = Enum.EasingStyle.Back;
            local l_Out_1 = Enum.EasingDirection.Out;
            l_TweenService_0:Create(l_Holder_0, TweenInfo.new(0.5, l_Back_0 or Enum.EasingStyle.Linear, l_Out_1 or Enum.EasingDirection.InOut, 0, false, 0), v36):Play();
            task.wait(0.4);
        end;
        if v12 then
            for _, v40 in l_Holder_0.List:GetChildren() do
                if v40:IsA("Frame") then
                    if table.find(v13, v40.Name) then
                        if not v40.Visible then
                            v40.UIScale.Scale = 0;
                            v40.Visible = true;
                            local l_UIScale_0 = v40.UIScale;
                            local v42 = {
                                Scale = 1
                            };
                            local l_Back_1 = Enum.EasingStyle.Back;
                            local l_Out_2 = Enum.EasingDirection.Out;
                            l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.25, l_Back_1 or Enum.EasingStyle.Linear, l_Out_2 or Enum.EasingDirection.InOut, 0, false, 0), v42):Play();
                        end;
                    elseif v40.Visible then
                        local l_UIScale_1 = v40.UIScale;
                        local v46 = {
                            Scale = 0
                        };
                        local l_Back_2 = Enum.EasingStyle.Back;
                        local l_In_1 = Enum.EasingDirection.In;
                        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.25, l_Back_2 or Enum.EasingStyle.Linear, l_In_1 or Enum.EasingDirection.InOut, 0, false, 0), v46):Play();
                        task.delay(0.25, function() --[[ Line: 148 ]]
                            -- upvalues: v40 (copy)
                            v40.Visible = false;
                        end);
                    end;
                end;
            end;
        end;
        return;
    end;
end;
local function v53(v50, v51) --[[ Line: 160 ]] --[[ Name: addTemporaryEvent ]]
    -- upvalues: v13 (copy), v49 (copy)
    if not table.find(v13, v50) then
        table.insert(v13, v50);
        v49();
    end;
    task.delay(v51, function() --[[ Line: 165 ]]
        -- upvalues: v13 (ref), v50 (copy), v49 (ref)
        local v52 = table.find(v13, v50);
        if not v52 then
            return;
        else
            table.remove(v13, v52);
            v49();
            return;
        end;
    end);
end;
l_SendClientWeatherEvents_0.OnClientEvent:Connect(function(v62, v63, v64) --[[ Line: 204 ]]
    -- upvalues: v14 (ref), v53 (copy)
    v14 = v62;
    if not v63 or not v14[v63] then
        return;
    else
        local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
        local v66 = v64 + v14[v63].eventLength - l_workspace_ServerTimeNow_0;
        if v66 <= 0 then
            return;
        else
            v53(v63, v66);
            return;
        end;
    end;
end);
l_WeatherEventStarted_0.OnClientEvent:Connect(function(v67, v68) --[[ Line: 220 ]]
    -- upvalues: v53 (copy)
    v53(v67, v68);
end);
local function v80(v69) --[[ Line: 225 ]] --[[ Name: setupInfoPopupEvents ]]
    -- upvalues: l_Info_0 (copy), l_UserInputService_0 (copy), v13 (copy), v11 (copy)
    v69:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 226 ]]
        -- upvalues: v69 (copy), l_Info_0 (ref)
        if not v69.Visible then
            l_Info_0.Visible = false;
        end;
    end);
    if l_UserInputService_0.TouchEnabled then
        v69.InputBegan:Connect(function() --[[ Line: 233 ]]
            -- upvalues: v13 (ref), v69 (copy), l_Info_0 (ref), v11 (ref)
            if table.find(v13, v69.Name) then
                local l_Title_1 = l_Info_0.Title;
                local v71 = v11[v69.Name];
                local v72;
                if not v71 then
                    v72 = "Event Not Found";
                else
                    local l_Title_2 = v71.Title;
                    if type(l_Title_2) == "function" then
                        l_Title_2 = l_Title_2();
                    end;
                    v72 = l_Title_2;
                end;
                l_Title_1.Text = v72;
                l_Title_1 = l_Info_0.Description;
                v71 = v11[v69.Name];
                if not v71 then
                    v72 = "Event Not Found";
                else
                    local l_Description_1 = v71.Description;
                    if type(l_Description_1) == "function" then
                        l_Description_1 = l_Description_1();
                    end;
                    v72 = l_Description_1;
                end;
                l_Title_1.Text = v72;
                l_Info_0.Visible = true;
            end;
        end);
        v69.InputEnded:Connect(function() --[[ Line: 240 ]]
            -- upvalues: l_Info_0 (ref)
            l_Info_0.Visible = false;
        end);
        return;
    else
        v69.MouseEnter:Connect(function() --[[ Line: 244 ]]
            -- upvalues: v13 (ref), v69 (copy), l_Info_0 (ref), v11 (ref)
            if table.find(v13, v69.Name) then
                local l_Title_3 = l_Info_0.Title;
                local v76 = v11[v69.Name];
                local v77;
                if not v76 then
                    v77 = "Event Not Found";
                else
                    local l_Title_4 = v76.Title;
                    if type(l_Title_4) == "function" then
                        l_Title_4 = l_Title_4();
                    end;
                    v77 = l_Title_4;
                end;
                l_Title_3.Text = v77;
                l_Title_3 = l_Info_0.Description;
                v76 = v11[v69.Name];
                if not v76 then
                    v77 = "Event Not Found";
                else
                    local l_Description_2 = v76.Description;
                    if type(l_Description_2) == "function" then
                        l_Description_2 = l_Description_2();
                    end;
                    v77 = l_Description_2;
                end;
                l_Title_3.Text = v77;
                l_Info_0.Visible = true;
            end;
        end);
        v69.MouseLeave:Connect(function() --[[ Line: 251 ]]
            -- upvalues: l_Info_0 (ref)
            l_Info_0.Visible = false;
        end);
        return;
    end;
end;
if l_UserInputService_0.TouchEnabled then
    l_BottomFrame_0.Position = UDim2.new(1, 0, 0.1, 0);
    l_Info_0.Position = UDim2.new(0.95, 0, 1.8, 0);
end;
for _, v82 in l_Holder_0.List:GetChildren() do
    if v82:IsA("Frame") then
        v80(v82);
    end;
end;
v5.Listen(l_Players_0.LocalPlayer, function() --[[ Line: 270 ]]
    -- upvalues: v5 (copy), l_Players_0 (copy), v13 (copy), v49 (copy)
    if #v5.GetModifiers(l_Players_0.LocalPlayer, nil, "BottomDisplay") > 0 then
        if not table.find(v13, "Luck") then
            table.insert(v13, "Luck");
            v49();
            return;
        end;
    else
        local v83 = table.find(v13, "Luck");
        if v83 then
            table.remove(v13, v83);
            v49();
        end;
    end;
end);
if #v5.GetModifiers(l_Players_0.LocalPlayer, nil, "BottomDisplay") > 0 and not table.find(v13, "Luck") then
    table.insert(v13, "Luck");
end;
task.spawn(function() --[[ Line: 293 ]]
    -- upvalues: v13 (copy), v49 (copy)
    local l_ServerLuck_0 = game.ReplicatedStorage.ServerLuck;
    if l_ServerLuck_0.Value > 1 and not table.find(v13, "ServerLuck") then
        table.insert(v13, "ServerLuck");
    end;
    l_ServerLuck_0.Changed:Connect(function() --[[ Line: 302 ]]
        -- upvalues: l_ServerLuck_0 (copy), v13 (ref), v49 (ref)
        if l_ServerLuck_0.Value > 1 then
            if not table.find(v13, "ServerLuck") then
                table.insert(v13, "ServerLuck");
            end;
            v49();
        end;
    end);
end);
v49();