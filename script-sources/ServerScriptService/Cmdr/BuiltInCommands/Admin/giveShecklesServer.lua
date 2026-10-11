return function(_, plr, amount)
	amount = amount or 1
	
	require(game.ServerScriptService.Modules.CurrencyService).Add("hi guys", plr, amount)
	
	return ("Gave %s %d sheckles."):format(plr.Name, amount)
end