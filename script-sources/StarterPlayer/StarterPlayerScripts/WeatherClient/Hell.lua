local HellEffectModule = {};
local unused = {};

local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService     = game:GetService("TweenService")
local runService       = game:GetService("RunService")
local debris           = game:GetService("Debris")
local lighting         = game:GetService("Lighting")
local players          = game:GetService("Players")
local workspace        = game:GetService("Workspace")

local snowParticleTemplate = replicatedStorage.SnowParticle
local randomGenerator      = Random.new()
local currentCamera        = workspace.CurrentCamera

local particleRaycastParams = RaycastParams.new()
particleRaycastParams.FilterDescendantsInstances = {
	workspace.Terrain,
	workspace
}
particleRaycastParams.FilterType = Enum.RaycastFilterType.Include

local activeParticles    = {}
local isHellEventActive  = false

local originalFaceTexture

local NEW_FACE_TEXTURE = "rbxassetid://3361935131"  

local function createParticle(spawnPosition)
	local particleData = {
		particle       = snowParticleTemplate:Clone(),
		position       = spawnPosition,
		spawnTime      = os.clock(),
		visible        = false,
		lastUpdateTime = 0
	}
	tweenService:Create(particleData.particle, TweenInfo.new(0.7), {
		Transparency = 0.2
	}):Play()
	table.insert(activeParticles, particleData)
end

local function updateParticlePosition(particleData, currentTime, scaledDeltaTime)
	local currentPosition = particleData.position
	local movementVector = Vector3.new(-7,0,0).Unit * 45 * scaledDeltaTime
		+ Vector3.new(
			math.sin(math.rad(particleData.spawnTime * 90)),
			(math.sin(math.rad(particleData.spawnTime * 90))+1)/2 * -5,
			math.sin(math.rad(particleData.spawnTime * 90))
		) * scaledDeltaTime
		+ Vector3.new(scaledDeltaTime * 0.5 * math.sin(math.rad(os.clock() * 35) + particleData.spawnTime), 0, 0)

	local raycastResult = workspace:Spherecast(currentPosition, 0.15, movementVector * scaledDeltaTime, particleRaycastParams)
	if raycastResult then
		return raycastResult.Position, true
	else
		particleData.position = currentPosition + movementVector * scaledDeltaTime
		return particleData.position, false
	end
end

local frostSky              = script.Sky
local originalCartoonEffect = lighting.Cartoon
local bodyShaker            = require(replicatedStorage.Code.BodyShaker)

