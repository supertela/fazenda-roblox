return {
	Name = "removesheckles";
	Description = "Remove sheckles to a player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to remove the sheckles from"
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Number of sheckles to remove",
			Default = 1
		}
	}
}

