-- Thanks For Angelus Decompiles Decompiles https://discord.gg/CYXme7yEG9

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("StarterGui")
local v3 = game:GetService("UserInputService")
local v4 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local v_u_5 = game:GetService("Debris")
local v_u_6 = game.Workspace
local _ = game.SoundService
local v7 = game.ReplicatedStorage
local v_u_8 = script.Parent
local v_u_9 = v_u_8.Parent
local v10 = v_u_9.Parent
v10.Enabled = true
v2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
local v_u_11 = v_u_9.Max.Value
local v_u_12 = v_u_9.Side_Frame_2
v_u_12.Text = "0/" .. tostring(v_u_11)
task.wait(math.random(8, 12) * 0.1)
local v_u_13 = 1
task.spawn(function()
    -- upvalues: (ref) v_u_13
    while true do
        if math.random(1, 3) == 1 then
            v_u_13 = 10
        else
            v_u_13 = math.random(1, 3)
        end
        v_u_13 = v_u_13 * math.random(1, 20)
        if math.random(1, 3) == 1 then
            v_u_13 = v_u_13 * 3
        end
        task.wait(math.random(1, 30) * 0.1)
    end
end)
local v_u_14 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local v_u_15 = v_u_13
local v16 = {}
local v_u_17 = {}
for _, v18 in ipairs(v_u_9:GetChildren()) do
    if v18:IsA("TextLabel") and v18.Name ~= "Side_Frame_3" then
        table.insert(v16, v18)
    end
end
for _, v19 in ipairs(v16) do
    local v20 = v_u_1:Create(v19, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["TextTransparency"] = 1,
        ["TextStrokeTransparency"] = 1
    })
    table.insert(v_u_17, v20)
end
local v21 = v_u_1:Create(v_u_9, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    ["BackgroundTransparency"] = 0.5
})
table.insert(v_u_17, v21)
local v22 = v_u_6:WaitForChild("Intro")
local v23 = v_u_6.Camera
local v24 = v22:WaitForChild("Part")
v23.CameraType = Enum.CameraType.Scriptable
v23.CFrame = v24.CFrame
local v_u_25 = {}
for _, v26 in ipairs(v10.Parent:GetDescendants()) do
    if v26:IsA("ScreenGui") and v26.Name ~= v10.Name then
        v26:SetAttribute("bruh", v26.Enabled)
        v26.Enabled = false
        table.insert(v_u_25, v26)
    end
end
local v_u_27 = require(v7.Field_Of_View_Module)
local v_u_29 = false
local function v_u_38()
    -- upvalues: (ref) v_u_29, (copy) v_u_28, (copy) v_u_8, (copy) v_u_9, (copy) v_u_1, (copy) v_u_14, (copy) v_u_6, (copy) v_u_27, (copy) v_u_25
    if not v_u_29 then
        v_u_29 = true
        v_u_8.Value = 2500
        local v30 = {}
        for _, v31 in ipairs(v_u_9.Parent:GetDescendants()) do
            local v32 = nil
            if v31:IsA("Frame") then
                v32 = v_u_1:Create(v31, v_u_14, {
                    ["BackgroundTransparency"] = 1
                })
            elseif v31:IsA("TextLabel") then
                v32 = v_u_1:Create(v31, v_u_14, {
                    ["TextTransparency"] = 1,
                    ["TextStrokeTransparency"] = 1
                })
            elseif v31:IsA("ImageLabel") then
                v32 = v_u_1:Create(v31, v_u_14, {
                    ["ImageTransparency"] = 1,
                    ["BackgroundTransparency"] = 1
                })
            end
            if v32 then
                table.insert(v30, v32)
            end
        end
        for _, v33 in ipairs(v30) do
            v33:Play()
        end
        local v34 = game.Players.LocalPlayer
        v_u_6.CurrentCamera.CameraSubject = v34.Character.Humanoid
        v_u_6.CurrentCamera.CameraType = Enum.CameraType.Custom
        v_u_27.Return_Core_FOV(90)
        v_u_6.CurrentCamera.FieldOfView = 100
        v_u_27.Change_FOV(70, math.random(3, 4))
        for _, v35 in ipairs(v_u_9:GetDescendants()) do
            if v35:IsA("LocalScript") then
                v35.Enabled = false
            end
        end
        for _, v36 in ipairs(v_u_25) do
            local v37 = v36:GetAttribute("bruh")
            if v37 ~= nil then
                v36.Enabled = v37
            end
        end
    end
end
local v_u_39 = false
v3.InputBegan:Connect(function()
    -- upvalues: (ref) v_u_39, (copy) v_u_38
    if v_u_39 then
        v_u_38()
    end
end)
task.spawn(function()
    -- upvalues: (copy) v_u_8, (ref) v_u_15, (copy) v_u_9, (copy) v_u_1, (copy) v_u_5, (copy) v_u_12, (ref) v_u_39, (copy) v_u_14, (copy) v_u_17
    repeat
        local v40 = TweenInfo.new(math.random(1, 20) * 0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local v41 = v_u_8.Value + v_u_15 * (time() * 0.5)
        local v42 = v_u_9.Max.Value
        local v43 = v_u_1:Create(v_u_8, v40, {
            ["Value"] = math.clamp(v41, 0, v42)
        })
        v43:Play()
        v_u_5:AddItem(v43, v40.Time)
        task.wait(v40.Time)
    until v_u_8.Value >= 2500
    v_u_12.Text = "Fully Loaded!"
    v_u_39 = true
    v_u_1:Create(v_u_9.Side_Frame_3, v_u_14, {
        ["TextTransparency"] = 0,
        ["TextStrokeTransparency"] = 0
    }):Play()
    task.wait(math.random(7, 11))
    for _, v44 in ipairs(v_u_17) do
        v44:Play()
    end
end)
task.spawn(function()
    -- upvalues: (ref) v_u_39, (copy) v_u_9, (copy) v_u_1, (copy) v_u_14
    task.wait(math.random(4, 7))
    v_u_39 = true
    v_u_1:Create(v_u_9.Side_Frame_1, v_u_14, {
        ["TextTransparency"] = 0,
        ["TextStrokeTransparency"] = 0
    }):Play()
end)
v_u_8:GetPropertyChangedSignal("Value"):Connect(function()
    -- upvalues: (copy) v_u_12, (copy) v_u_8, (copy) v_u_11
    local v45 = v_u_12
    local v46 = v_u_8.Value
    local v47 = math.round(v46)
    local v48 = v_u_11
    v45.Text = "Loading " .. tostring(v47) .. "/" .. tostring(v48)
end)