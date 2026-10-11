-- Tomato Tree Generator Script

-- Configuration
local BASE_PART_SIZE = Vector3.new(0.257, 1.441, 0.257)
local GENERATED_PART_SIZE = Vector3.new(0.154, 1.502, 0.154) -- For trunk segments and branches
local SPAWN_POINT_SIZE = Vector3.new(0.1, 0.1, 0.1) -- Small and invisible
local LEAF_PART_SIZE = Vector3.new(0.093, 0.54, 0.54) -- Size of a single leaf
local LEAF_COLOR = Color3.fromRGB(58, 125, 21) -- Forest Green for leaves

local FIXED_BRANCH_UPWARD_ANGLE = math.rad(70) -- Branches will have this upward angle from the trunk
local MAX_BRANCH_SEGMENT_ANGLE_DEVIATION = math.rad(10) -- Slight additional random bend for the branch part itself

local BRANCH_CHANCE = 0.5 -- Chance to grow a side branch from a trunk segment (after potential guaranteed branch)
local MIN_TREE_HEIGHT_SEGMENTS = 3
local MAX_TREE_HEIGHT_SEGMENTS = 15

local LEAF_SPAWN_CHANCE = 0.2 -- 80% chance a trunk segment (without a branch) will have leaves
local MAX_LEAVES_PER_TRUNK_SEGMENT = 1 -- Max leaves on a single trunk segment

-- Services
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage") -- Or wherever you want to store the model

-- Random number generator
local rng = Random.new(script.Parent.Item_Seed.Value)

local PartName = 0
local BranchCount = 0

-- Helper function to create a part
local function createPart(name, size, cframe, parent, color, transparency, anchor, canCollide)
	if name ~= "Spawn_Point" then
		PartName = PartName + 1
	end

	if name:match('Branch') then
		BranchCount = BranchCount + 1
	end
	
	local part = Instance.new("Part")
	part.Name = name ~= "Spawn_Point" and tostring(PartName) or name
	part.Size = size
	part.CFrame = cframe
	part.Parent = parent
	part.Color = color or Color3.fromRGB(139, 69, 19) 
	part.Transparency = transparency or 0
	part.Anchored = anchor or true
	part.CanCollide = canCollide == nil and true or canCollide 
	part.TopSurface = Enum.SurfaceType.Studs
	part.BottomSurface = Enum.SurfaceType.Studs
	part.Material = Enum.Material.Plastic -- User changed material
	part:SetAttribute("OG_Transparency", transparency or 0)
	
	return part
end

-- Function to create a leaf and weld it to its parent part (trunk segment)
local function createLeaf(name, cframe, parentTrunkSegment)
	-- Parent to treeModel initially, then set CFrame, then weld.
	local leaf = createPart(name, LEAF_PART_SIZE, CFrame.new(), parentTrunkSegment.Parent, LEAF_COLOR, 0, true, false) 
	leaf.CFrame = cframe 
	leaf.Material = Enum.Material.Plastic
	leaf.Shape = Enum.PartType.Block

	return leaf
end


