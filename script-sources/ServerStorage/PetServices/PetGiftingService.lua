-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetGiftingService, time of decompilation: Wed Jun  4 21:32:03 2025 ]]
local v0 = {};
local l_PetGiftingService_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetGiftingService");
local l_Gift_Notification_0 = script.Gift_Notification;
local l_Gift_Notification_1 = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gift_Notification");
v0.GivePet = function(_, v5) --[[ Line: 7 ]]
    -- upvalues: l_PetGiftingService_0 (copy)
    l_PetGiftingService_0:FireServer("GivePet", v5);
end;
game.ReplicatedStorage.GameEvents.GiftPet.OnClientEvent:Connect(function(v6, v7, v8) --[[ Line: 11 ]]
    -- upvalues: l_Gift_Notification_0 (copy), l_Gift_Notification_1 (copy)
    local v9 = l_Gift_Notification_0:Clone();
    v9.Parent = l_Gift_Notification_1.Frame;
    v9.Holder.Notification_UI.TextLabel.Text = "Gift from @" .. v8;
    v9.Holder.TextLabel.Text = v7;
    v9.Holder.Frame.Accept.MouseButton1Click:Connect(function() --[[ Line: 17 ]]
        -- upvalues: v9 (copy), v6 (copy)
        v9:Destroy();
        game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(true, v6);
    end);
    v9.Holder.Frame.Decline.MouseButton1Click:Connect(function() --[[ Line: 22 ]]
        -- upvalues: v9 (copy), v6 (copy)
        v9:Destroy();
        game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(false, v6);
    end);
end);
return v0;