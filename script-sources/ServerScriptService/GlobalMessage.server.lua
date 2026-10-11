game:GetService("MessagingService"):SubscribeAsync("GlobalMessage", function(sentData)
	local Notification = game.ReplicatedStorage.GameEvents.Notification
	local data = sentData.Data
	local message = data.msg
	
	Notification:FireAllClients(message, true)
end)