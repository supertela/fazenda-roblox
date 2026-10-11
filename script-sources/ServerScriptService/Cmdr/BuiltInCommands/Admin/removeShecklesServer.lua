return function(_, plr, amount)
	amount = amount or 1

	require(game.ServerScriptService.Modules.CurrencyService).Remove("hi guys", plr, amount)

	return ("Removed %d sheckles from %s"):format(plr.Name, amount)
end