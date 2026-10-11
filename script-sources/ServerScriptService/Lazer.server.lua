game:GetService("MessagingService"):SubscribeAsync("lazereye", function(sentData)
	local data = sentData.Data
	local pos = game:GetService("HttpService"):JSONDecode(data.cframeg)
	
	if game.ReplicatedStorage.FollowM.Value == true then
		local vectora = Vector3.new(pos.x, pos.y, pos.z)
		workspace.Visuals.LazerSpot.Position = vectora
	end
end)