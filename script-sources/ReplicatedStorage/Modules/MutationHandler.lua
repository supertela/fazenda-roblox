-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MutationHandler, time of decompilation: Sun Jun  8 12:58:09 2025 ]]
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v3 = require(game.ReplicatedStorage.Modules.TableUtils);
local v4 = require(game.ReplicatedStorage.Calculate_Weight);
local v5 = {};
local v6 = {};
local _ = function() --[[ Line: 11 ]]
    -- upvalues: l_RunService_0 (copy), l_Players_0 (copy)
    if not l_RunService_0:IsStudio() then
        return false;
    else
        for _, v8 in l_Players_0:GetPlayers() do
            if v8.Name == "JexSavron" then
                return true;
            end;
        end;
        return false;
    end;
end;
v5.CanBeMutated = function(_, v11) --[[ Line: 24 ]]
    if not v11 then
        warn("MutationHandler.CanBeMutated | No plant given!");
        return false;
    else
        return v11:HasTag("Harvestable") or v11:HasTag("FruitTool");
    end;
end;
local function v19(v12) --[[ Line: 32 ]] --[[ Name: v19 ]]
    -- upvalues: l_RunService_0 (copy), l_Players_0 (copy)
    local v13 = false;
    if not v12 then
        warn("MutationHandler.GetFXPart | No plant given!");
        return nil;
    elseif not v12:IsDescendantOf(game) then
        return nil;
    else
        local v14 = {};
        if #v14 == 1 then
            return v14[1];
        elseif #v14 > 1 then
            return v14;
        else
            if v12:IsA("Tool") then
                local v15 = v12:WaitForChild("Handle", 0.3);
                if v15 then
                    return v15;
                end;
            end;
            if v12.PrimaryPart then
                return v12.PrimaryPart;
            else
                local v16 = nil;
                if not l_RunService_0:IsStudio() then
                    v16 = false;
                else
                    for _, v18 in l_Players_0:GetPlayers() do
                        if v18.Name == "JexSavron" then
                            v16 = true;
                            v13 = true;
                        end;
                        if v13 then
                            break;
                        end;
                    end;
                    if not v13 then
                        v16 = false;
                    end;
                end;
                v13 = false;
                if v16 then
                    warn((("MutationHandler.GetFXPart | No valid FX part found for %* of type %*"):format(v12:GetFullName(), v12.ClassName)));
                end;
                return nil;
            end;
        end;
    end;
end;
local function v21(v20) --[[ Line: 82 ]] --[[ Name: v21 ]]
    if v20:GetAttribute("Frozen") or v20:GetAttribute("Wet") and v20:GetAttribute("Chilled") then
        v20:SetAttribute("Wet", false);
        v20:SetAttribute("Chilled", false);
        v20:SetAttribute("Frozen", true);
    end;
end;
local function v39(v22) --[[ Line: 89 ]] --[[ Name: v39 ]]
    -- upvalues: v5 (copy), v19 (copy)
    local v23 = {};
    local v24 = {};
    for _, v26 in v5:GetMutations() do
        if not v22:GetAttribute(v26.Name) then
            v23[v26] = v26._RemoveFX;
        end;
        if v22:GetAttribute(v26.Name) then
            v24[v26] = v26._AddFX;
        end;
    end;
    task.spawn(function() --[[ Line: 101 ]]
        -- upvalues: v19 (ref), v22 (copy), v23 (copy), v24 (copy)
        local v27 = v19(v22);
        local function v34(v28, v29, v30, v31) --[[ Line: 104 ]] --[[ Name: v34 ]]
            if typeof(v31) == "table" then
                for _, v33 in ipairs(v31) do
                    v28(v29, v30, v33);
                end;
                return;
            else
                if v31 then
                    v28(v29, v30, v31);
                end;
                return;
            end;
        end;
        for v35, v36 in v23 do
            v34(v36, v35, v22, v27);
        end;
        for v37, v38 in v24 do
            v34(v38, v37, v22, v27);
        end;
    end);
