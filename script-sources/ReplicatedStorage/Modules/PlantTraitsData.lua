-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PlantTraitsData, time of decompilation: Wed Jun  4 21:30:58 2025 ]]
local v0 = {};
for v1, v2 in {
    Berry = {
        "Blueberry", 
        "Cranberry", 
        "Grape", 
        "Raspberry", 
        "Strawberry"
    }, 
    Candy = {
        "Blue Lollipop", 
        "Candy Blossom", 
        "Candy Sunflower", 
        "Chocolate Carrot", 
        "Easter Egg", 
        "Red Lollipop"
    }, 
    Flower = {
        "Candy Blossom", 
        "Candy Sunflower", 
        "Cherry Blossom", 
        "Crocus", 
        "Daffodil", 
        "Lotus", 
        "Orange Tulip", 
        "Pink Tulip"
    }, 
    Fruit = {
        "Apple", 
        "Avocado", 
        "Banana", 
        "Blueberry", 
        "Coconut", 
        "Cranberry", 
        "Dragon Fruit", 
        "Durian", 
        "Grape", 
        "Lemon", 
        "Mango", 
        "Papaya", 
        "Passionfruit", 
        "Peach", 
        "Pear", 
        "Pineapple", 
        "Raspberry", 
        "Strawberry", 
        "Watermelon"
    }, 
    Leafy = {
        "Apple", 
        "Blueberry", 
        "Cranberry", 
        "Eggplant", 
        "Grape", 
        "Mango", 
        "Peach", 
        "Pineapple", 
        "Pumpkin", 
        "Raspberry", 
        "Strawberry", 
        "Tomato", 
        "Watermelon", 
        "Cacao", 
        "Beanstalk"
    }, 
    Sour = {
        "Cranberry", 
        "Lemon", 
        "Passionfruit"
    }, 
    Sweet = {
        "Banana", 
        "Blue Lollipop", 
        "Blueberry", 
        "Candy Blossom", 
        "Candy Sunflower", 
        "Chocolate Carrot", 
        "Easter Egg", 
        "Grape", 
        "Mango", 
        "Peach", 
        "Pear", 
        "Pineapple", 
        "Raspberry", 
        "Red Lollipop", 
        "Strawberry", 
        "Watermelon"
    }, 
    Tropical = {
        "Banana", 
        "Coconut", 
        "Dragon Fruit", 
        "Durian", 
        "Mango", 
        "Papaya", 
        "Passionfruit", 
        "Pineapple", 
        "Watermelon"
    }, 
    Vegetable = {
        "Carrot", 
        "Chocolate Carrot", 
        "Corn", 
        "Eggplant", 
        "Pepper", 
        "Pumpkin", 
        "Purple Cabbage", 
        "Tomato", 
        "Beanstalk"
    }, 
    Woody = {
        "Apple", 
        "Avocado", 
        "Cacao", 
        "Coconut", 
        "Durian", 
        "Mango", 
        "Papaya", 
        "Peach", 
        "Pear"
    }, 
    Prickly = {
        "Cactus", 
        "Dragon Fruit", 
        "Durian", 
        "Pineapple", 
        "Venus Fly Trap"
    }, 
    Fungus = {
        "Mega Mushroom", 
        "Mushroom", 
        "Glowshroom"
    }
} do
    local v3 = {};
    for _, v5 in v2 do
        v3[v5] = true;
    end;
    v0[v1] = v3;
end;
v0.HasTrait = function(v6, v7) --[[ Line: 143 ]]
    -- upvalues: v0 (copy)
    if not v6 or v6 == "" then
        warn("PlantTraitsData.HasTrait | No plant name given!");
        return false;
    elseif not v7 or v7 == "" then
        warn("PlantTraitsData.HasTrait | No trait name given!");
        return false;
    else
        local v8 = v0[v7];
        return v8 and v8[v6] or false;
    end;
end;
return v0;