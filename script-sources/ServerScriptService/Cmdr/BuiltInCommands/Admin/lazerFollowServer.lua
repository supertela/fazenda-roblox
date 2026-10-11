return function(_, plr: Player)
	local MessagingService = game:GetService("MessagingService")
	local RunService = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local HttpService = game:GetService("HttpService")

	local followValue = ReplicatedStorage:FindFirstChild("FollowM")
	local remote = ReplicatedStorage:FindFirstChild("MousePositionEvent")

	if not followValue or not followValue:IsA("BoolValue") then
		warn("FollowM BoolValue not found in ReplicatedStorage.")
		return "FollowM value missing."
	end

	if not remote or not remote:IsA("RemoteEvent") then
		warn("MousePositionEvent not found in ReplicatedStorage.")
		return "RemoteEvent missing."
	end

	MessagingService:PublishAsync("followm", {
		val = true,
	})

	local lastSent = 0
	local rateLimit = 0.3 -- seconds
	local latestCFrame = nil

	-- One-time RemoteEvent listener to update latest mouse position
	remote.OnServerEvent:Connect(function(player, cframea)
		if player == plr and typeof(cframea) == "CFrame" then
			latestCFrame = cframea
		end
	end)

	-- Rate-limited Heartbeat loop to publish latest CFrame
	RunService.Heartbeat:Connect(function()
		if not followValue.Value or not latestCFrame then
			return
		end

		if tick() - lastSent >= rateLimit then
			lastSent = tick()

			local cf = latestCFrame

			local encodedCFrame = { x = cf.Position.X, y = cf.Position.Y, z = cf.Position.Z }

			MessagingService:PublishAsync("lazereye", {
				cframeg = HttpService:JSONEncode(encodedCFrame)
			})
		end
	end)

	return "Following started."
end