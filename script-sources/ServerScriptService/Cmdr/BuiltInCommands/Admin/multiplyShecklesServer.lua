return function(_, plr, amount)
	amount = amount or 1

	require(game.ServerScriptService.Modules.CurrencyService).Multiply("hi guys", plr, amount)

	return ("Multiplied sheckles by %d"):format(amount)
end