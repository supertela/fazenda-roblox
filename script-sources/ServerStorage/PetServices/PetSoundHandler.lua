-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PetSoundHandler, time of decompilation: Wed Jun  4 21:32:03 2025 ]]
local v0 = {};
v0.__index = v0;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local v3 = {
    Dog = {
        Idle = "rbxassetid://74516706583472", 
        Walk = "rbxassetid://95883386499521", 
        Dig = "rbxassetid://82347082239944"
    }, 
    ["Golden Lab"] = {
        Idle = "rbxassetid://74516706583472", 
        Walk = "rbxassetid://95883386499521", 
        Dig = "rbxassetid://82347082239944"
    }, 
    Cat = {
        Idle = "rbxassetid://126430736259456", 
        Walk = "rbxassetid://75691085685258", 
        Nap = "rbxassetid://88617197262546"
    }, 
    ["Orange Tabby"] = {
        Idle = "rbxassetid://126430736259456", 
        Walk = "rbxassetid://75691085685258", 
        Nap = "rbxassetid://136807561780379"
    }, 
    Bunny = {
        Idle = "rbxassetid://80830019163546", 
        Walk = "rbxassetid://117228920028311", 
        Chomp = "rbxassetid://91545917920155"
    }, 
    ["Black Bunny"] = {
        Idle = "rbxassetid://80830019163546", 
        Walk = "rbxassetid://117228920028311", 
        Chomp = "rbxassetid://91545917920155"
    }, 
    Chicken = {
        Idle = "rbxassetid://98158160605550", 
        Walk = "rbxassetid://139844945801226"
    }, 
    Rooster = {
        Idle = "rbxassetid://98158160605550", 
        Walk = "rbxassetid://139844945801226"
    }, 
    Pig = {
        Idle = "rbxassetid://135865211196363", 
        Walk = "rbxassetid://116135751746611", 
        Frenzy = "rbxassetid://116342918915952"
    }, 
    Cow = {
        Idle = "rbxassetid://109628519201421", 
        Walk = "rbxassetid://129633521888708"
    }, 
    Dragonfly = {
        Idle = "rbxassetid://77220774723390", 
        Walk = "rbxassetid://88913485838830"
    }, 
    Monkey = {
        Idle = "rbxassetid://139413487045598", 
        Walk = "rbxassetid://112777046526411", 
        Steal = "rbxassetid://13772418142759"
    }, 
    ["Silver Monkey"] = {
        Idle = "rbxassetid://139413487045598", 
        Walk = "rbxassetid://112777046526411", 
        Steal = "rbxassetid://13772418142759"
    }, 
    Snail = {
        Walk = "rbxassetid://84898089107661", 
        Idle = "rbxassetid://123370432487085"
    }, 
    ["Giant Ant"] = {
        Walk = "rbxassetid://85188904272858", 
        Idle = "rbxassetid://139448026417736", 
        Dance = "rbxassetid://104549164564414"
    }, 
    Turtle = {
        Idle = "rbxassetid://72972534645980", 
        Walk = "rbxassetid://95903584684041"
    }, 
    Deer = {
        Idle = "rbxassetid://109504476401833", 
        Walk = "rbxassetid://72482977771929", 
        Stomp = "rbxassetid://110481608328857"
    }, 
    ["Spotted Deer"] = {
        Idle = "rbxassetid://109504476401833", 
        Walk = "rbxassetid://72482977771929", 
        Stomp = "rbxassetid://110481608328857"
    }, 
    Caterpillar = {
        Walk = "rbxassetid://122412833570405", 
        Idle = "rbxassetid://118926491137336"
    }, 
    ["Praying Mantis"] = {
        Walk = "rbxassetid://84713477229850", 
        Idle = "rbxassetid://97641683064349", 
        Pray = "rbxassetid://73332209725156"
    }, 
    ["Sea Otter"] = {
        Idle = "rbxassetid://98663428034599", 
        Spray = "rbxassetid://132032269231520", 
        Walk = "rbxassetid://111713760896073"
    }, 
    ["Polar Bear"] = {
        Idle = "rbxassetid://100399217826845", 
        Roar = "rbxassetid://100918889424478", 
        Walk = "rbxassetid://104191740768506"
    }, 
    Panda = {
        Idle = "rbxassetid://85123076795821", 
        Walk = "rbxassetid://126208503221327", 
        Chomp = "rbxassetid://106994678664275"
    }, 
    Hedgehog = {
        Idle = "rbxassetid://99389171870232", 
        Walk = "rbxassetid://79078872328055", 
        Curl = "rbxassetid://109183921043480"
    }, 
    Kiwi = {
        Idle = "rbxassetid://70643795779986", 
        Walk = "rbxassetid://113954129903942", 
        Nurse = "rbxassetid://126248680195169"
    }, 
    Mole = {
        Idle = "rbxassetid://95599243108942", 
        Walk = "rbxassetid://109159558883532", 
        DigDown = "rbxassetid://122838135787975", 
        DigUp = "rbxassetid://87901949070969"
    }, 
    Frog = {
        Idle = "rbxassetid://105829201448144", 
        Walk = "rbxassetid://104191740768506", 
        Croak = "rbxassetid://97143990552632"
    }, 
    ["Echo Frog"] = {
        Idle = "rbxassetid://134398514718150", 
        Walk = "rbxassetid://104191740768506", 
        Croak = "rbxassetid://113309295117031"
    }, 
    Owl = {
        Idle = "rbxassetid://129074703805811", 
        Walk = "rbxassetid://104191740768506", 
        Fly = "rbxassetid://103608467045533", 
        FlyDown = "rbxassetid://126267742639216", 
        FlyUp = "rbxassetid://113660155265682"
    }, 
    ["Night Owl"] = {
        Idle = "rbxassetid://129074703805811", 
        Walk = "rbxassetid://104191740768506", 
        Fly = "rbxassetid://103608467045533", 
        FlyDown = "rbxassetid://126267742639216", 
        FlyUp = "rbxassetid://113660155265682"
    }, 
    Raccoon = {
        Idle = "rbxassetid://134230704254748", 
        Walk = "rbxassetid://104191740768506", 
        Steal = "rbxassetid://98750147885192"
    }, 
    ["Blood Kiwi"] = {
        Idle = "rbxassetid://70643795779986", 
        Walk = "rbxassetid://113954129903942", 
        Nurse = "rbxassetid://126248680195169"
    }, 
    ["Blood Hedgehog"] = {
        Idle = "rbxassetid://99389171870232", 
        Walk = "rbxassetid://79078872328055", 
        Curl = "rbxassetid://109183921043480"
    }, 
    ["Blood Owl"] = {
        Idle = "rbxassetid://129074703805811", 
        Walk = "rbxassetid://72938304206168", 
        Fly = "rbxassetid://103608467045533", 
        FlyDown = "rbxassetid://126267742639216", 
        FlyUp = "rbxassetid://113660155265682"
    }, 
    ["Chicken Zombie"] = {
        Idle = "rbxassetid://81537385466343", 
        Walk = "rbxassetid://77478760027344"
    }, 
    ["Grey Mouse"] = {
        Idle = "rbxassetid://97778347635709", 
        Walk = "rbxassetid://89252475842825"
    }, 
    Squirrel = {
        Idle = "rbxassetid://92747344416384", 
        Walk = "rbxassetid://73793157974906"
    }, 
    ["Brown Mouse"] = {
        Idle = "rbxassetid://97778347635709", 
        Walk = "rbxassetid://89252475842825"
    }, 
    ["Red Giant Ant"] = {
        Walk = "rbxassetid://76161666777473", 
        Idle = "rbxassetid://131780886746478"
    }, 
    Fox = {
        Idle = "rbxassetid://130458837573687", 
        Walk = "rbxassetid://129545821321602", 
        Steal = "rbxassetid://98750147885192"
    }
};
local v4 = {};
v0.new = function(v5, v6, v7) --[[ Line: 205 ]]
    -- upvalues: v0 (copy)
    local v8 = setmetatable({}, v0);
    v8.PetType = v5;
    v8.PetModel = v6;
    v8.UUID = v7;
    v8.currentSound = nil;
    return v8;
