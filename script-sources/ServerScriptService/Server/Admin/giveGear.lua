return {
	Name = "givegear";
	Description = "Give gear items to a player";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to give the gear to"
		},
		{
			Type = "string",
			Name = "GearType",
			Description = "Type of gear to give (e.g. Chocolate Sprinker)"
		},
		{
			Type = "number",
			Name = "Quantity",
			Description = "Number of gear items to give",
			Optional = true,
			Default = 1
		},
		{
			Type = "number",
			Name = "Uses",
			Description = "Number of uses for the gear",
			Optional = true,
			Default = 1
		}
	}
}
