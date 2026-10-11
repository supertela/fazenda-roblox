-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Template, time of decompilation: Wed Jun  4 21:32:02 2025 ]]
local v0 = require(game.ReplicatedStorage.Modules.TweenModel);
local _ = require(game.ReplicatedStorage.Modules.SkinService);
local _ = require(game.ReplicatedStorage.Data.PetRegistry).PetList;
local l_Assets_0 = game.ReplicatedStorage:WaitForChild("Assets");
local _ = l_Assets_0:WaitForChild("Models"):WaitForChild("EggModels");
local l_SFX_0 = l_Assets_0.SFX;
local l_VFX_0 = l_Assets_0.VFX;
local function _(v7) --[[ Line: 10 ]] --[[ Name: _ ]]
    local v8 = v7:Clone();
    v8.Parent = workspace;
    v8:Play();
    v8.Ended:Once(function() --[[ Line: 14 ]]
        -- upvalues: v8 (copy)
        v8:Destroy();
    end);
end;
return function(v10) --[[ Line: 19 ]]
    -- upvalues: l_SFX_0 (copy), v0 (copy), l_VFX_0 (copy)
    task.spawn(function() --[[ Line: 21 ]]
        -- upvalues: v10 (copy), l_SFX_0 (ref), v0 (ref), l_VFX_0 (ref)
        local v11 = v10:GetPivot() * CFrame.new(0, 3, 0);
        local v12 = v10:GetScale() * 2;
        local v13 = l_SFX_0.RisingAccent:Clone();
        v13.Parent = workspace;
        v13:Play();
        local l_v13_0 = v13;
        v13.Ended:Once(function() --[[ Line: 29 ]]
            -- upvalues: l_v13_0 (copy)
            l_v13_0:Destroy();
        end);
        v0(v10, TweenInfo.new(1), {
            CFrame = v11
        }):Play();
        task.wait(0.1);
        v13 = v0(v10, TweenInfo.new(2), {
            Scale = v12
        });
        v13:Play();
        v13.Completed:Connect(function() --[[ Line: 41 ]]
            -- upvalues: l_SFX_0 (ref), v10 (ref), l_VFX_0 (ref)
            local _ = os.clock();
            local v16 = l_SFX_0.Pop:Clone();
            v16.Parent = workspace;
            v16:Play();
            local l_v16_0 = v16;
            v16.Ended:Once(function() --[[ Line: 48 ]]
                -- upvalues: l_v16_0 (copy)
                l_v16_0:Destroy();
            end);
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Size = v10:GetExtentsSize();
            l_Part_0.CFrame = v10:GetPivot();
            l_Part_0.Anchored = true;
            l_Part_0.CanCollide = false;
            l_Part_0.Transparency = 1;
            l_Part_0.Parent = workspace.Visuals;
            v16 = l_VFX_0.EggPop.PopParticles:Clone();
            v16.Color = ColorSequence.new(v10.PrimaryPart.Color);
            v16.Parent = l_Part_0;
            v16:Emit(20);
            warn((("TryDoHatchAnim | Couldnt get PetType from %* in time!"):format((v10:GetFullName()))));
            v10:Destroy();
            task.wait(2);
            l_Part_0:Destroy();
        end);
    end);
end;