return function(_, plr, amount)
	amount = amount or 1

	require(game.ServerScriptService.Modules.CurrencyService).Set("hi guys", plr, amount)

	return ("Set %s's sheckles to %d."):format(plr.Name, amount)
end