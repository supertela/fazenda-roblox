return {
	Name = "triggerWeather";
	Description = "Trigger a weather event in the game.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string",
			Name = "WeatherType",
			Description = "Type of weather to trigger (Rain, Frost, Thunderstorm, or 'random')",
			Optional = true,
			Default = "random"
		},
		{
			Type = "number",
			Name = "Duration",
			Description = "Duration of the weather event in seconds",
			Optional = true,
			Default = 300
		}
	}
}

