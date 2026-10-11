return {
	Name = "givesheckles";
	Description = "Give sheckles to a player";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to give the sheckles to"
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Number of sheckles to give",
			Default = 1
		}
	}
}