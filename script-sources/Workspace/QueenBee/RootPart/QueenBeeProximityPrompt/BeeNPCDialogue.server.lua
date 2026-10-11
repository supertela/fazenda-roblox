-- Thanks For Angelus Decompiles Decompiles https://discord.gg/CYXme7yEG9

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("Debris")
local v3 = game:GetService("ReplicatedStorage")
v3:WaitForChild("GameEvents")
local v_u_4 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v_u_5 = require(v3.Modules.GuiController)
local v_u_6 = require(v3.Modules.DataService)
local v7 = require(v3.Modules.Chalk)
local v_u_8 = script.Parent.Parent.Parent
local v_u_9 = game.Players.LocalPlayer
local v_u_10 = v_u_9.PlayerGui
local v_u_11 = require(game.ReplicatedStorage.Top_Text)
local v_u_12 = require(game.ReplicatedStorage.NPC_MOD)
local v_u_13 = v7.color(Color3.fromRGB(255, 149, 0))("Honey")
local v_u_14 = nil
local v_u_15 = false
local v_u_16 = true
local v_u_17 = false
local v_u_18 = nil
local function v_u_21(p19)
    -- upvalues: (ref) v_u_17
    local v20 = time()
    while time() - v20 < p19 do
        task.wait()
        if v_u_17 then
            return false
        end
    end
    return true
end
local function v_u_22()
    -- upvalues: (ref) v_u_17, (ref) v_u_16, (copy) v_u_11, (copy) v_u_8, (copy) v_u_9, (ref) v_u_14, (copy) v_u_1, (copy) v_u_4, (copy) v_u_2, (copy) v_u_12, (ref) v_u_18
    v_u_17 = true
    v_u_16 = true
    v_u_11.TakeAwayResponses(v_u_8, v_u_9)
    if v_u_14 then
        v_u_1:Create(v_u_14, v_u_4, {
            ["OutlineTransparency"] = 1
        }):Play()
        v_u_2:AddItem(v_u_14, v_u_4.Time)
    end
    v_u_12.End_Speak(v_u_9)
    v_u_18 = nil
    task.wait(0.7)
    script.Parent.Enabled = true
end
local function v_u_23()
    -- upvalues: (ref) v_u_15, (copy) v_u_21, (copy) v_u_22, (copy) v_u_11, (copy) v_u_8, (copy) v_u_9, (ref) v_u_16, (copy) v_u_12
    v_u_15 = false
    if not v_u_21(math.random(0.4, 0.5)) then
        return v_u_22()
    end
    task.wait(0.5)
    v_u_11.TakeAwayResponses(v_u_8, v_u_9)
    v_u_21(0.5)
    v_u_16 = true
    script.Parent.Enabled = true
    v_u_12.End_Speak(v_u_9)
end
local function v_u_24()
    -- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_13
    v_u_11.NpcText(v_u_8, "I\'m the Queen Bee", true)
    task.wait(2)
    v_u_11.NpcText(v_u_8, ("I\'ll trade %* for items"):format(v_u_13), true)
    task.wait(2)
