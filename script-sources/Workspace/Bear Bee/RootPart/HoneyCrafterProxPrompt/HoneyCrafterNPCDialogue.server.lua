-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("Debris")
local v3 = game:GetService("ReplicatedStorage")
local v4 = v3:WaitForChild("GameEvents")
local v_u_5 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v_u_6 = require(v3.Modules.DataService)
local v_u_7 = require(v3.Modules.Chalk)
local v_u_8 = v4:WaitForChild("HoneyCrafterRemoteEvent")
local v_u_9 = require(game.ReplicatedStorage.Arrow_Module)
local v_u_10 = script.Parent.Parent.Parent
local v_u_11 = game.Players.LocalPlayer
local v_u_12 = require(game.ReplicatedStorage.Top_Text)
local v_u_13 = require(game.ReplicatedStorage.NPC_MOD)
local v_u_14 = v_u_7.color(Color3.fromRGB(255, 149, 0))("Honey")
local v_u_15 = game.SoundService.Notification
local v_u_16 = nil
local v_u_17 = false
local v_u_18 = true
local v_u_19 = false
local v_u_20 = nil
local function v_u_23(p21)
    -- upvalues: (ref) v_u_19
    local v22 = time()
    while time() - v22 < p21 do
        task.wait()
        if v_u_19 then
            return false
        end
    end
    return true
end
local function v_u_24()
    -- upvalues: (ref) v_u_19, (ref) v_u_18, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (ref) v_u_16, (copy) v_u_1, (copy) v_u_5, (copy) v_u_2, (copy) v_u_13, (ref) v_u_20
    v_u_19 = true
    v_u_18 = true
    v_u_12.TakeAwayResponses(v_u_10, v_u_11)
    if v_u_16 then
        v_u_1:Create(v_u_16, v_u_5, {
            ["OutlineTransparency"] = 1
        }):Play()
        v_u_2:AddItem(v_u_16, v_u_5.Time)
    end
    v_u_13.End_Speak(v_u_11)
    v_u_20 = nil
    task.wait(0.7)
    script.Parent.Enabled = true
end
local function v_u_25()
    -- upvalues: (ref) v_u_17, (copy) v_u_23, (copy) v_u_24, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (ref) v_u_18, (copy) v_u_13
    v_u_17 = false
    if not v_u_23(math.random(0.4, 0.5)) then
        return v_u_24()
    end
    task.wait(0.5)
    v_u_12.TakeAwayResponses(v_u_10, v_u_11)
    v_u_23(0.5)
    v_u_18 = true
    script.Parent.Enabled = true
    v_u_13.End_Speak(v_u_11)
end
local function v_u_38()
    -- upvalues: (ref) v_u_18, (ref) v_u_17, (ref) v_u_20, (copy) v_u_11, (copy) v_u_13, (ref) v_u_16, (copy) v_u_1, (copy) v_u_5, (copy) v_u_2, (ref) v_u_19, (copy) v_u_12, (copy) v_u_10, (copy) v_u_14, (copy) v_u_23, (copy) v_u_24, (copy) v_u_8, (copy) v_u_25
    if v_u_18 then
        v_u_18 = false
        v_u_17 = true
        v_u_20 = v_u_11
        v_u_13.Start_Speak(v_u_11)
        if v_u_16 then
            v_u_1:Create(v_u_16, v_u_5, {
                ["OutlineTransparency"] = 1
            }):Play()
            v_u_2:AddItem(v_u_16, v_u_5.Time)
        end
        v_u_19 = false
        script.Parent.Enabled = false
        v_u_12.NpcText(v_u_10, ("I\'m the %* Crafter"):format(v_u_14), false)
        if not v_u_23(math.random(1, 1.5)) then
            return v_u_24()
        end
        local v26 = v_u_12.ShowChoices(v_u_11, { "How do I craft?", "Lets Craft!", "Nevermind" })
        if v_u_19 then
            return v_u_24()
        end
        local v_u_27 = ""
        local v_u_28 = ""
        local v29 = {}
        for _, v30 in pairs(v26) do
            local v_u_31 = v30:FindFirstChild("Frame")
            if v_u_31 then
                local v32 = v_u_31:FindFirstChild("ImageButton")
                if v32 then
                    local v33 = v32.MouseButton1Click:Connect(function()
                        -- upvalues: (ref) v_u_27, (copy) v_u_31, (ref) v_u_28
                        v_u_27 = v_u_31.Frame.Text_Element:GetAttribute("Text")
                        if v_u_27 == "How do I craft?" then
                            v_u_28 = "How"
                            return
                        elseif v_u_27 == "Lets Craft!" then
                            v_u_28 = "Craft"
                        else
                            v_u_28 = "Nevermind"
                        end
                    end)
                    table.insert(v29, v33)
                end
            end
        end
        while v_u_28 == "" do
            task.wait()
            if v_u_19 then
                for _, v34 in pairs(v29) do
                    v34:Disconnect()
                end
                return v_u_24()
            end
        end
        for _, v35 in pairs(v29) do
            v35:Disconnect()
        end
        if v_u_19 then
            return v_u_24()
        end
        v_u_12.RemovePlayerSideFrame(v_u_11)
        if not v_u_11.Character then
            return v_u_24()
        end
        v_u_12.PlayerResponse(v_u_11.Character, v_u_27, true)
        local v36 = v_u_23
        local v37 = string.len(v_u_27) * 0.07
        if not v36((math.sqrt(v37))) then
            return v_u_24()
        end
        if v_u_28 == "How" then
            v_u_12.NpcText(v_u_10, "Place honey and plants in front of me.", true)
            task.wait(2)
            v_u_12.NpcText(v_u_10, "Then let me know", true)
            task.wait(2)
            v_u_12.NpcText(v_u_10, "And I\'ll whip you up something good", true)
            task.wait(2)
        elseif v_u_28 == "Craft" then
            v_u_12.NpcText(v_u_10, "Time to cook!", true)
            task.wait(0.5)
            v_u_12.TakeAwayResponses(v_u_10, v_u_11)
            v_u_8:FireServer("CraftItem")
            task.wait(0.5)
        else
            v_u_12.NpcText(v_u_10, "Goodbye!", true)
        end
        v_u_25()
    end
