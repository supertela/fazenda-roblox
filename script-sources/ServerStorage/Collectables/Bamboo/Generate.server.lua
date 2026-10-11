-- Bamboo Tree Generator Script

-- Configuration
local BASE_PART_SIZE = Vector3.new(0.257, 1.441, 0.257)
local TRUNK_SEGMENT_SIZE = Vector3.new(0.204, 1.502, 0.204)
local NODE_PART_SIZE = Vector3.new(0.28, 0.15, 0.28) -- Size of the node between segments
local LEAF_PART_SIZE = Vector3.new(0.093, 0.54, 0.54)
local LEAF_COLOR = Color3.fromRGB(58, 125, 21) -- Olive drab for leaves
local TRUNK_COLOR = Color3.fromRGB(63, 148, 46) -- Brown for trunk
local NODE_COLOR = Color3.fromRGB(137, 218, 75) -- Beige for nodes

local MIN_TREE_HEIGHT_SEGMENTS = 12
local MAX_TREE_HEIGHT_SEGMENTS = 20

local LEAF_SPAWN_CHANCE = 0.2 -- Chance a trunk segment will have leaves
local MAX_LEAVES_PER_TRUNK_SEGMENT = 1

-- Services
local Workspace = game:GetService("Workspace")

-- Random number generator
local rng = Random.new(script.Parent.Item_Seed.Value)

local PartName = 0

-- Helper function to create a part
local function createPart(name, size, cframe, parent, color, transparency, anchor, canCollide, material, shape)
	PartName = PartName + 1
	local part = Instance.new("Part")
	part.Name = name ~= "Spawn_Point" and tostring(PartName) or name
	part.Size = size
	part.CFrame = cframe
	part.Parent = parent
	part.Color = color or TRUNK_COLOR
	part.Transparency = transparency or 0
	part.Anchored = anchor or true
	part.CanCollide = canCollide == nil and true or canCollide
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Material = material or Enum.Material.Plastic
	part.Shape = shape or Enum.PartType.Block
	part:SetAttribute("OG_Transparency", transparency or 0)
	return part
end

-- Function to create a leaf and weld it to its parent part (trunk segment)
local function createLeaf(name, cframe, parentTrunkSegment)
	local leaf = createPart(name, LEAF_PART_SIZE, CFrame.new(), parentTrunkSegment.Parent, LEAF_COLOR, 0, true, false, Enum.Material.Plastic)
	leaf.CFrame = cframe

	return leaf
end

-- Function to generate the bamboo tree
local function generateBambooTree(originPosition)
	local treeModel = script.Parent
	local maxTreeHeight = rng:NextInteger(MIN_TREE_HEIGHT_SEGMENTS, MAX_TREE_HEIGHT_SEGMENTS)
	local currentSegmentNumber = 0
	local previousSegment = nil

	local function generateSegment(parentPart, parentCFrame, currentLength, maxLength)
		if currentLength >= maxLength then
			return
		end

		currentSegmentNumber = currentSegmentNumber + 1
		local segmentName = "TrunkSegment_" .. currentSegmentNumber
		local segmentSize = TRUNK_SEGMENT_SIZE
		local newSegmentCFrame = parentCFrame * CFrame.new(0, parentPart.Size.Y / 2 + NODE_PART_SIZE.Y / 2 + segmentSize.Y / 2, 0) * CFrame.Angles(0, math.rad(rng:NextInteger(-180, 180)), 0)
		local newSegment = createPart(segmentName, segmentSize, newSegmentCFrame, treeModel, TRUNK_COLOR:Lerp(LEAF_COLOR, math.random(1, 2) == 1 and 1 or 0.1))

		-- Create node between segments
		local nodeName = "Node_" .. currentSegmentNumber
		local nodeSize = NODE_PART_SIZE
		local nodeCFrame = parentCFrame * CFrame.new(0, parentPart.Size.Y / 2 + nodeSize.Y / 2, 0)
		local nodePart = createPart(nodeName, nodeSize, nodeCFrame, treeModel, NODE_COLOR)

		local truss = Instance.new("TrussPart")
		truss.Size = segmentSize
		truss.Transparency = 1
		truss.Anchored = true
		truss.Position = newSegmentCFrame.Position
		truss.CanCollide = false
		truss:AddTag("ShovelIgnore")
		truss.Parent = newSegment

		-- Leaf spawning logic
		if rng:NextNumber() < LEAF_SPAWN_CHANCE then
			local numLeaves = rng:NextInteger(1, MAX_LEAVES_PER_TRUNK_SEGMENT)
			for i = 1, numLeaves do
				local leafAngleAroundTrunk = math.rad(rng:NextInteger(0, 360))
				local leafVerticalPositionOnTrunk = rng:NextNumber(-newSegment.Size.Y * 0.4, newSegment.Size.Y * 0.4)
				local leafOutwardOffset = newSegment.Size.X / 2

				local leafCFrame = newSegment.CFrame
					* CFrame.Angles(0, leafAngleAroundTrunk, 0)
					* CFrame.new(leafOutwardOffset, leafVerticalPositionOnTrunk, 0)
					* CFrame.Angles(math.rad(rng:NextInteger(-15, 15)), 0, math.rad(90 + rng:NextInteger(-15, 15)))

				createLeaf("Leaf_" .. currentSegmentNumber .. "_" .. i, leafCFrame, newSegment)
			end
		end

		-- Continue growing the trunk
		generateSegment(newSegment, newSegment.CFrame, currentLength + 1, maxLength)
	end

	local basePartCFrame = CFrame.new(originPosition)
	local basePart = createPart("TreeBase", BASE_PART_SIZE, basePartCFrame, treeModel, TRUNK_COLOR)
	treeModel.PrimaryPart = basePart

	generateSegment(basePart, basePart.CFrame, 0, maxTreeHeight)

	treeModel:SetAttribute("Generated", true)
	return treeModel
end

local treeOrigin = Vector3.new(0, BASE_PART_SIZE.Y / 2, 0)
generateBambooTree(script.Parent.Origin.Position + treeOrigin)
script.Parent:SetAttribute("Generated", true)