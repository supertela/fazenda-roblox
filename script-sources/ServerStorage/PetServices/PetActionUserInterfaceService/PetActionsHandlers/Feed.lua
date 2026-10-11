-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Feed, time of decompilation: Wed Jun  4 21:31:59 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Modules.PetServices.PetsService);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v4 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v5 = require(l_ReplicatedStorage_0.Modules.Notification);
return {
    Verifier = function(v6) --[[ Line: 10 ]] --[[ Name: Verifier ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        return v6:GetAttribute("OWNER") == l_LocalPlayer_0.Name;
    end, 
    Activate = function(v7) --[[ Line: 14 ]] --[[ Name: Activate ]]
        -- upvalues: l_LocalPlayer_0 (copy), v5 (copy), v4 (copy)
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return;
        else
            local l_Tool_0 = l_Character_0:FindFirstChildWhichIsA("Tool");
            if not l_Tool_0 then
                return v5:CreateNotification("You are not holding a fruit!");
            elseif not l_Tool_0:HasTag("FruitTool") then
                return v5:CreateNotification("You are not holding a fruit!");
            else
                v4:Feed(v7:GetAttribute("UUID"));
                return;
            end;
        end;
    end
};