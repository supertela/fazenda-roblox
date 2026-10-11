return {
	Name = "serverannounce";
	Description = "Sends a server message to all players in the server.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string",
			Name = "Message",
			Description = "Message to send (REQUIRED)",
		},
	}
}

