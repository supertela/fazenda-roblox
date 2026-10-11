-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEquipSlotsUI, time of decompilation: Wed Jun  4 21:32:27 2025 ]]
local l_Parent_0 = script.Parent;
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v4 = require(l_ReplicatedStorage_0.Modules.PetEquipSlotsUIController);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
l_Parent_0.MouseButton1Click:Connect(function() --[[ Line: 9 ]]
    -- upvalues: v4 (copy), v3 (copy), l_LocalPlayer_0 (copy)
    v4:RefreshUI();
    v3:Open(l_LocalPlayer_0.PlayerGui:WaitForChild("PetEquipSlots_UI"));
    v4:Show();
end);