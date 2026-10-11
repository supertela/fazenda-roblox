-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local v1 = 0;
while v1 <= 50 do
    task.wait();
    v1 = v1 + 1;
    for _, v3 in pairs(l_Parent_0:GetDescendants()) do
        if v3:IsA("ProximityPrompt") then
            v3.Enabled = false;
            v3:Destroy();
        end;
    end;
end;

--- what is this?
--- gng.