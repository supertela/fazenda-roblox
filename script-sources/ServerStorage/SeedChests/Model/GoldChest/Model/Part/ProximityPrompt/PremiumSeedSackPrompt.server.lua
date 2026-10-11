-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Modules.SeedSackUIController);
script.Parent.Triggered:Connect(function() --[[ Line: 6 ]]
    -- upvalues: v2 (copy)
    v2:DisplayPremiumSackUI();
end);