-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetRegistry, time of decompilation: Wed Jun  4 21:30:43 2025 ]]
local l_Assets_0 = game:GetService("ReplicatedStorage"):WaitForChild("Assets");
local _ = l_Assets_0:WaitForChild("Models");
local _ = l_Assets_0:WaitForChild("Animations"):WaitForChild("PetAnimations");
local l_PetConfig_0 = require(script:WaitForChild("PetConfig"));
local l_DefaultPetNames_0 = require(script:WaitForChild("DefaultPetNames"));
local l_PetStatesRegistry_0 = require(script:WaitForChild("PetStatesRegistry"));
local l_PetRarities_0 = require(script:WaitForChild("PetRarities"));
local l_DefaultPetActions_0 = require(script:WaitForChild("DefaultPetActions"));
local l_DefaultPetStates_0 = require(script:WaitForChild("DefaultPetStates"));
local l_PetList_0 = require(script:WaitForChild("PetList"));
local l_PassiveRegistry_0 = require(script:WaitForChild("PassiveRegistry"));
local l_PetEggs_0 = require(script:WaitForChild("PetEggs"));
return {
    PetStatesRegistry = l_PetStatesRegistry_0, 
    PetList = l_PetList_0, 
    PetConfig = l_PetConfig_0, 
    PassiveRegistry = l_PassiveRegistry_0, 
    PetEggs = l_PetEggs_0, 
    DefaultPetActions = l_DefaultPetActions_0, 
    DefaultPetStates = l_DefaultPetStates_0, 
    DefaultPetNames = l_DefaultPetNames_0, 
    PetRarities = l_PetRarities_0
};