local function startHellEvent()
	isHellEventActive = true

	local player = players.LocalPlayer
	local char   = player.Character or player.CharacterAdded:Wait()
	local head   = char:FindFirstChild("Head")
	if head then
		local faceDecal = head:FindFirstChild("face")
		if faceDecal then
			originalFaceTexture = faceDecal.Texture
			faceDecal.Texture    = NEW_FACE_TEXTURE
		end
	end

	task.delay(1, function()
		local char = player.Character
		if char and char:IsDescendantOf(workspace) then
			local coldSoundInstance = script.HellSound:Clone()
			coldSoundInstance.Parent = char.PrimaryPart
			coldSoundInstance:Play()
			tweenService:Create(coldSoundInstance, TweenInfo.new(1), {
				Volume = 0.02
			}):Play()
			task.delay(25, function()
				tweenService:Create(coldSoundInstance, TweenInfo.new(1), {
					Volume = 0
				}):Play()
				debris:AddItem(coldSoundInstance, 1)
			end)
		end
		bodyShaker.EnableShaking()
	end)

	originalCartoonEffect.Parent = replicatedStorage
	frostSky.Parent             = lighting

	tweenService:Create(lighting.Atmosphere, TweenInfo.new(3), {
		Density = 0.493,
		Glare   = 0.85,
		Haze    = 2.11,
		Offset  = 1,
		Color   = Color3.fromRGB(85, 0, 0),
		Decay   = Color3.fromRGB(255, 85, 0)
	}):Play()

	tweenService:Create(lighting, TweenInfo.new(3), {
		Ambient              = Color3.fromRGB(170, 0, 0),
		ExposureCompensation = 0.4,
		Brightness           = 1
	}):Play()

	tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
		Brightness = 0.1,
		Saturation = -0.2
	}):Play()

	workspace.Terrain.Clouds.Enabled = true
	tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
		Cover   = 0.777,
		Density = 0.123,
		Color   = Color3.fromRGB(255, 0, 0)
	}):Play()

	local windyFrostEffectContainer = replicatedStorage["Hell Assets"]:Clone()
	windyFrostEffectContainer.Parent = workspace

	task.spawn(function()
		while isHellEventActive do
			runService.Heartbeat:Wait()
			for _ = 1, 3 do
				local spawnDistance = randomGenerator:NextNumber(10,180)
				local frustumHeight = 2 * spawnDistance * math.tan(math.rad(currentCamera.FieldOfView/2))
				local frustumWidth  = frustumHeight * (currentCamera.ViewportSize.X / currentCamera.ViewportSize.Y)
				local randomX = randomGenerator:NextNumber(-frustumWidth/2, frustumWidth/2)
				local randomY = randomGenerator:NextNumber(-frustumHeight/2, frustumHeight/2 + 20)
				local randomZ = -spawnDistance
				local spawnCFrame = currentCamera.CFrame * CFrame.new(randomX, randomY, randomZ)
				if not workspace:Raycast(spawnCFrame.Position, Vector3.new(0,150,0)) then
					createParticle(spawnCFrame.Position)
				end
			end
		end

		frostSky.Parent              = script
		originalCartoonEffect.Parent = lighting

		for _, desc in ipairs(windyFrostEffectContainer:GetDescendants()) do
			if desc:IsA("ParticleEmitter") or desc:IsA("Trail") then
				desc.Enabled = false
			end
		end

		task.delay(6, function()
			if windyFrostEffectContainer and windyFrostEffectContainer.Parent then
				windyFrostEffectContainer:Destroy()
			end
		end)

		bodyShaker.DisableShaking();

		tweenService:Create(lighting.Atmosphere, TweenInfo.new(3), {
			Density = 0,
			Haze = 0,
			Glare = 0,
			Offset = 0
		}):Play();

		tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
			Brightness = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play();

		tweenService:Create(lighting, TweenInfo.new(3), {
			Ambient = Color3.fromRGB(138, 138, 138),
			ExposureCompensation = 0.2,
			Brightness = 2
		}):Play();

		tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
			Cover = 0,
			Density = 0,
			Color = Color3.fromRGB(22, 40, 70)
		}):Play();

		task.delay(3, function()
			workspace.Terrain.Clouds.Enabled = false;
		end);

		local char2 = players.LocalPlayer.Character
		if char2 then
			local head2 = char2:FindFirstChild("Head")
			if head2 then
				local face2 = head2:FindFirstChild("face")
				if face2 and originalFaceTexture then
					face2.Texture = originalFaceTexture
				end
			end
		end
	end)
end

workspace:GetAttributeChangedSignal("Hell"):Connect(function()
	if workspace:GetAttribute("Hell") then
		task.defer(startHellEvent)
	else
		isHellEventActive = false
	end
end)

task.spawn(function()
	while true do
		local deltaTime = runService.RenderStepped:Wait()
		local currentTime      = os.clock()
		local renderStepScaled = deltaTime * 3
		local scaledDeltaTime  = math.min(1, deltaTime * 5)

		local toMove, targets = {}, {}
		for i = #activeParticles, 1, -1 do
			local pd = activeParticles[i]
			local newPos, collided = updateParticlePosition(pd, currentTime, scaledDeltaTime)
			local screenPos, onScreen = currentCamera:WorldToScreenPoint(newPos)
			local distNorm = (currentCamera.CFrame.Position - newPos).Magnitude / 120
			local factor   = distNorm * distNorm
			local randUpd  = 1 / math.random(60,120)
			local threshold = renderStepScaled * factor + 1/60

			if distNorm > 1.5 then
				pd.particle:Destroy()
				table.remove(activeParticles, i)
			elseif currentTime - pd.lastUpdateTime + randUpd > threshold then
				pd.lastUpdateTime = currentTime
				pd.visible = onScreen and screenPos.Z < 200
				if pd.visible then
					table.insert(toMove, pd.particle)
					table.insert(targets, CFrame.new(newPos, currentCamera.CFrame.Position) * CFrame.Angles(1.5708,0,0))
				end
				pd.particle.Parent = pd.visible and workspace.WeatherVisuals or nil
				if collided then
					debris:AddItem(pd.particle, 1)
					tweenService:Create(pd.particle, TweenInfo.new(1), { Transparency = 1 }):Play()
					table.remove(activeParticles, i)
				elseif os.clock() - pd.spawnTime > 7 then
					debris:AddItem(pd.particle, 0.3)
					tweenService:Create(pd.particle, TweenInfo.new(0.3), { Transparency = 1 }):Play()
					table.remove(activeParticles, i)
				end
			end
		end
		workspace:BulkMoveTo(toMove, targets, Enum.BulkMoveMode.FireCFrameChanged)
	end
end)

if workspace:GetAttribute("Hell") then
	task.defer(startHellEvent)
else
	isHellEventActive = false
end

return HellEffectModule
