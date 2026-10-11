return {
	Name = "globalmessage",
	Aliases = { "gm" },
	Description = "Sends a cross-server global message to all players in the game.",
	Group = "DefaultAdmin",
	Args = {
		{
			Type = "string",
			Name = "Message",
			Description = "Message to send to players."
		}
	},
}