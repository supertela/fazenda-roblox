-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetTooltipHandler, time of decompilation: Wed Jun  4 21:32:04 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v2 = require(l_ReplicatedStorage_0.Modules.CreateTagHandler);
local v3 = {};
v2({
    Tag = "PetTooltip", 
    OnInstanceAdded = function(v4) --[[ Line: 9 ]] --[[ Name: OnInstanceAdded ]]
        -- upvalues: l_TweenService_0 (copy)
        if not v4 then
            return;
        else
            local l_Parent_0 = v4.Parent;
            if not l_Parent_0 then
                return;
            else
                local l_Parent_1 = l_Parent_0.Parent;
                if not l_Parent_1 then
                    return;
                else
                    local l_TooltipText_0 = v4:FindFirstChild("TooltipText");
                    l_TooltipText_0.TextTransparency = 1;
                    v4.BackgroundTransparency = 1;
                    local v8 = l_TweenService_0:Create(v4, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.4
                    });
                    local v9 = l_TweenService_0:Create(l_TooltipText_0, TweenInfo.new(0.2), {
                        TextTransparency = 0
                    });
                    local v10 = l_TweenService_0:Create(v4, TweenInfo.new(0.2), {
                        BackgroundTransparency = 1
                    });
                    local v11 = l_TweenService_0:Create(l_TooltipText_0, TweenInfo.new(0.2), {
                        TextTransparency = 1
                    });
                    l_Parent_1.MouseEnter:Connect(function() --[[ Line: 37 ]]
                        -- upvalues: v8 (copy), v9 (copy)
                        v8:Play();
                        v9:Play();
                    end);
                    l_Parent_1.MouseLeave:Connect(function() --[[ Line: 42 ]]
                        -- upvalues: v10 (copy), v11 (copy)
                        v10:Play();
                        v11:Play();
                    end);
                    return;
                end;
            end;
        end;
    end
});
return v3;