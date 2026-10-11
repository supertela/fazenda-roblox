return function(context, weatherType: string?, duration: number?)
	weatherType = (weatherType or "random"):lower()
	
	game:GetService("MessagingService"):PublishAsync("weather", {
		weather = weatherType,
		duration = duration,
	})
	
	return `Started weather event: {weatherType} for {duration} seconds`
end