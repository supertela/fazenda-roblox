game:GetService("MessagingService"):SubscribeAsync("followm", function(sentData)
	local data = sentData.Data
	local value = data.val
	
	game.ReplicatedStorage.FollowM.Value = value
end)