local label = script.Parent
local countdownDuration = 2 * 30 * 30 -- 2 hours in seconds
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("RunCmdrCommand")

-- Updates the text
local function updateTimerText(secondsLeft)
	local hours = math.floor(secondsLeft / 3600)
	local minutes = math.floor((secondsLeft % 3600) / 60)
	local seconds = secondsLeft % 60
	label.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- Main countdown loop
while true do
	local startTime = os.clock()
	while true do
		local elapsed = os.clock() - startTime
		local remaining = countdownDuration - math.floor(elapsed)

		if remaining <= 0 then
			remote:FireAllClients("globalmessage test")
			break -- restart the loop
		end

		updateTimerText(remaining)
		wait(1)
	end
end
