return {
	Name = "multiplysheckles";
	Description = "Multiply sheckles to a player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to multiply the sheckles to"
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Multiplication",
			Default = 1
		}
	}
}

