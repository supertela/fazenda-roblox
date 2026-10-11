local FarmService = {
	ClaimFarm = function(self, player: Player)
		for _, farm in workspace.MapaGrowAGarden.Canteiros:GetChildren() do
			local owner = farm:FindFirstChild("Owner", true)
			if owner and owner.Value == "None" then
				owner.Value = player.Name
				return farm
			end
		end
		
		return false
	end,
}

return FarmService
