-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetsService, time of decompilation: Wed Jun  4 21:32:01 2025 ]]
local v0 = {};
local l_PetsService_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetsService");
v0.EquipPet = function(_, v3, v4) --[[ Line: 5 ]]
    -- upvalues: l_PetsService_0 (copy)
    l_PetsService_0:FireServer("EquipPet", v3, v4);
end;
v0.UnequipPet = function(_, v6) --[[ Line: 9 ]]
    -- upvalues: l_PetsService_0 (copy)
    l_PetsService_0:FireServer("UnequipPet", v6);
end;
return v0;