end
local function v_u_37()
    -- upvalues: (ref) v_u_16, (ref) v_u_15, (ref) v_u_18, (copy) v_u_9, (copy) v_u_12, (ref) v_u_14, (copy) v_u_1, (copy) v_u_4, (copy) v_u_2, (ref) v_u_17, (copy) v_u_6, (copy) v_u_11, (copy) v_u_8, (copy) v_u_13, (copy) v_u_21, (copy) v_u_22, (copy) v_u_24, (copy) v_u_5, (copy) v_u_10, (copy) v_u_23
    if v_u_16 then
        v_u_16 = false
        v_u_15 = true
        v_u_18 = v_u_9
        v_u_12.Start_Speak(v_u_9)
        if v_u_14 then
            v_u_1:Create(v_u_14, v_u_4, {
                ["OutlineTransparency"] = 1
            }):Play()
            v_u_2:AddItem(v_u_14, v_u_4.Time)
        end
        v_u_17 = false
        script.Parent.Enabled = false
        v_u_6:GetData()
        v_u_11.NpcText(v_u_8, ("Would you like to trade %*?"):format(v_u_13), false)
        if not v_u_21(math.random(1, 1.5)) then
            return v_u_22()
        end
        local v25 = v_u_11.ShowChoices(v_u_9, {
            "What are you?",
            "I want to trade honey",
            "Where can I get honey?",
            "Nevermind"
        })
        if v_u_17 then
            return v_u_22()
        end
        local v_u_26 = ""
        local v_u_27 = ""
        local v28 = {}
        for _, v29 in pairs(v25) do
            local v_u_30 = v29:FindFirstChild("Frame")
            if v_u_30 then
                local v31 = v_u_30:FindFirstChild("ImageButton")
                if v31 then
                    local v32 = v31.MouseButton1Click:Connect(function()
                        -- upvalues: (ref) v_u_26, (copy) v_u_30, (ref) v_u_27
                        v_u_26 = v_u_30.Frame.Text_Element:GetAttribute("Text")
                        if v_u_26 == "What are you?" then
                            v_u_27 = "What"
                            return
                        elseif v_u_26 == "I want to trade honey" then
                            v_u_27 = "trade"
                            return
                        elseif v_u_26 == "Where can I get honey?" then
                            v_u_27 = "where"
                        else
                            v_u_27 = "Nevermind"
                        end
                    end)
                    table.insert(v28, v32)
                end
            end
        end
        while v_u_27 == "" do
            task.wait()
            if v_u_17 then
                for _, v33 in v28 do
                    v33:Disconnect()
                end
                return v_u_22()
            end
        end
        for _, v34 in v28 do
            v34:Disconnect()
        end
        if v_u_17 then
            return v_u_22()
        end
        v_u_11.RemovePlayerSideFrame(v_u_9)
        if not v_u_9.Character then
            return v_u_22()
        end
        v_u_11.PlayerResponse(v_u_9.Character, v_u_26, true)
        local v35 = v_u_21
        local v36 = string.len(v_u_26) * 0.07
        if not v35((math.sqrt(v36))) then
            return v_u_22()
        end
        if v_u_27 == "What" then
            v_u_24()
        elseif v_u_27 == "trade" then
            v_u_5:Open(v_u_10.HoneyEventShop_UI)
        elseif v_u_27 == "where" then
            v_u_11.NpcText(v_u_8, "In short, deposit plants, get honey", true)
            task.wait(2)
            v_u_11.NpcText(v_u_8, "Talk to Onett!", true)
            task.wait(2)
        else
            v_u_11.NpcText(v_u_8, "Goodbye!", true)
        end
        v_u_23()
    end
end
script.Parent.Triggered:Connect(function()
    -- upvalues: (copy) v_u_12, (copy) v_u_9, (copy) v_u_37
    if v_u_12.Can_Speak(v_u_9) then
        v_u_37()
    end
end)
local v_u_38 = game.SoundService.Click
script.Parent.PromptButtonHoldBegan:Connect(function()
    -- upvalues: (copy) v_u_38
    v_u_38.PlaybackSpeed = 1 + math.random(-15, 15) / 100
    v_u_38.Playing = true
    v_u_38.TimePosition = 0
end)
local v_u_39 = script.Parent.Parent.Position
task.spawn(function()
    -- upvalues: (ref) v_u_18, (copy) v_u_39, (ref) v_u_16, (ref) v_u_15, (copy) v_u_11, (copy) v_u_9, (copy) v_u_8, (copy) v_u_22
    while true do
        repeat
            task.wait(0.1)
        until v_u_18 and (v_u_18.Character and (v_u_18.Character.PrimaryPart and ((v_u_18.Character.PrimaryPart.Position - v_u_39).Magnitude > 17 and (not v_u_16 and v_u_15))))
        v_u_11.RemovePlayerSideFrame(v_u_9)
        v_u_11.NpcText(v_u_8, "Goodbye!", true)
        v_u_22()
    end
end)
script.Parent.PromptShown:Connect(function()
    -- upvalues: (ref) v_u_14, (copy) v_u_8, (copy) v_u_1, (copy) v_u_4
    v_u_14 = Instance.new("Highlight", v_u_8)
    v_u_14.DepthMode = Enum.HighlightDepthMode.Occluded
    v_u_14.FillTransparency = 1
    v_u_14.OutlineTransparency = 1
    v_u_14.Adornee = v_u_8
    v_u_1:Create(v_u_14, v_u_4, {
        ["OutlineTransparency"] = 0
    }):Play()
end)
script.Parent.PromptHidden:Connect(function()
    -- upvalues: (ref) v_u_14, (copy) v_u_1, (copy) v_u_4, (copy) v_u_2
    if v_u_14 then
        v_u_1:Create(v_u_14, v_u_4, {
            ["OutlineTransparency"] = 1
        }):Play()
        v_u_2:AddItem(v_u_14, v_u_4.Time)
    end
end)