end;
local v344 = {
    Shocked = {
        Name = "Shocked", 
        ValueMulti = 100, 
        Color = Color3.fromRGB(255, 255, 100), 
        _AddFX = function(v40, v41, v42) --[[ Line: 130 ]] --[[ Name: _AddFX ]]
            v40:_RemoveFX(v41, v42);
            if v42 then
                for _, v44 in game.ReplicatedStorage.Mutation_FX.Shocked:GetChildren() do
                    local v45 = v44:Clone();
                    v45.Parent = v42;
                    v45:AddTag("Cleanup_Shock");
                end;
            end;
            for _, v47 in v41:GetDescendants() do
                if (v47:IsA("BasePart") or v47:IsA("UnionOperation")) and not v47:HasTag("Effect") then
                    v47.Material = Enum.Material.Neon;
                end;
            end;
        end, 
        _RemoveFX = function(_, v49, v50) --[[ Line: 145 ]] --[[ Name: _RemoveFX ]]
            if v50 then
                for _, v52 in v50:GetChildren() do
                    if v52:HasTag("Cleanup_Shock") then
                        v52:Destroy();
                    end;
                end;
            end;
            for _, v54 in v49:GetDescendants() do
                if (v54:IsA("BasePart") or v54:IsA("UnionOperation")) and v54:GetAttribute("Original_Material") and not v54:HasTag("Effect") then
                    v54.Material = v54:GetAttribute("Original_Material");
                end;
            end;
        end
    }, 
    Windstruck = {
        Name = "Windstruck", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(162, 185, 209), 
        _AddFX = function(v55, v56, v57) --[[ Line: 164 ]] --[[ Name: _AddFX ]]
            v55:_RemoveFX(v56, v57);
            if v57 then
                for _, v59 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
                    local v60 = v59:Clone();
                    v60.Parent = v57;
                    v60:AddTag("Cleanup_Windstruck");
                end;
            end;
        end, 
        _RemoveFX = function(_, _, v63) --[[ Line: 174 ]] --[[ Name: _RemoveFX ]]
            if v63 then
                for _, v65 in v63:GetChildren() do
                    if v65:HasTag("Cleanup_Windstruck") then
                        v65:Destroy();
                    end;
                end;
            end;
        end
    }, 
    Dawnbound = {
        Name = "Dawnbound", 
        ValueMulti = 150, 
        Color = Color3.fromRGB(255, 213, 0), 
        _AddFX = function(v66, v67, v68) --[[ Line: 188 ]] --[[ Name: _AddFX ]]
            v66:_RemoveFX(v67, v68);
            if v68 then
                for _, v70 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
                    local v71 = v70:Clone();
                    v71.Parent = v68;
                    v71:AddTag("Cleanup_Dawnbound");
                end;
            end;
            for _, v73 in v67:GetDescendants() do
                if (v73:IsA("BasePart") or v73:IsA("UnionOperation")) and not v73:HasTag("Effect") then
                    v73.Material = Enum.Material.Neon;
                    v73.Reflectance = 0.05;
                    v73:AddTag("DawnboundVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v75, v76) --[[ Line: 205 ]] --[[ Name: _RemoveFX ]]
            if v76 then
                for _, v78 in v76:GetChildren() do
                    if v78:HasTag("Cleanup_Dawnbound") then
                        v78:Destroy();
                    end;
                end;
            end;
            for _, v80 in v75:GetDescendants() do
                if (v80:IsA("BasePart") or v80:IsA("UnionOperation")) and v80:HasTag("DawnboundVisual") then
                    v80.Reflectance = 0;
                    v80.Color = Color3.fromRGB(255, 255, 255);
                    v80:RemoveTag("DawnboundVisual");
                    if v80:GetAttribute("Original_Material") then
                        v80.Material = v80:GetAttribute("Original_Material");
                    end;
                end;
            end;
        end
    }, 
    Twisted = {
        Name = "Twisted", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(191, 191, 191), 
        _AddFX = function(v81, v82, v83) --[[ Line: 229 ]] --[[ Name: _AddFX ]]
            v81:_RemoveFX(v82, v83);
            if v83 then
                for _, v85 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
                    local v86 = v85:Clone();
                    v86.Parent = v83;
                    v86:AddTag("Cleanup_Twisted");
                end;
            end;
        end, 
        _RemoveFX = function(_, _, v89) --[[ Line: 239 ]] --[[ Name: _RemoveFX ]]
            if v89 then
                for _, v91 in v89:GetChildren() do
                    if v91:HasTag("Twisted") then
                        v91:Destroy();
                    end;
                end;
            end;
        end
    }, 
    Voidtouched = {
        Name = "Voidtouched", 
        ValueMulti = 135, 
        Color = Color3.fromRGB(225, 0, 255), 
        _AddFX = function(v92, v93, v94) --[[ Line: 253 ]] --[[ Name: _AddFX ]]
            v92:_RemoveFX(v93, v94);
            if v94 then
                for _, v96 in game.ReplicatedStorage.Mutation_FX.Voidtouched:GetChildren() do
                    local v97 = v96:Clone();
                    v97.Parent = v94;
                    v97:AddTag("Cleanup_Voidtouched");
                end;
            end;
        end, 
        _RemoveFX = function(_, _, v100) --[[ Line: 263 ]] --[[ Name: _RemoveFX ]]
            if v100 then
                for _, v102 in v100:GetChildren() do
                    if v102:HasTag("Cleanup_Voidtouched") then
                        v102:Destroy();
                    end;
                end;
            end;
        end
    }, 
    Wet = {
        Name = "Wet", 
        ValueMulti = 2, 
        Color = Color3.fromRGB(64, 164, 223), 
        _AddFX = function(v103, v104, v105) --[[ Line: 277 ]] --[[ Name: _AddFX ]]
            v103:_RemoveFX(v104, v105);
            if v105 then
                for _, v107 in game.ReplicatedStorage.Mutation_FX.Wet:GetChildren() do
                    local v108 = v107:Clone();
                    v108.Parent = v105;
                    v108.Enabled = true;
                    v108:AddTag("Cleanup_Wet");
                end;
            end;
        end, 
        _RemoveFX = function(_, _, v111) --[[ Line: 288 ]] --[[ Name: _RemoveFX ]]
            if v111 then
                for _, v113 in v111:GetChildren() do
                    if v113:HasTag("Cleanup_Wet") then
                        v113:Destroy();
                    end;
                end;
            end;
        end
    }, 
    Chilled = {
        Name = "Chilled", 
        ValueMulti = 2, 
        Color = Color3.fromRGB(135, 206, 250), 
        _AddFX = function(v114, v115, v116) --[[ Line: 302 ]] --[[ Name: _AddFX ]]
            v114:_RemoveFX(v115, v116);
            if v116 then
                for _, v118 in game.ReplicatedStorage.Mutation_FX.Chilled:GetChildren() do
                    local v119 = v118:Clone();
                    v119.Parent = v116;
                    v119.Enabled = true;
                    v119:AddTag("Cleanup_Chilled");
                end;
            end;
            for _, v121 in v115:GetChildren() do
                if v121:IsA("BasePart") or v121:IsA("UnionOperation") then
                    v121.Reflectance = 0.1;
                end;
            end;
        end, 
        _RemoveFX = function(_, v123, v124) --[[ Line: 318 ]] --[[ Name: _RemoveFX ]]
            if v124 then
                for _, v126 in v124:GetChildren() do
                    if v126:HasTag("Cleanup_Chilled") then
                        v126:Destroy();
                    end;
                end;
            end;
            for _, v128 in v123:GetChildren() do
                if v128:IsA("BasePart") or v128:IsA("UnionOperation") then
                    v128.Reflectance = 0;
                end;
            end;
        end
    }, 
    Frozen = {
        Name = "Frozen", 
        ValueMulti = 10, 
        Color = Color3.fromRGB(108, 184, 255), 
        _AddFX = function(v129, v130, v131) --[[ Line: 337 ]] --[[ Name: _AddFX ]]
            v129:_RemoveFX(v130, v131);
            local v132 = {};
            for _, v134 in v130:GetDescendants() do
                if v134:IsA("BasePart") or v134:IsA("UnionOperation") or v134:IsA("MeshPart") and v134.Transparency < 1 then
                    table.insert(v132, v134);
                end;
            end;
            if #v132 == 0 then
                return;
            else
                local v135 = Vector3.new(1e999, 1e999, 1e999, 0);
                local v136 = Vector3.new(-1e999, -1e999, -1e999, 0);
                for _, v138 in v132 do
                    local l_CFrame_0 = v138.CFrame;
                    local l_Size_0 = v138.Size;
                    local v141 = {
                        l_CFrame_0 * Vector3.new(-l_Size_0.X / 2, -l_Size_0.Y / 2, -l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(l_Size_0.X / 2, -l_Size_0.Y / 2, -l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(-l_Size_0.X / 2, l_Size_0.Y / 2, -l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(l_Size_0.X / 2, l_Size_0.Y / 2, -l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(-l_Size_0.X / 2, -l_Size_0.Y / 2, l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(l_Size_0.X / 2, -l_Size_0.Y / 2, l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(-l_Size_0.X / 2, l_Size_0.Y / 2, l_Size_0.Z / 2), 
                        l_CFrame_0 * Vector3.new(l_Size_0.X / 2, l_Size_0.Y / 2, l_Size_0.Z / 2)
                    };
                    for _, v143 in ipairs(v141) do
                        v135 = Vector3.new(math.min(v135.X, v143.X), math.min(v135.Y, v143.Y), (math.min(v135.Z, v143.Z)));
                        v136 = Vector3.new(math.max(v136.X, v143.X), math.max(v136.Y, v143.Y), (math.max(v136.Z, v143.Z)));
                    end;
                end;
                local v144 = (v135 + v136) / 2;
                local v145 = v136 - v135 + Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0);
                local l_Part_0 = Instance.new("Part");
                l_Part_0.Name = "FrozenShell";
                l_Part_0.Size = v145;
                l_Part_0.CFrame = CFrame.new(v144);
                l_Part_0.Anchored = false;
                l_Part_0.CanCollide = false;
                l_Part_0.CanQuery = false;
                l_Part_0.Massless = true;
                l_Part_0.Transparency = 0.5;
                l_Part_0.Color = Color3.fromRGB(108, 184, 255);
                l_Part_0.Material = Enum.Material.Glass;
                l_Part_0:AddTag("Cleanup_Frozen");
                l_Part_0:AddTag("Effect");
                local v147 = v130.PrimaryPart or v130:FindFirstChild("Handle") or v130:FindFirstChildOfClass("BasePart");
                if v147 then
                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                    l_WeldConstraint_0.Part0 = l_Part_0;
                    l_WeldConstraint_0.Part1 = v147;
                    l_WeldConstraint_0.Parent = l_Part_0;
                    l_Part_0.Parent = v147;
                else
                    l_Part_0:Destroy();
                end;
                for _, v150 in game.ReplicatedStorage.Mutation_FX.Frozen:GetChildren() do
                    local v151 = v150:Clone();
                    v151.Parent = v131;
                    v151.Enabled = true;
                    v151:AddTag("Cleanup_Frozen");
                end;
                for _, v153 in v130:GetDescendants() do
                    if v153:IsA("BasePart") or v153:IsA("UnionOperation") then
                        v153.Reflectance = 0.3;
                    end;
                end;
                return;
            end;
        end, 
        _RemoveFX = function(_, v155, v156) --[[ Line: 407 ]] --[[ Name: _RemoveFX ]]
            local function v160(v157) --[[ Line: 408 ]] --[[ Name: v160 ]]
                for _, v159 in v157:GetDescendants() do
                    if v159:HasTag("Cleanup_Frozen") then
                        v159:Destroy();
                    end;
                end;
            end;
            if v156 then
                v160(v156);
            end;
            if v155 then
                v160(v155);
            end;
            for _, v162 in v155:GetDescendants() do
                if v162:IsA("BasePart") or v162:IsA("UnionOperation") then
                    v162.Reflectance = 0;
                end;
            end;
        end
    }, 
    Disco = {
        Name = "Disco", 
        ValueMulti = 125, 
        Color = Color3.fromRGB(255, 105, 180), 
        _AddFX = function(v163, v164, v165) --[[ Line: 432 ]] --[[ Name: _AddFX ]]
            v163:_RemoveFX(v164, v165);
            local function v166(v167) --[[ Line: 434 ]] --[[ Name: v166 ]]
                -- upvalues: v166 (copy)
                for _, v169 in v167:GetChildren() do
                    if v169:IsA("BasePart") or v169:IsA("UnionOperation") then
                        v169.Material = Enum.Material.Neon;
                        v169:AddTag("Discofied");
                    elseif v169:IsA("Model") then
                        v166(v169);
                    end;
                end;
            end;
            v166(v164);
        end, 
        _RemoveFX = function(_, v171, _) --[[ Line: 447 ]] --[[ Name: _RemoveFX ]]
            for _, v174 in v171:GetDescendants() do
                if (v174:IsA("BasePart") or v174:IsA("UnionOperation")) and v174:HasTag("Discofied") then
                    v174.Reflectance = 0;
                    v174:RemoveTag("Discofied");
                    local l_v174_Attribute_0 = v174:GetAttribute("Original_Material");
                    if l_v174_Attribute_0 and typeof(l_v174_Attribute_0) == "string" then
                        local v176 = Enum.Material[l_v174_Attribute_0];
                        if v176 then
                            v174.Material = v176;
                        end;
                    end;
                end;
            end;
        end
    }, 
    Choc = {
        Name = "Choc", 
        ValueMulti = 2, 
        Color = Color3.fromRGB(92, 64, 51), 
        _AddFX = function(v177, v178, v179) --[[ Line: 467 ]] --[[ Name: _AddFX ]]
            -- upvalues: v6 (copy)
            v177:_RemoveFX(v178, v179);
            local function v180(v181) --[[ Line: 470 ]] --[[ Name: v180 ]]
                -- upvalues: v6 (ref), v180 (copy)
                for _, v183 in v181:GetChildren() do
                    if v183:IsA("BasePart") or v183:IsA("UnionOperation") then
                        local v184 = {};
                        for _, v186 in game.ReplicatedStorage.Mutation_Textures.Choc:GetChildren() do
                            local v187 = v186:Clone();
                            v187.Parent = v183;
                            v187.Transparency = v183.Transparency;
                            table.insert(v184, v187);
                            v187:AddTag("Cleanup_Choc");
                        end;
                        v6[v183] = v183.Changed:Connect(function() --[[ Line: 482 ]]
                            -- upvalues: v183 (copy), v6 (ref), v184 (copy)
                            if v183.Transparency ~= 0 then
                                return;
                            else
                                v6[v183]:Disconnect();
                                for _, v189 in v184 do
                                    v189.Transparency = 0;
                                end;
                                return;
                            end;
                        end);
                    elseif v183:IsA("Model") then
                        v180(v183);
                    end;
                end;
            end;
            v180(v178);
        end, 
        _RemoveFX = function(_, v191, _) --[[ Line: 501 ]] --[[ Name: _RemoveFX ]]
            -- upvalues: v6 (copy)
            for _, v194 in v191:GetDescendants() do
                if v194:HasTag("Cleanup_Choc") then
                    v194:Destroy();
                end;
                if v6[v194] then
                    v6[v194]:Disconnect();
                end;
            end;
        end
    }, 
    Plasma = {
        Name = "Plasma", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(208, 43, 137), 
        _AddFX = function(v195, v196, v197) --[[ Line: 517 ]] --[[ Name: _AddFX ]]
            v195:_RemoveFX(v196, v197);
            if v197 then
                for _, v199 in game.ReplicatedStorage.Mutation_FX.Plasma:GetChildren() do
                    local v200 = v199:Clone();
                    v200.Parent = v197;
                    v200.Enabled = true;
                    v200:AddTag("Cleanup_Plasma");
                end;
            end;
            for _, v202 in v196:GetDescendants() do
                if (v202:IsA("BasePart") or v202:IsA("UnionOperation")) and not v202:HasTag("Effect") then
                    v202.Color = Color3.fromRGB(189, 67, 142);
                    v202.Material = Enum.Material.Neon;
                    v202.Reflectance = 0.05;
                    v202:AddTag("PlasmaVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v204, v205) --[[ Line: 536 ]] --[[ Name: _RemoveFX ]]
            local function v209(v206) --[[ Line: 537 ]] --[[ Name: v209 ]]
                for _, v208 in v206:GetDescendants() do
                    if v208:HasTag("Cleanup_Plasma") then
                        v208:Destroy();
                    end;
                end;
            end;
            if v205 then
                v209(v205);
            end;
            if v204 then
                v209(v204);
            end;
            for _, v211 in v204:GetDescendants() do
                if (v211:IsA("BasePart") or v211:IsA("UnionOperation")) and v211:HasTag("PlasmaVisual") then
                    v211.Reflectance = 0;
                    v211.Color = Color3.fromRGB(255, 255, 255);
                    v211:RemoveTag("PlasmaVisual");
                    if v211:GetAttribute("Original_Material") then
                        v211.Material = v211:GetAttribute("Original_Material");
                    end;
                end;
            end;
        end
	}, 
	Watermelonin = {
		Name = "Watermelonin", 
		ValueMulti = 999, 
		Color = Color3.fromRGB(94, 255, 7), 
		_AddFX = function(v327, v328, v329) --[[ Line: 869 ]] --[[ Name: _AddFX ]]
			v327:_RemoveFX(v328, v329);
			if v329 then
				for _, v331 in game.ReplicatedStorage.Mutation_FX.Watermelonin:GetChildren() do
					local v332 = v331:Clone();
					v332.Parent = v329;
					v332.Enabled = true;
					v332:AddTag("Cleanup_Pollinated");
					v332:AddTag("Effect");
				end;
			end;
			for _, v334 in v328:GetDescendants() do
				if (v334:IsA("BasePart") or v334:IsA("UnionOperation")) and not v334:HasTag("Effect") then
					v334.Color = Color3.fromRGB(94, 255, 7);
					v334:AddTag("WatermeloninVisual");
				end;
			end;
		end, 
		_RemoveFX = function(_, v336, v337) --[[ Line: 887 ]] --[[ Name: _RemoveFX ]]
			if v337 then
				for _, v339 in v337:GetChildren() do
					if v339:HasTag("Cleanup_Watermelonin") then
						v339:Destroy();
					end;
				end;
			end;
			for _, v341 in v336:GetDescendants() do
				if (v341:IsA("BasePart") or v341:IsA("UnionOperation")) and v341:HasTag("WatermeloninVisual") then
					v341:RemoveTag("WatermeloninVisual");
					local l_v341_Attribute_0 = v341:GetAttribute("Original_Material");
					if l_v341_Attribute_0 and typeof(l_v341_Attribute_0) == "string" then
						local v343 = Enum.Material[l_v341_Attribute_0];
						if v343 then
							v341.Material = v343;
						end;
					end;
				end;
			end;
		end
	},
    Heavenly = {
        Name = "Heavenly", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(255, 249, 160), 
        _AddFX = function(v212, v213, v214) --[[ Line: 566 ]] --[[ Name: _AddFX ]]
            v212:_RemoveFX(v213, v214);
            if v214 then
                for _, v216 in game.ReplicatedStorage.Mutation_FX.Heavenly:GetChildren() do
                    local v217 = v216:Clone();
                    v217.Parent = v214;
                    v217.Enabled = true;
                    v217:AddTag("Cleanup_Heavenly");
                end;
            end;
        end, 
        _RemoveFX = function(_, v219, v220) --[[ Line: 577 ]] --[[ Name: _RemoveFX ]]
            local function v224(v221) --[[ Line: 578 ]] --[[ Name: v224 ]]
                for _, v223 in v221:GetDescendants() do
                    if v223:HasTag("Cleanup_Heavenly") then
                        v223:Destroy();
                    end;
                end;
            end;
            if v220 then
                v224(v220);
            end;
            if v219 then
                v224(v219);
            end;
        end
    }, 
    Burnt = {
        Name = "Burnt", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(40, 40, 40), 
        _AddFX = function(v225, v226, v227) --[[ Line: 597 ]] --[[ Name: _AddFX ]]
            v225:_RemoveFX(v226, v227);
            if v227 then
                for _, v229 in game.ReplicatedStorage.Mutation_FX.Burnt:GetChildren() do
                    local v230 = v229:Clone();
                    v230.Parent = v227;
                    v230.Enabled = true;
                    v230:AddTag("Cleanup_Burnt");
                end;
            end;
            for _, v232 in v226:GetDescendants() do
                if (v232:IsA("BasePart") or v232:IsA("UnionOperation")) and not v232:HasTag("Effect") then
                    v232.Color = Color3.fromRGB(25, 25, 25);
                    v232.Material = Enum.Material.Slate;
                    v232.Reflectance = 0.05;
                    v232:AddTag("BurntVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v234, v235) --[[ Line: 616 ]] --[[ Name: _RemoveFX ]]
            local function v239(v236) --[[ Line: 617 ]] --[[ Name: v239 ]]
                for _, v238 in v236:GetDescendants() do
                    if v238:HasTag("Cleanup_Burnt") then
                        v238:Destroy();
                    end;
                end;
            end;
            if v235 then
                v239(v235);
            end;
            if v234 then
                v239(v234);
            end;
            for _, v241 in v234:GetDescendants() do
                if (v241:IsA("BasePart") or v241:IsA("UnionOperation")) and v241:HasTag("BurntVisual") then
                    v241.Reflectance = 0;
                    v241.Color = Color3.fromRGB(255, 255, 255);
                    v241:RemoveTag("BurntVisual");
                    if v241:GetAttribute("Original_Material") then
                        v241.Material = v241:GetAttribute("Original_Material");
                    end;
                end;
            end;
        end
    }, 
    Moonlit = {
        Name = "Moonlit", 
        ValueMulti = 2, 
        Color = Color3.fromRGB(153, 141, 255), 
        _AddFX = function(v242, v243, v244) --[[ Line: 646 ]] --[[ Name: _AddFX ]]
            v242:_RemoveFX(v243, v244);
            if v244 then
                for _, v246 in game.ReplicatedStorage.Mutation_FX.Moonlit:GetChildren() do
                    local v247 = v246:Clone();
                    v247.Parent = v244;
                    v247.Enabled = true;
                    v247:AddTag("Cleanup_Moonlit");
                    v247:AddTag("Effect");
                end;
            end;
            for _, v249 in v243:GetDescendants() do
                if (v249:IsA("BasePart") or v249:IsA("UnionOperation")) and not v249:HasTag("Effect") then
                    v249.Color = Color3.fromRGB(62, 56, 86);
                    v249.Reflectance = 0.3;
                    v249:AddTag("MoonlitVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v251, v252) --[[ Line: 665 ]] --[[ Name: _RemoveFX ]]
            if v252 then
                for _, v254 in v252:GetChildren() do
                    if v254:HasTag("Cleanup_Moonlit") then
                        v254:Destroy();
                    end;
                end;
            end;
            for _, v256 in v251:GetDescendants() do
                if (v256:IsA("BasePart") or v256:IsA("UnionOperation")) and v256:HasTag("MoonlitVisual") then
                    v256.Reflectance = 0;
                    v256:RemoveTag("MoonlitVisual");
                    local l_v256_Attribute_0 = v256:GetAttribute("Original_Material");
                    if l_v256_Attribute_0 and typeof(l_v256_Attribute_0) == "string" then
                        local v258 = Enum.Material[l_v256_Attribute_0];
                        if v258 then
                            v256.Material = v258;
                        end;
                    end;
                end;
            end;
        end
    }, 
    Bloodlit = {
        Name = "Bloodlit", 
        ValueMulti = 4, 
        Color = Color3.fromRGB(200, 0, 0), 
        _AddFX = function(v259, v260, v261) --[[ Line: 692 ]] --[[ Name: _AddFX ]]
            v259:_RemoveFX(v260, v261);
            if v261 then
                for _, v263 in game.ReplicatedStorage.Mutation_FX.Bloodlit:GetChildren() do
                    local v264 = v263:Clone();
                    v264.Parent = v261;
                    v264.Enabled = true;
                    v264:AddTag("Cleanup_Bloodlit");
                    v264:AddTag("Effect");
                end;
            end;
            for _, v266 in v260:GetDescendants() do
                if (v266:IsA("BasePart") or v266:IsA("UnionOperation")) and not v266:HasTag("Effect") then
                    v266.Color = Color3.fromRGB(143, 1, 3);
                    v266.Reflectance = 0.3;
                    v266:AddTag("BloodlitVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v268, v269) --[[ Line: 711 ]] --[[ Name: _RemoveFX ]]
            if v269 then
                for _, v271 in v269:GetChildren() do
                    if v271:HasTag("Cleanup_Bloodlit") then
                        v271:Destroy();
                    end;
                end;
            end;
            for _, v273 in v268:GetDescendants() do
                if (v273:IsA("BasePart") or v273:IsA("UnionOperation")) and v273:HasTag("BloodlitVisual") then
                    v273.Reflectance = 0;
                    v273:RemoveTag("BloodlitVisual");
                    local l_v273_Attribute_0 = v273:GetAttribute("Original_Material");
                    if l_v273_Attribute_0 and typeof(l_v273_Attribute_0) == "string" then
                        local v275 = Enum.Material[l_v273_Attribute_0];
                        if v275 then
                            v273.Material = v275;
                        end;
                    end;
                end;
            end;
        end
    }, 
    Zombified = {
        Name = "Zombified", 
        ValueMulti = 25, 
        Color = Color3.fromRGB(128, 199, 127), 
        _AddFX = function(v276, v277, v278) --[[ Line: 738 ]] --[[ Name: _AddFX ]]
            v276:_RemoveFX(v277, v278);
            if v278 then
                for _, v280 in game.ReplicatedStorage.Mutation_FX.Zombified:GetChildren() do
                    local v281 = v280:Clone();
                    v281.Parent = v278;
                    v281.Enabled = true;
                    v281:AddTag("Cleanup_Zombified");
                    v281:AddTag("Effect");
                end;
            end;
            for _, v283 in v277:GetDescendants() do
                if (v283:IsA("BasePart") or v283:IsA("UnionOperation")) and not v283:HasTag("Effect") then
                    v283:AddTag("ZombifiedVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v285, v286) --[[ Line: 755 ]] --[[ Name: _RemoveFX ]]
            if v286 then
                for _, v288 in v286:GetChildren() do
                    if v288:HasTag("Cleanup_Zombified") then
                        v288:Destroy();
                    end;
                end;
            end;
            for _, v290 in v285:GetDescendants() do
                if (v290:IsA("BasePart") or v290:IsA("UnionOperation")) and v290:HasTag("ZombifiedVisual") then
                    v290:RemoveTag("ZombifiedVisual");
                    local l_v290_Attribute_0 = v290:GetAttribute("Original_Material");
                    if l_v290_Attribute_0 and typeof(l_v290_Attribute_0) == "string" then
                        local v292 = Enum.Material[l_v290_Attribute_0];
                        if v292 then
                            v290.Material = v292;
                        end;
                    end;
                end;
            end;
        end
    }, 
    Celestial = {
        Name = "Celestial", 
        ValueMulti = 120, 
        Color = Color3.fromRGB(255, 0, 255), 
        _AddFX = function(v293, v294, v295) --[[ Line: 781 ]] --[[ Name: _AddFX ]]
            v293:_RemoveFX(v294, v295);
            if v295 then
                for _, v297 in game.ReplicatedStorage.Mutation_FX.Celestial:GetChildren() do
                    local v298 = v297:Clone();
                    v298.Parent = v295;
                    v298.Enabled = true;
                    v298:AddTag("Cleanup_Celestial");
                    v298:AddTag("Effect");
                end;
            end;
            for _, v300 in v294:GetDescendants() do
                if (v300:IsA("BasePart") or v300:IsA("UnionOperation")) and not v300:HasTag("Effect") then
                    v300.Reflectance = 0.5;
                    v300:AddTag("CelestialVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v302, v303) --[[ Line: 799 ]] --[[ Name: _RemoveFX ]]
            if v303 then
                for _, v305 in v303:GetChildren() do
                    if v305:HasTag("Cleanup_Celestial") then
                        v305:Destroy();
                    end;
                end;
            end;
            for _, v307 in v302:GetDescendants() do
                if (v307:IsA("BasePart") or v307:IsA("UnionOperation")) and v307:HasTag("CelestialVisual") then
                    v307.Reflectance = 0;
                    v307:RemoveTag("CelestialVisual");
                    local l_v307_Attribute_0 = v307:GetAttribute("Original_Material");
                    if l_v307_Attribute_0 and typeof(l_v307_Attribute_0) == "string" then
                        local v309 = Enum.Material[l_v307_Attribute_0];
                        if v309 then
                            v307.Material = v309;
                        end;
                    end;
                end;
            end;
        end
    }, 
    HoneyGlazed = {
        Name = "HoneyGlazed", 
        ValueMulti = 5, 
        Color = Color3.fromRGB(255, 204, 0), 
        _AddFX = function(v310, v311, v312) --[[ Line: 826 ]] --[[ Name: _AddFX ]]
            v310:_RemoveFX(v311, v312);
            if v312 then
                for _, v314 in game.ReplicatedStorage.Mutation_FX.Honey:GetChildren() do
                    local v315 = v314:Clone();
                    v315.Parent = v312;
                    v315.Enabled = true;
                    v315:AddTag("Cleanup_Honey");
                    v315:AddTag("Effect");
                end;
            end;
            for _, v317 in v311:GetDescendants() do
                if (v317:IsA("BasePart") or v317:IsA("UnionOperation")) and not v317:HasTag("Effect") then
                    v317:AddTag("HoneyVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v319, v320) --[[ Line: 843 ]] --[[ Name: _RemoveFX ]]
            if v320 then
                for _, v322 in v320:GetChildren() do
                    if v322:HasTag("Cleanup_Honey") then
                        v322:Destroy();
                    end;
                end;
            end;
            for _, v324 in v319:GetDescendants() do
                if (v324:IsA("BasePart") or v324:IsA("UnionOperation")) and v324:HasTag("HoneyVisual") then
                    v324:RemoveTag("HoneyVisual");
                    local l_v324_Attribute_0 = v324:GetAttribute("Original_Material");
                    if l_v324_Attribute_0 and typeof(l_v324_Attribute_0) == "string" then
                        local v326 = Enum.Material[l_v324_Attribute_0];
                        if v326 then
                            v324.Material = v326;
                        end;
                    end;
                end;
            end;
        end
    }, 
    Pollinated = {
        Name = "Pollinated", 
        ValueMulti = 3, 
        Color = Color3.fromRGB(255, 170, 0), 
        _AddFX = function(v327, v328, v329) --[[ Line: 869 ]] --[[ Name: _AddFX ]]
            v327:_RemoveFX(v328, v329);
            if v329 then
                for _, v331 in game.ReplicatedStorage.Mutation_FX.Pollinated:GetChildren() do
                    local v332 = v331:Clone();
                    v332.Parent = v329;
                    v332.Enabled = true;
                    v332:AddTag("Cleanup_Pollinated");
                    v332:AddTag("Effect");
                end;
            end;
            for _, v334 in v328:GetDescendants() do
                if (v334:IsA("BasePart") or v334:IsA("UnionOperation")) and not v334:HasTag("Effect") then
                    v334.Color = Color3.fromRGB(255, 170, 0);
                    v334:AddTag("PollinatedlVisual");
                end;
            end;
        end, 
        _RemoveFX = function(_, v336, v337) --[[ Line: 887 ]] --[[ Name: _RemoveFX ]]
            if v337 then
                for _, v339 in v337:GetChildren() do
                    if v339:HasTag("Cleanup_Pollinated") then
                        v339:Destroy();
                    end;
                end;
            end;
            for _, v341 in v336:GetDescendants() do
                if (v341:IsA("BasePart") or v341:IsA("UnionOperation")) and v341:HasTag("PollinatedlVisual") then
                    v341:RemoveTag("PollinatedVisual");
                    local l_v341_Attribute_0 = v341:GetAttribute("Original_Material");
                    if l_v341_Attribute_0 and typeof(l_v341_Attribute_0) == "string" then
                        local v343 = Enum.Material[l_v341_Attribute_0];
                        if v343 then
                            v341.Material = v343;
                        end;
                    end;
                end;
            end;
        end
    }
};
v5.GetMutations = function(_) --[[ Line: 910 ]]
    -- upvalues: v3 (copy), v344 (copy)
    return v3:DeepCopy(v344);
end;
v5.AddMutation = function(_, v347, v348) --[[ Line: 914 ]]
    if not v347 then
        warn("MutationHandler:AddMutation | No plant");
        return;
    else
        v347:SetAttribute(v348.Name, true);
        return;
    end;
end;
v5.RemoveMutation = function(_, v350, v351) --[[ Line: 923 ]]
    if not v350 then
        warn("MutationHandler:RemoveMutation | No plant");
        return;
    else
        v350:SetAttribute(v351.Name, false);
        return;
    end;
end;
v5.GetPlantMutations = function(_, v353) --[[ Line: 932 ]]
    -- upvalues: v5 (copy)
    local v354 = {};
    for _, v356 in v5:GetMutations() do
        if v353:GetAttribute(v356.Name) then
            table.insert(v354, v356);
        end;
    end;
    return v354;
end;
v5.GetMutationsAsString = @native function(_, v358, v359) --[[ Line: 942 ]]
    -- upvalues: v344 (copy)
    local v360 = "";
    for _, v362 in v344 do
        local l_Name_0 = v362.Name;
        if v358:GetAttribute(l_Name_0) then
            if v360 ~= "" then
                v360 = v360 .. ", ";
            end;
            v360 = v360 .. l_Name_0;
        end;
    end;
    if v360 ~= "" and v359 then
        v360 = "[" .. v360 .. "]";
    end;
    return v360;
end;
v5.ExtractMutationsFromString = @native function(_, v365) --[[ Line: 959 ]]
    -- upvalues: v5 (copy)
    local v366 = {};
    if not v365 or v365 == "" then
        return v366;
    else
        v365 = v365:gsub("%[", ""):gsub("%]", ""):gsub("%s+", "");
        for v367 in string.gmatch(v365, "([^,]+)") do
            local v368 = false;
            for _, v370 in v5:GetMutations() do
                if v370.Name == v367 then
                    table.insert(v366, v370);
                    v368 = true;
                end;
            end;
            if not v368 then
                warn((("MutationHandler:ExtractMutationsFromString | Mutation name: %* does not exist"):format(v367)));
            end;
        end;
        return v366;
    end;
end;
v5.TransferMutations = function(_, v372, v373) --[[ Line: 981 ]]
    -- upvalues: v5 (copy)
    for _, v375 in v5:GetMutations() do
        if v372:GetAttribute(v375.Name) then
            v5:AddMutation(v373, v375);
            v5:RemoveMutation(v372, v375);
        end;
    end;
    v373:SetAttribute("WeightMulti", v372:GetAttribute("WeightMulti") or 1);
end;
v5.CalcValueMulti = function(_, v377) --[[ Line: 991 ]]
    -- upvalues: v5 (copy)
    local v378 = 1;
    for _, v380 in v5:GetMutations() do
        if v377:GetAttribute(v380.Name) then
            v378 = v378 + (v380.ValueMulti - 1);
        end;
    end;
    return (math.max(1, v378));
end;
v5.SetToolName = function(_, v382) --[[ Line: 1001 ]]
    -- upvalues: v4 (copy), v5 (copy)
    if not v382:IsA("Tool") then
        return;
    else
        task.spawn(function() --[[ Line: 1006 ]]
            -- upvalues: v382 (copy), v4 (ref), v5 (ref)
            local v383 = v382:WaitForChild("Variant", 0.3);
            if not v383 then
                return;
            else
                local v384 = v382:WaitForChild("Item_String", 0.3);
                if not v384 then
                    return;
                elseif not v382:WaitForChild("Weight", 0.3) then
                    return;
                else
                    local v385, _ = v4.Calculate_Weight(v382.Item_Seed.Value, v384.Value);
                    v385 = v385 * (v382:GetAttribute("WeightMulti") or 1);
                    local l_v5_MutationsAsString_0 = v5:GetMutationsAsString(v382);
                    local l_Value_0 = v383.Value;
                    local l_l_v5_MutationsAsString_0_0 = l_v5_MutationsAsString_0;
                    if l_Value_0 and l_Value_0 ~= "" and l_Value_0 ~= "Normal" then
                        l_l_v5_MutationsAsString_0_0 = if l_l_v5_MutationsAsString_0_0 == "" then l_Value_0 else l_l_v5_MutationsAsString_0_0 .. ", " .. l_Value_0;
                    end;
                    v382.Name = (l_l_v5_MutationsAsString_0_0 ~= "" and ("[%*] "):format(l_l_v5_MutationsAsString_0_0) or "") .. v384.Value .. " [" .. string.format("%.2f", v385) .. "kg]";
                    return;
                end;
            end;
        end);
        return;
    end;
end;
local v390 = {};
local v391 = {};
for _, v393 in v344 do
    v391[v393.Name] = true;
end;
v5.MutationNames = v391;
local function v399(v394) --[[ Line: 1040 ]] --[[ Name: v399 ]]
    -- upvalues: v39 (copy), v5 (copy), v391 (copy), v390 (copy), v21 (copy)
    if not v394 then
        warn("MutationHandler.MutatableAdded | No plant");
        return;
    else
        for _, v396 in v394:GetDescendants() do
            if v396:IsA("Part") or v396:IsA("MeshPart") or v396:IsA("UnionOperation") then
                v396:SetAttribute("Original_Material", v396.Material.Name);
            end;
        end;
        task.defer(function() --[[ Line: 1051 ]]
            -- upvalues: v394 (copy), v39 (ref)
            local v397 = 0;
            while not v394:GetAttribute("Frozen") and v397 < 2 do
                task.wait(0.05);
                v397 = v397 + 0.05;
            end;
            v39(v394);
        end);
        v5:SetToolName(v394);
        v394.AttributeChanged:Connect(function(v398) --[[ Line: 1061 ]]
            -- upvalues: v391 (ref), v390 (ref), v394 (copy), v21 (ref), v39 (ref), v5 (ref)
            if not v391[v398] then
                return;
            elseif v390[v394] then
                return;
            else
                v390[v394] = true;
                task.defer(function() --[[ Line: 1069 ]]
                    -- upvalues: v21 (ref), v394 (ref), v39 (ref), v5 (ref), v390 (ref)
                    v21(v394);
                    v39(v394);
                    v5:SetToolName(v394);
                    v390[v394] = nil;
                end);
                return;
            end;
        end);
        return;
    end;
end;
if l_RunService_0:IsServer() then
    l_CollectionService_0:GetInstanceAddedSignal("Harvestable"):Connect(v399);
    l_CollectionService_0:GetInstanceAddedSignal("FruitTool"):Connect(v399);
    l_CollectionService_0:GetInstanceAddedSignal("PlantScaled"):Connect(function(v400) --[[ Line: 1085 ]]
        -- upvalues: v5 (copy), v39 (copy)
        if not v5:CanBeMutated(v400) then
            return;
        elseif not v400:IsA("Model") and not v400:IsA("Tool") then
            return;
        else
            v39(v400);
            v5:SetToolName(v400);
            return;
        end;
    end);
end;
return v5;