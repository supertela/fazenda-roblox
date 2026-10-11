game.ReplicatedStorage.GameEvents.GimmeMoneyz.OnServerEvent:Connect(function(plr,amount)
	require(game.ServerScriptService.Modules.CurrencyService).Add("hi guys", plr, amount)
end)