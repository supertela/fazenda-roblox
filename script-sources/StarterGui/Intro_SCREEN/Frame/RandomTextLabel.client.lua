-- Thanks For Angelus Decompiles Decompiles https://discord.gg/CYXme7yEG9

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game.ReplicatedStorage.Intro_Screen
local v_u_2 = game:GetService("TweenService")
local v_u_3 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
function TXT_FUNCTION(p4)
    -- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_3
    local v5 = v_u_1:Clone()
    v5.TextTransparency = 1
    v5.TextStrokeTransparency = 1
    v_u_2:Create(v5, v_u_3, {
        ["TextTransparency"] = 0,
        ["TextStrokeTransparency"] = 0
    }):Play()
    local v6 = v5.Position
    local v7 = v5.Position + UDim2.new(0, 0, 0.01, 0)
    v5.Position = v7
    v_u_2:Create(v5, v_u_3, {
        ["Position"] = v6
    }):Play()
    local v8 = string.len(p4) * 0.1
    local v9 = math.sqrt(v8)
    v5.Text = p4
    v5.Parent = script.Parent
    task.wait(v9 + math.random(4, 7))
    v_u_2:Create(v5, v_u_3, {
        ["TextTransparency"] = 1,
        ["TextStrokeTransparency"] = 1
    }):Play()
    v_u_2:Create(v5, v_u_3, {
        ["Position"] = v7
    }):Play()
    game.Debris:AddItem(v5, v_u_3.Time)
    task.wait(v_u_3.Time)
end
game:GetService("TweenService")
TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v10 = {
    "<font color=\"#FFFF00\">Gold</font> plants are rare, but valuable!",
	"Your Plants literally grow <b>OFFLINE</b>",
    "The <i>best</i> seeds have a <i>small</i> chance of restocking!",
    "The seed store restocks every 5 minutes!",
    "You can flex your fruits and finds to other people!",
    "<font color=\"#FFFF00\">Private Servers</font> are free for everyone!",
    "Playing with friends makes the game even more fun!",
    "There is a small chance for <font color=\"#FF0000\">r</font><font color=\"#FF7F00\">a</font><font color=\"#FFFF00\">i</font><font color=\"#00FF00\">n</font><font color=\"#0000FF\">b</font><font color=\"#4B0082\">o</font><font color=\"#8B00FF\">w</font> crops!"
}
local v11 = ""
while true do
    local v12 = v10[math.random(1, #v10)]
    while v12 == v11 do
        task.wait()
        v12 = v10[math.random(1, #v10)]
    end
    TXT_FUNCTION(v12)
    task.wait()
    v11 = v12
end