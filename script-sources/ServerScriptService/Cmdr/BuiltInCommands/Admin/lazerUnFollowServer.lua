return function(_)
	game:GetService("MessagingService"):PublishAsync("followm", {
		val = false,
	})

	return "Following stopped."
end