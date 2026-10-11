-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: EggInfoPopulator, time of decompilation: Wed Jun  4 21:32:28 2025 ]]
local _ = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Data.PetEggData);
local v3 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local l_Content_0 = script.Parent:WaitForChild("Content");
local l_SEGMENT_0 = l_Content_0:WaitForChild("SEGMENT");
local v6 = {
    ["Bee Egg"] = "rbxassetid://100313281527054", 
    ["Common Egg"] = "rbxassetid://110495383642358", 
    ["Uncommon Egg"] = "rbxassetid://116378505754760", 
    ["Rare Egg"] = "rbxassetid://111372276806205", 
    ["Legendary Egg"] = "rbxassetid://97799911854888", 
    ["Mythical Egg"] = "rbxassetid://83210224500991", 
    ["Bug Egg"] = "rbxassetid://83970205286930"
};
local v7 = {};
for v8, v9 in v2 do
    table.insert(v7, {
        Key = v8, 
        Value = v9
    });
end;
table.sort(v7, function(v10, v11) --[[ Line: 25 ]]
    local l_StockChance_0 = v10.Value.StockChance;
    local l_StockChance_1 = v11.Value.StockChance;
    if l_StockChance_0 == l_StockChance_1 then
        return v10.Value.EggName < v11.Value.EggName;
    else
        return l_StockChance_1 < l_StockChance_0;
    end;
end);
(function() --[[ Line: 34 ]]
    -- upvalues: l_Content_0 (copy), v7 (copy), l_SEGMENT_0 (copy), v6 (copy), v3 (copy)
    for _, v15 in l_Content_0:GetChildren() do
        if v15.Name == "SEGMENT_UNUSED" then
            v15:Destroy();
        end;
    end;
    local v16 = {};
    for _, v18 in v7 do
        table.insert(v16, {
            name = v18.Value.EggName, 
            chance = 1 / v18.Value.StockChance
        });
    end;
    local function v24(v19, v20) --[[ Line: 48 ]] --[[ Name: v24 ]]
        local v21 = 1;
        for _, v23 in ipairs(v19) do
            if v23.name == v20 then
                v21 = v21 * (1 - v21 * v23.chance);
                break;
            else
                v21 = v21 * (1 - v23.chance);
            end;
        end;
        return 1 - v21 ^ 3;
    end;
    for _, v26 in v7 do
        local v27 = l_SEGMENT_0:Clone();
        local l_Display_0 = v27:WaitForChild("Display");
        local l_EGG_IMAGE_0 = l_Display_0:WaitForChild("DisplayBox"):WaitForChild("EGG_IMAGE");
        local l_RARITY_NAME_0 = l_Display_0:WaitForChild("RARITY_NAME");
        local l_RARITY_PERCENTAGE_0 = l_Display_0:WaitForChild("RARITY_PERCENTAGE");
        v27.Parent = l_SEGMENT_0.Parent;
        l_EGG_IMAGE_0.Image = v6[v26.Value.EggName];
        l_RARITY_NAME_0.Text = v26.Value.EggName;
        l_RARITY_NAME_0.TextColor3 = v3.PetEggs[v26.Value.EggName].Color;
        local v32 = v24(v16, v26.Value.EggName) * 100;
        l_RARITY_PERCENTAGE_0.Text = ("%*%% of shops"):format((("%.0f"):format(v32)));
        l_RARITY_PERCENTAGE_0.TextColor3 = Color3.fromRGB(255, 255, 255);
        v27.LayoutOrder = 1000 / v32;
    end;
    task.wait(1);
    l_SEGMENT_0:Destroy();
end)();