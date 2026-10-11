-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FollowPlayer, time of decompilation: Wed Jun  4 21:31:58 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
return {
    Verifier = function(v4) --[[ Line: 8 ]] --[[ Name: Verifier ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        return v4:GetAttribute("OWNER") == l_LocalPlayer_0.Name;
    end, 
    Activate = function(v5) --[[ Line: 12 ]] --[[ Name: Activate ]]
        -- upvalues: v2 (copy)
        print("Follow Player");
        v2:SetPetState(v5:GetAttribute("UUID"), "FollowPlayer");
    end
};