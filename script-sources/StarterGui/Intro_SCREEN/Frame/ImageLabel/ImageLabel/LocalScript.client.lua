-- Thanks For Angelus Decompiles Decompiles https://discord.gg/CYXme7yEG9

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("TweenService")
local v2 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v3 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0)
local v4 = v1:Create(script.Parent, v2, {
    ["Rotation"] = 5
})
local v5 = v1:Create(script.Parent, v3, {
    ["Rotation"] = 0
})
local v6 = v1:Create(script.Parent, v2, {
    ["Rotation"] = -5
})
local v7 = v1:Create(script.Parent, v3, {
    ["Rotation"] = 0
})
while true do
    v4:Play()
    task.wait(v2.Time)
    v5:Play()
    task.wait(v3.Time)
    v6:Play()
    task.wait(v2.Time)
    v7:Play()
    task.wait(v3.Time)
end