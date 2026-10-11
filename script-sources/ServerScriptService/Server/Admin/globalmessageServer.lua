return function(context, message)
	game:GetService("MessagingService"):PublishAsync("GlobalMessage", {
		msg = message
	})

	return "Global message sent."
end