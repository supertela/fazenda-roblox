return {
	Name = "addmutation";
	Description = "Give mutations to a fruit";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to set mutation to the fruit (MUST BE HOLDING FRUIT)"
		},
		{
			Type = "string",
			Name = "Mutation",
			Description = "Type of Mutation"
		},
	}
}