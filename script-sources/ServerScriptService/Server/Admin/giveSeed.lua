return {
	Name = "giveseed";
	Description = "Give seeds or fruits to a player";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player to give the item to"
		},
		{
			Type = "string",
			Name = "ItemType",
			Description = "Type of item (Do '' For Candy Blossom)"
		},
		{
			Type = "number",
			Name = "Quantity",
			Description = "Number of items to give",
			Optional = true,
			Default = 1
		}
	}
}