-- Function to generate the tomato tree
local function generateTomatoTree(originPosition)
	local treeModel = script.Parent
	local maxTreeHeight = rng:NextInteger(MIN_TREE_HEIGHT_SEGMENTS, MAX_TREE_HEIGHT_SEGMENTS)
	local currentSegmentNumber = 0

	local guaranteedBranchMade = false -- Flag to ensure at least one branch is made

	local function generateSegment(parentPart, parentCFrame, currentLength, maxLength, isTrunk)
		if currentLength >= maxLength then
			if not isTrunk then -- This is the end of a single-part branch
				local spawnPointCFrame = parentPart.CFrame * CFrame.new(0, parentPart.Size.Y / 2 + SPAWN_POINT_SIZE.Y / 2, 0)
				local part = createPart("Spawn_Point", SPAWN_POINT_SIZE, CFrame.new(spawnPointCFrame.Position), treeModel.Fruit_Spawn, Color3.fromRGB(255,0,0), 1, true, false)

				local obj = Instance.new("ObjectValue")
				obj.Value = parentPart
				obj.Parent = part
			end
			return
		end

		currentSegmentNumber = currentSegmentNumber + 1
		local segmentName = (isTrunk and "TrunkSegment_" or "BranchSegment_") .. currentSegmentNumber
		local segmentSize = GENERATED_PART_SIZE
		local newSegmentCFrame

		if isTrunk then
			-- User added random Y rotation for trunk segments
			newSegmentCFrame = parentCFrame * CFrame.new(0, parentPart.Size.Y / 2 + segmentSize.Y / 2, 0) * CFrame.Angles(0, math.rad(rng:NextInteger(-180, 180)), 0)
		else -- This is a side branch (single part)
			local randomBendAngle = rng:NextNumber(-MAX_BRANCH_SEGMENT_ANGLE_DEVIATION, MAX_BRANCH_SEGMENT_ANGLE_DEVIATION)
			newSegmentCFrame = parentCFrame * CFrame.Angles(randomBendAngle, 0, 0) * CFrame.new(0, segmentSize.Y / 2, 0)
		end

		-- User changed color for all segments
		local newSegment = createPart(segmentName, segmentSize, newSegmentCFrame, treeModel, Color3.fromRGB(58, 125, 21))

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = parentPart
		weld.Part1 = newSegment
		weld.Parent = newSegment

		if isTrunk then
			local hasSpawnedBranchThisSegment = false -- Tracks if any branch (guaranteed or random) is made on THIS current segment

			-- GUARANTEED BRANCH LOGIC:
			-- If no branch has been guaranteed yet, and this is the 2nd trunk segment (currentLength == 1),
			-- and the tree is tall enough (maxTreeHeight > 3 means at least 4 segments total: base, trunk1, trunk2, top/another trunk)
			if not guaranteedBranchMade and currentLength == 1 and maxTreeHeight > 3 then
				hasSpawnedBranchThisSegment = true
				guaranteedBranchMade = true -- The guarantee is now fulfilled

				local sideBranchRandomDirectionY = math.rad(rng:NextInteger(0, 360))
				-- Using user's CFrame logic for branch attachment point:
				local sideBranchInitialCFrame = newSegment.CFrame
					* CFrame.Angles(0, sideBranchRandomDirectionY, 0)   -- Rotate around trunk's Y to pick a side
					* CFrame.new(0, rng:NextNumber(-segmentSize.Y * 0.1, segmentSize.Y * 0.1), 0) -- Small vertical variation on trunk
					* CFrame.Angles(FIXED_BRANCH_UPWARD_ANGLE, 0, 0)   -- Apply the fixed upward angle

				generateSegment(newSegment, sideBranchInitialCFrame, 0, 1, false) -- Generate the single-part branch
			end

			-- RANDOM BRANCH LOGIC:
			-- Chance to spawn an additional side branch from this trunk segment,
			-- but only if a guaranteed branch wasn't already placed on THIS specific segment.
			if not hasSpawnedBranchThisSegment and currentLength > 0 and currentLength < maxTreeHeight - 2 and rng:NextNumber() < BRANCH_CHANCE then
				hasSpawnedBranchThisSegment = true 
				guaranteedBranchMade = true -- If a random branch is made, it also fulfills the guarantee

				local sideBranchRandomDirectionY = math.rad(rng:NextInteger(0, 360))
				local sideBranchInitialCFrame = newSegment.CFrame
					* CFrame.Angles(0, sideBranchRandomDirectionY, 0)
					* CFrame.new(0, rng:NextNumber(-segmentSize.Y * 0.1, segmentSize.Y * 0.1), 0) 
					* CFrame.Angles(FIXED_BRANCH_UPWARD_ANGLE, 0, 0)

				generateSegment(newSegment, sideBranchInitialCFrame, 0, 1, false)
			end

			-- LEAF SPAWNING LOGIC:
			-- Try to spawn leaves on this trunk segment IF no branch was spawned on it.
			if not hasSpawnedBranchThisSegment and currentLength > 0 and currentLength < maxTreeHeight -1 and rng:NextNumber() < LEAF_SPAWN_CHANCE then
				local numLeaves = rng:NextInteger(1, MAX_LEAVES_PER_TRUNK_SEGMENT)
				for i = 1, numLeaves do
					local leafAngleAroundTrunk = math.rad(rng:NextInteger(0, 360))
					local leafVerticalPositionOnTrunk = rng:NextNumber(-newSegment.Size.Y * 0.45, newSegment.Size.Y * 0.45)
					local leafOutwardOffset = newSegment.Size.X / 2 + LEAF_PART_SIZE.Z * 0.3 

					-- User's CFrame logic for leaf orientation:
					local leafCFrame = newSegment.CFrame
						* CFrame.Angles(0, leafAngleAroundTrunk, 0) 
						* CFrame.new(0, leafVerticalPositionOnTrunk, 0) 
						* CFrame.new(leafOutwardOffset, 0, 0) 
						* CFrame.Angles(math.rad(rng:NextInteger(-15, 15)), 0, math.rad(90 + rng:NextInteger(-15, 15)))

					createLeaf("Leaf_" .. currentSegmentNumber .. "_" .. i, leafCFrame, newSegment)
				end
			end

			-- Continue growing the trunk
			if currentLength < maxTreeHeight -1 then
				generateSegment(newSegment, newSegment.CFrame, currentLength + 1, maxTreeHeight, true)
			else -- Reached max height for trunk, add a spawn point on top
				--[[
				local spawnPointCFrame = newSegment.CFrame * CFrame.new(0, newSegment.Size.Y / 2 + SPAWN_POINT_SIZE.Y / 2, 0)
				local part = createPart("Spawn_Point", SPAWN_POINT_SIZE, CFrame.new(spawnPointCFrame.Position), treeModel.Fruit_Spawn, Color3.fromRGB(255,0,0), 1, true, false)
				
				local obj = Instance.new("ObjectValue")
				obj.Value = part
				obj.Parent = part
				]]
			end

		else -- This was a branch segment (the single part of a branch)
			-- Call the base case for the branch to add its spawn point
			generateSegment(newSegment, newSegment.CFrame, 1, 1, false) 
		end
	end

	local basePartCFrame = CFrame.new(originPosition)
	-- User changed base part color
	local basePart = createPart("TreeBase", BASE_PART_SIZE, basePartCFrame, treeModel, Color3.fromRGB(58, 125, 21)) 
	treeModel.PrimaryPart = basePart -- User set PrimaryPart directly
	-- treeModel:SetPrimaryPartCFrame(basePart.CFrame) -- This also works

	generateSegment(basePart, basePart.CFrame, 0, maxTreeHeight, true)

	return treeModel
end

local treeOrigin = Vector3.new(0, BASE_PART_SIZE.Y / 2, 0) 
generateTomatoTree(script.Parent:WaitForChild("Origin").Position + treeOrigin)
script.Parent:SetAttribute("BranchCount", BranchCount)
script.Parent:SetAttribute("Generated", true)