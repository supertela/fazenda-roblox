local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local purchaseEvent = ReplicatedStorage:FindFirstChild("PurchaseSuccess") or Instance.new("RemoteEvent")
purchaseEvent.Name = "PurchaseSuccess"
purchaseEvent.Parent = ReplicatedStorage

MarketplaceService.ProcessReceipt = function(receiptInfo)
	local player = game:GetService("Players"):GetPlayerByUserId(receiptInfo.PlayerId)

	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	if receiptInfo.ProductId == 3309476211 then
		purchaseEvent:FireClient(player)
	end

	return Enum.ProductPurchaseDecision.PurchaseGranted
end
