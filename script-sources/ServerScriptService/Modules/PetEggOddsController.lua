-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetEggOddsController, time of decompilation: Wed Jun  4 21:31:57 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v4 = require(l_ReplicatedStorage_0.Data.PetRegistry.PetEggs);
local v5 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v6 = require(l_ReplicatedStorage_0.Modules.Trove);
local l_Odds_UI_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Odds_UI");
local l_Items_0 = l_Odds_UI_0.Frame.Main.Items;
local l_PetList_0 = v5.PetList;
local v10 = v6.new();
local v34 = {
    Open = function(_, v12, v13) --[[ Line: 15 ]] --[[ Name: Open ]]
        -- upvalues: v4 (copy), v3 (copy), l_Odds_UI_0 (copy), v10 (copy), l_Items_0 (copy), l_PetList_0 (copy), l_RunService_0 (copy)
        local v14 = v4[v12];
        if not v14 then
            warn((("Egg '%*' not found in PetEggs"):format(v12)));
            return;
        else
            local l_v3_StateForGui_0 = v3:GetStateForGui(l_Odds_UI_0);
            v10:Destroy();
            local v16 = {};
            for v17, v18 in v14.RarityData.Items do
                table.insert(v16, {
                    Name = v17, 
                    Item = v18, 
                    NormalizedOdd = v18.NormalizedOdd or 0
                });
            end;
            table.sort(v16, function(v19, v20) --[[ Line: 32 ]]
                return v19.NormalizedOdd < v20.NormalizedOdd;
            end);
            for v21, v22 in v16 do
                local v23 = v21 <= 1;
                local v24 = v21 <= 3;
                local v25 = if v23 then l_Items_0.UIListLayout.TemplateRainbow else if v24 then l_Items_0.UIListLayout.TemplateBigger else l_Items_0.UIListLayout.TemplateSmaller;
                local v26 = v10:Clone(v25);
                v26.LayoutOrder = 100 / v22.NormalizedOdd;
                v26.Title.Text = v22.Name;
                v26.Odds.Text = ("%*%%"):format((math.floor(v22.NormalizedOdd + 0.5)));
                local v27 = l_PetList_0[v22.Name];
                if v27 and v27.Icon then
                    v26.Vector.Image = v27.Icon;
                    v26.Vector.Visible = true;
                else
                    v26.Vector.Visible = false;
                end;
                if v23 then
                    local v28 = nil;
                    do
                        local l_v28_0 = v28;
                        v10:Add(l_v3_StateForGui_0.Visible:Listen(function(v30) --[[ Line: 54 ]]
                            -- upvalues: l_v28_0 (ref), v10 (ref), l_RunService_0 (ref), v26 (copy)
                            if v30 and not l_v28_0 then
                                l_v28_0 = v10:Add(l_RunService_0.PostSimulation:Connect(function() --[[ Line: 57 ]]
                                    -- upvalues: v26 (ref)
                                    local v31 = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                                    v26.Odds.TextColor3 = v31;
                                    v26.Title.TextColor3 = v31;
                                end));
                                return;
                            else
                                if not v30 and l_v28_0 then
                                    v10:Remove(l_v28_0);
                                    l_v28_0 = nil;
                                end;
                                return;
                            end;
                        end));
                    end;
                elseif v24 then
                    local v32 = Color3.fromRGB(255, 204, 1);
                    v26.Odds.TextColor3 = v32;
                    v26.Title.TextColor3 = v32;
                end;
                v26.Parent = l_Items_0;
            end;
            v3:Open(l_Odds_UI_0);
            if v13 then
                v10:Add(l_Odds_UI_0.Frame.ExitButton.Activated:Once(function() --[[ Line: 82 ]]
                    -- upvalues: v3 (ref), l_Odds_UI_0 (ref), v13 (copy), v10 (ref)
                    v3:Close(l_Odds_UI_0);
                    v3:Open(v13);
                    v10:Clean();
                end));
                return;
            else
                v10:Add(l_Odds_UI_0.Frame.ExitButton.Activated:Once(function() --[[ Line: 90 ]]
                    -- upvalues: v3 (ref), l_Odds_UI_0 (ref), v10 (ref)
                    v3:Close(l_Odds_UI_0);
                    v10:Clean();
                end));
                return;
            end;
        end;
    end, 
    Start = function(_) --[[ Line: 99 ]] --[[ Name: Start ]]
        -- upvalues: v3 (copy), l_Odds_UI_0 (copy)
        v3:UsePopupAnims(l_Odds_UI_0);
    end
};
task.spawn(v34.Start, v34);
return v34;