end
script.Parent.Triggered:Connect(function()
    -- upvalues: (copy) v_u_13, (copy) v_u_11, (copy) v_u_38
    if v_u_13.Can_Speak(v_u_11) then
        v_u_38()
    end
end)
local v_u_39 = game.SoundService.Click
script.Parent.PromptButtonHoldBegan:Connect(function()
    -- upvalues: (copy) v_u_39
    v_u_39.PlaybackSpeed = 1 + math.random(-15, 15) / 100
    v_u_39.Playing = true
    v_u_39.TimePosition = 0
end)
local v_u_40 = script.Parent.Parent.Position
task.spawn(function()
    -- upvalues: (ref) v_u_20, (copy) v_u_40, (ref) v_u_18, (ref) v_u_17, (copy) v_u_12, (copy) v_u_11, (copy) v_u_10, (copy) v_u_13, (copy) v_u_24
    while true do
        repeat
            task.wait(0.1)
        until v_u_20 and (v_u_20.Character and (v_u_20.Character.PrimaryPart and ((v_u_20.Character.PrimaryPart.Position - v_u_40).Magnitude > 17 and (not v_u_18 and v_u_17))))
        v_u_12.RemovePlayerSideFrame(v_u_11)
        v_u_12.NpcText(v_u_10, "Goodbye!", true)
        v_u_13.End_Speak(v_u_11)
        v_u_24()
    end
end)
script.Parent.PromptShown:Connect(function()
    -- upvalues: (ref) v_u_16, (copy) v_u_10, (copy) v_u_1, (copy) v_u_5
    v_u_16 = Instance.new("Highlight", v_u_10)
    v_u_16.DepthMode = Enum.HighlightDepthMode.Occluded
    v_u_16.FillTransparency = 1
    v_u_16.OutlineTransparency = 1
    v_u_16.Adornee = v_u_10
    v_u_1:Create(v_u_16, v_u_5, {
        ["OutlineTransparency"] = 0
    }):Play()
end)
local function v_u_44()
    -- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_9, (copy) v_u_11
    local v41 = v_u_6:GetData().HoneyCrafterEventData
    if v41.HoneyRequirementMet and v41.PlantRequirementMet then
        local v42 = v_u_7.color(Color3.fromRGB(255, 149, 0))("Thanks! I\'m ready to cook!")
        v_u_12.NpcText(v_u_10, ("%*"):format(v42), true)
        v_u_15.PlaybackSpeed = 1 + math.random(-15, 15) / 100
        v_u_15.Playing = true
        v_u_15.TimePosition = 0
        local v43 = v_u_9.GenerateArrow(v_u_11, v_u_10.PrimaryPart.Position, math.random(1, 1000000))
        task.wait(8)
        v_u_9.Remove_Arrow(v43)
    end
end
task.spawn(function()
    -- upvalues: (copy) v_u_6, (copy) v_u_44
    task.spawn(function()
        -- upvalues: (ref) v_u_6, (ref) v_u_44
        local v45 = v_u_6:GetPathSignal("HoneyCrafterEventData/@")
        if v45 then
            v45:Connect(v_u_44)
        end
        local v46 = v_u_6:GetPathSignal("HoneyCrafterEventData")
        if v46 then
            v46:Connect(v_u_44)
        end
    end)
end)
script.Parent.PromptHidden:Connect(function()
    -- upvalues: (ref) v_u_16, (copy) v_u_1, (copy) v_u_5, (copy) v_u_2
    if v_u_16 then
        v_u_1:Create(v_u_16, v_u_5, {
            ["OutlineTransparency"] = 1
        }):Play()
        v_u_2:AddItem(v_u_16, v_u_5.Time)
    end
end)