end;
v0.playSound = function(v9, v10) --[[ Line: 214 ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_SoundService_0 (copy), v3 (copy), v4 (copy)
    v9:stopSound();
    if v10 == "Idle" then
        local l_PetSFX_0 = l_ReplicatedStorage_0.Assets:FindFirstChild("PetSFX");
        if l_PetSFX_0 then
            local l_l_PetSFX_0_FirstChild_0 = l_PetSFX_0:FindFirstChild(v9.PetType);
            if l_l_PetSFX_0_FirstChild_0 then
                local l_Idle_0 = l_l_PetSFX_0_FirstChild_0:FindFirstChild("Idle");
                if l_Idle_0 and #l_Idle_0:GetChildren() > 0 then
                    local l_l_Idle_0_Children_0 = l_Idle_0:GetChildren();
                    local v15 = l_l_Idle_0_Children_0[math.random(1, #l_l_Idle_0_Children_0)]:Clone();
                    v15.Parent = v9.PetModel.PrimaryPart or v9.PetModel;
                    v15.SoundGroup = l_SoundService_0.Music;
                    v15.RollOffMode = Enum.RollOffMode.Inverse;
                    v15.RollOffMaxDistance = 100;
                    v15.RollOffMinDistance = 5;
                    v15.EmitterSize = 10;
                    v15.Volume = 1;
                    v15:Play();
                    v9.currentSound = v15;
                    v15.Ended:Connect(function() --[[ Line: 235 ]]
                        -- upvalues: v15 (copy), v9 (copy)
                        v15:Destroy();
                        if v9.currentSound == v15 then
                            v9.currentSound = nil;
                        end;
                    end);
                    return;
                end;
            end;
        end;
    end;
    local v16 = v3[v9.PetType];
    if not v16 then
        return;
    else
        local v17 = v16[v10];
        if not v17 then
            return;
        else
            if not v4[v17] then
                local l_Sound_0 = Instance.new("Sound");
                l_Sound_0.SoundGroup = l_SoundService_0.Music;
                l_Sound_0.SoundId = v17;
                l_Sound_0.Volume = 1;
                l_Sound_0.RollOffMode = Enum.RollOffMode.Inverse;
                l_Sound_0.RollOffMaxDistance = 100;
                l_Sound_0.RollOffMinDistance = 5;
                l_Sound_0.EmitterSize = 10;
                v4[v17] = l_Sound_0;
            end;
            local v19 = v4[v17]:Clone();
            v19.SoundGroup = l_SoundService_0.Music;
            v19.Parent = v9.PetModel.PrimaryPart or v9.PetModel;
            if v10 == "Walk" then
                v19.Loaded:Connect(function() --[[ Line: 270 ]]
                    -- upvalues: v19 (copy)
                    if v19.IsLoaded and v19.TimeLength > 2 then
                        v19.TimePosition = math.random() * (v19.TimeLength - 1);
                    end;
                end);
            end;
            v19:Play();
            v9.currentSound = v19;
            v19.Ended:Connect(function() --[[ Line: 279 ]]
                -- upvalues: v19 (copy), v9 (copy)
                v19:Destroy();
                if v9.currentSound == v19 then
                    v9.currentSound = nil;
                end;
            end);
            return;
        end;
    end;
end;
v0.stopSound = function(v20) --[[ Line: 290 ]]
    if v20.currentSound then
        local l_currentSound_0 = v20.currentSound;
        v20.currentSound = nil;
        local l_Volume_0 = l_currentSound_0.Volume;
        for v23 = 1, 10 do
            task.delay((v23 - 1) * 0.1, function() --[[ Line: 296 ]]
                -- upvalues: l_currentSound_0 (copy), l_Volume_0 (copy), v23 (copy)
                if l_currentSound_0 then
                    l_currentSound_0.Volume = l_Volume_0 * (1 - v23 / 10);
                end;
            end);
        end;
        task.delay(1, function() --[[ Line: 303 ]]
            -- upvalues: l_currentSound_0 (copy)
            if l_currentSound_0 then
                l_currentSound_0:Stop();
                l_currentSound_0:Destroy();
            end;
        end);
    end;
end;
v0.destroy = function(v24) --[[ Line: 312 ]]
    v24:stopSound();
end;
return v0;