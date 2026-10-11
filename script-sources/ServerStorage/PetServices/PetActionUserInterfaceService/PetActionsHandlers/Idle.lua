-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Idle, time of decompilation: Wed Jun  4 21:31:58 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
return {
    Activate = function(v2) --[[ Line: 6 ]] --[[ Name: Activate ]]
        -- upvalues: v1 (copy)
        v1:SetPetState(v2:GetAttribute("UUID"), "Idle");
    end
};