-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: View, time of decompilation: Wed Jun  4 21:31:59 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v2 = require(l_ReplicatedStorage_0.Modules.PetServices.PetCardUserInterfaceService);
local v3 = require(l_ReplicatedStorage_0.Modules.ActivePetsUIController);
return {
    Activate = function(v4) --[[ Line: 8 ]] --[[ Name: Activate ]]
        -- upvalues: v2 (copy), v3 (copy)
        v2:SetTarget(v4);
        v2:Toggle(true);
        v3:Close();
    end
};