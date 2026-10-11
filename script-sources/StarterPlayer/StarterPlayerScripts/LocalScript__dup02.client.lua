-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_StarterGui_0 = game:GetService("StarterGui");
game.ReplicatedStorage.GameEvents.Prompt_Friend.OnClientEvent:Connect(function(v1) --[[ Line: 2 ]]
    -- upvalues: l_StarterGui_0 (copy)
    l_StarterGui_0:SetCore("PromptSendFriendRequest", v1);
end);