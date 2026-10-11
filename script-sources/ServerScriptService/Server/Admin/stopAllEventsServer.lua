return function()
	game:GetService("MessagingService"):PublishAsync("stopweather")
	
	return "Stopped all events"
end