return {
	Name = "giveallseed";
	Description = "Give all seeds to a player";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to give the seeds to"
		},
		{
			Type = "number",
			Name = "QuantityPerSeed",
			Description = "Number of each seed to give",
			Optional = true,
			Default = 1
		}
	}
}
