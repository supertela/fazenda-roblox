return {
	Name = "givefruit";
	Description = "Give a specific fruit to a player";
	Group = "GameCommands";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "Player to give the fruit to";
		},
		{
			Type = "string";
			Name = "ItemType";
			Description = "Type of fruit (use '' for Candy Blossom)";
		},
		{
			Type = "number";
			Name = "Quantity";
			Description = "Number of fruits to give";
			Optional = true;
			Default = 1;
		}
	};
}
