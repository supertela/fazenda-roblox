return function(context, message)
	local Notification = game.ReplicatedStorage.GameEvents.Notification

	Notification:FireAllClients(message, true)
	
	return `Server announcement sent.`
end