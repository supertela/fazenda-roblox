return {
	Name = "setsheckles";
	Description = "Set sheckles to a player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to set the sheckles to"
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Number of sheckles to set",
			Default = 1
		}
	}
}

