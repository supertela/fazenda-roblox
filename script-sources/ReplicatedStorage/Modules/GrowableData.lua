-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GrowableData, time of decompilation: Wed Jun  4 21:30:49 2025 ]]
local _ = game:GetService("RunService");
local l_Fruit_Spawn_0 = game:GetService("ReplicatedStorage"):WaitForChild("Fruit_Spawn");
local l_RunService_1 = game:GetService("RunService");
local v3 = {};
local v4 = {
    ChocolateRain = {
        GrowRateMulti = 1.5
    }, 
    DJJhai = {
        GrowRateMulti = 1.5
    }, 
    Disco = {
        GrowRateMulti = 1.5
    }, 
    Frost = {
        GrowRateMulti = 1.5
    }, 
    JandelLazer = {
        GrowRateMulti = 1.5
    }, 
    JandelStorm = {
        GrowRateMulti = 1.5
    }, 
    MeteorShower = {
        GrowRateMulti = 1.5
    }, 
    Rain = {
        GrowRateMulti = 1.5
    }, 
    SheckleRain = {
        GrowRateMulti = 1.5
    }, 
    Thunderstorm = {
        GrowRateMulti = 1.5
    }, 
    Tornado = {
        GrowRateMulti = 1.5
    }, 
    Blackhole = {
        GrowRateMulti = 1.5
    }, 
    BeeNado = {
        GrowRateMulti = 1.5
    }, 
    BeeStorm = {
        GrowRateMulti = 1.5
    }, 
    Default = {
        GrowRateMulti = 1
    }
};
if l_RunService_1:IsServer() then

end;
local v5 = {
    Carrot = {
        PlantName = "Carrot", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    Tomato = {
        PlantName = "Tomato", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = 0.25
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Apple = {
        PlantName = "Apple", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Blue Lollipop"] = {
        PlantName = "Blue Lollipop", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.2, 1.4), 
            GrowRate = 0.6, 
            PlantDown = 0.25
        }
    }, 
    ["Cherry Blossom"] = {
        PlantName = "Cherry Blossom", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 8), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Pumpkin = {
        PlantName = "Pumpkin", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowRate = 0.005, 
            PlantDown = -0.25
        }
    }, 
    Watermelon = {
        PlantName = "Watermelon", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowRate = 0.01, 
            PlantDown = -0.25
        }
    }, 
    Coconut = {
        PlantName = "Coconut", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.001, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Candy Blossom"] = {
        PlantName = "Candy Blossom", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(120, 180), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(4, 5), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Beanstalk = {
        PlantName = "Beanstalk", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = 1
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = -0.25
        }
    }, 
    ["Candy Sunflower"] = {
        PlantName = "Candy Sunflower", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 4), 
            GrowRate = 0.1, 
            PlantDown = 0.25
        }
    }, 
    Grape = {
        PlantName = "Grape", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = 1
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = -0.25
        }
    }, 
    ["Venus Fly Trap"] = {
        PlantName = "Venus Fly Trap", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 8), 
            GrowFruitTime = NumberRange.new(120, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Raspberry = {
        PlantName = "Raspberry", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Peach = {
        PlantName = "Peach", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(110, 130), 
            GrowRate = 0.05, 
            PlantDown = 2
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.025, 
            PlantDown = -0.25
        }
    }, 
    Passionfruit = {
        PlantName = "Passionfruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowFruitTime = NumberRange.new(2, 4), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Pear = {
        PlantName = "Pear", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = 0.25
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Blueberry = {
        PlantName = "Blueberry", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Celestiberry = {
        PlantName = "Celestiberry", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.6, 0.85), 
            GrowFruitTime = NumberRange.new(170, 190), 
            GrowRate = 0.02, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(3, 4), 
            GrowRate = 0.04, 
            PlantDown = 0.25
        }
    }, 
    Eggplant = {
        PlantName = "Eggplant", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 7), 
            GrowFruitTime = NumberRange.new(110, 130), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Easter Egg"] = {
        PlantName = "Easter Egg", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 3), 
            GrowFruitTime = NumberRange.new(120, 130), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1.5, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Purple Cabbage"] = {
        PlantName = "Purple Cabbage", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 7), 
            GrowFruitTime = NumberRange.new(10, 20), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Lemon = {
        PlantName = "Lemon", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(110, 130), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Chocolate Carrot"] = {
        PlantName = "Chocolate Carrot", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.5, 2.3), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    ["Soul Fruit"] = {
        PlantName = "Soul Fruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.5, 2), 
            GrowFruitTime = NumberRange.new(200, 260), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.3), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Crocus = {
        PlantName = "Crocus", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    ["Pink Tulip"] = {
        PlantName = "Pink Tulip", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    ["Orange Tulip"] = {
        PlantName = "Orange Tulip", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    Daffodil = {
        PlantName = "Daffodil", 
        PlantData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.4, 
            PlantDown = 0.25
        }
    }, 
    ["Cherry OLD"] = {
        PlantName = "Cherry OLD", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = -0.25
        }
    }, 
    Banana = {
        PlantName = "Banana", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 9), 
            GrowFruitTime = NumberRange.new(80, 140), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Red Lollipop"] = {
        PlantName = "Red Lollipop", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.2, 1.4), 
            GrowRate = 0.6, 
            PlantDown = 0.25
        }
    }, 
    Bamboo = {
        PlantName = "Bamboo", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.5, 3), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }
    }, 
    Mushroom = {
        PlantName = "Mushroom", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }
    }, 
    ["Mega Mushroom"] = {
        PlantName = "Mega Mushroom", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }
    }, 
    Corn = {
        PlantName = "Corn", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(70, 90), 
            GrowRate = 0.005, 
            PlantDown = 0.25
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Cactus = {
        PlantName = "Cactus", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = 2
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = -0.25
        }
    }, 
    Mango = {
        PlantName = "Mango", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = 2
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.025, 
            PlantDown = -0.25
        }
    }, 
    ["Moon Mango"] = {
        PlantName = "Moon Mango", 
        PlantData = {
            GrowTickTime = NumberRange.new(5, 6.5), 
            GrowFruitTime = NumberRange.new(1150, 1250), 
            GrowRate = 0.01, 
            PlantDown = 2
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.025, 
            PlantDown = -0.25
        }
    }, 
    ["Dragon Fruit"] = {
        PlantName = "Dragon Fruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(290, 310), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = -0.25
        }
    }, 
    Pineapple = {
        PlantName = "Pineapple", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(70, 90), 
            GrowRate = 0.02, 
            PlantDown = 0.25
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Strawberry = {
        PlantName = "Strawberry", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(13, 18), 
            GrowRate = 0.1, 
            PlantDown = 0.1
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Cranberry = {
        PlantName = "Cranberry", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 7), 
            GrowFruitTime = NumberRange.new(110, 130), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
	Pepper = {
		PlantName = "Pepper", 
		PlantData = {
			GrowTickTime = NumberRange.new(3, 4.5), 
			GrowFruitTime = NumberRange.new(80, 160), 
			GrowRate = 0.05, 
			PlantDown = -0.5
		}, 
		FruitData = {
			GrowTickTime = NumberRange.new(0.8, 1.2), 
			GrowRate = 0.05, 
			PlantDown = -0.25
		}
	}, 
    Succulent = {
        PlantName = "Succulent", 
        PlantData = {
            GrowTickTime = NumberRange.new(5, 7), 
            GrowFruitTime = NumberRange.new(110, 130), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(2, 3), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Papaya = {
        PlantName = "Papaya", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 8), 
            GrowFruitTime = NumberRange.new(200, 260), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Lotus = {
        PlantName = "Lotus", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 3.5), 
            GrowFruitTime = NumberRange.new(200, 230), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(2, 3), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Cacao = {
        PlantName = "Cacao", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Avocado = {
        PlantName = "Avocado", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 4.5), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Starfruit = {
        PlantName = "Starfruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Mint = {
        PlantName = "Mint", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 4), 
            GrowFruitTime = NumberRange.new(90, 120), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(2, 4), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Moon Blossom"] = {
        PlantName = "Moon Blossom", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowFruitTime = NumberRange.new(120, 180), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Nightshade = {
        PlantName = "Nightshade", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.5, 3), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }
    }, 
    Durian = {
        PlantName = "Durian", 
        PlantData = {
            GrowTickTime = NumberRange.new(5, 7.5), 
            GrowFruitTime = NumberRange.new(200, 230), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(2, 3), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Moonflower = {
        PlantName = "Moonflower", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 4), 
            GrowFruitTime = NumberRange.new(60, 90), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Moonglow = {
        PlantName = "Moonglow", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 4.5), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Glowshroom = {
        PlantName = "Glowshroom", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 4), 
            GrowFruitTime = NumberRange.new(60, 90), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Cursed Fruit"] = {
        PlantName = "Cursed Fruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 8), 
            GrowFruitTime = NumberRange.new(120, 180), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Crimson Vine"] = {
        PlantName = "Crimson Vine", 
        PlantData = {
            GrowTickTime = NumberRange.new(1.6, 2.4), 
            GrowFruitTime = NumberRange.new(40, 60), 
            GrowRate = 0.02, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(0.8, 1.2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Moon Melon"] = {
        PlantName = "Moon Melon", 
        PlantData = {
            GrowTickTime = NumberRange.new(8, 12), 
            GrowFruitTime = NumberRange.new(140, 200), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(15, 20), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Blood Banana"] = {
        PlantName = "Blood Banana", 
        PlantData = {
            GrowTickTime = NumberRange.new(6, 9), 
            GrowFruitTime = NumberRange.new(80, 140), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Rose = {
        PlantName = "Rose", 
        PlantData = {
            GrowTickTime = NumberRange.new(7, 9), 
            GrowFruitTime = NumberRange.new(220, 300), 
            GrowRate = 0.1, 
            PlantDown = -1.15
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Foxglove = {
        PlantName = "Foxglove", 
        PlantData = {
            GrowTickTime = NumberRange.new(10, 12), 
            GrowFruitTime = NumberRange.new(33, 44), 
            GrowRate = 0.05, 
            PlantDown = 0
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(3.5, 5), 
            GrowRate = 0.05, 
            PlantDown = 0
        }
    }, 
    Lilac = {
        PlantName = "Lilac", 
        PlantData = {
            GrowTickTime = NumberRange.new(2, 4), 
            GrowFruitTime = NumberRange.new(60, 90), 
            GrowRate = 0.1875, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(1, 2), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Pink Lily"] = {
        PlantName = "Pink Lily", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowFruitTime = NumberRange.new(120, 160), 
            GrowRate = 0.05, 
            PlantDown = -1
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Purple Dahlia"] = {
        PlantName = "Purple Dahlia", 
        PlantData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowFruitTime = NumberRange.new(120, 160), 
            GrowRate = 0.05, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(3, 5), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Sunflower = {
        PlantName = "Sunflower", 
        PlantData = {
            GrowTickTime = NumberRange.new(7, 10), 
            GrowFruitTime = NumberRange.new(220, 300), 
            GrowRate = 0.025, 
            PlantDown = -1.15
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Nectarine = {
        PlantName = "Nectarine", 
        PlantData = {
            GrowTickTime = NumberRange.new(12, 18), 
            GrowFruitTime = NumberRange.new(60, 90), 
            GrowRate = 0.1, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(14, 21), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    ["Hive Fruit"] = {
        PlantName = "Hive Fruit", 
        PlantData = {
            GrowTickTime = NumberRange.new(7.5, 10), 
            GrowFruitTime = NumberRange.new(80, 160), 
            GrowRate = 0.05, 
            PlantDown = -1.15
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowRate = 0.025, 
            PlantDown = 0.25
        }
    }, 
    ["Ember Lily"] = {
        PlantName = "Ember Lily", 
        PlantData = {
            GrowTickTime = NumberRange.new(16, 20), 
            GrowFruitTime = NumberRange.new(280, 350), 
            GrowRate = 0.1, 
            PlantDown = -0.5
        }, 
        FruitData = {
            GrowTickTime = NumberRange.new(7, 15), 
            GrowRate = 0.05, 
            PlantDown = 0.25
        }
    }, 
    Dandelion = {
        PlantName = "Dandelion", 
        PlantData = {
            GrowTickTime = NumberRange.new(4, 6), 
            GrowRate = 0.025, 
            PlantDown = 0
        }
    }
};
v3.GetDataForWeather = function(_, v7) --[[ Line: 963 ]]
    -- upvalues: v4 (copy)
    if not v7 or type(v7) ~= "string" then
        warn("GrowableData:GetDataForWeather | weatherName is not applicable!");
        return v4.Default;
    else
        local v8 = v4[v7];
        if not v8 then
            warn("GrowableData:GetDataForWeather | weatherData is nil!", v7);
            return v4.Default;
        else
            return v8;
        end;
    end;
end;
v3.GetDataForPlant = function(_, v10) --[[ Line: 978 ]]
    -- upvalues: v5 (copy)
    if not v10 then
        warn((("GrowableData:GetDataForPlan | %* is not a valid plant!"):format(if v10 then v10.Name else "nil")));
        return nil;
    else
        local v11 = if v10.Parent then v10.Parent.Name == "Fruits" or v10.Parent.Name == "Fruit_Spawn" else false;
        local v12 = v10:FindFirstChild("Fruit_Spawn") and true or false;
        local v13 = v5[v10.Name];
        if not v13 then
            warn((("GrowableData:GetDataForPlan | No GrowData for %*!"):format(v10.Name)));
            return nil;
        else
            local v14 = nil;
            if v11 and v13.FruitData then
                v14 = v13.FruitData;
            elseif v13.PlantData then
                v14 = v13.PlantData;
            end;
            if not v14 then
                warn((("GrowableData:GetDataForPlan | %* has no PlantData or FruitData!"):format(v10.Name)));
                return nil;
            elseif not v14.GrowTickTime then
                warn((("GrowableData:GetDataForPlan | %* has no GrowTickTime!"):format(v10.Name)));
                return nil;
            elseif not v14.GrowRate then
                warn((("GrowableData:GetDataForPlan | %* has no GrowRate!"):format(v10.Name)));
                return nil;
            elseif v14.PlantDown == nil then
                warn((("GrowableData:GetDataForPlant | %* has no PlantDown!"):format(v10.Name)));
                return nil;
            elseif v12 and not v14.GrowFruitTime then
                warn((("GrowableData:GetDataForPlan | %* has no GrowFruitTime!"):format(v10.Name)));
                return nil;
            else
                return v14;
            end;
        end;
    end;
end;
local _ = function() --[[ Line: 1018 ]]
    -- upvalues: v5 (copy), l_Fruit_Spawn_0 (copy)
    local l_Collectables_0 = game:GetService("ServerStorage"):WaitForChild("Collectables");
    local v16 = "";
    local function v18(v17) --[[ Line: 1022 ]] --[[ Name: v20 ]]
        return string.format("%.4g", v17);
    end;
    for _, v20 in pairs(l_Collectables_0:GetChildren()) do
        local l_Name_0 = v20.Name;
        local v22 = v5[l_Name_0];
        local v23 = 1;
        local l_v20_FirstChild_0 = v20:FindFirstChild("Grow_Rate", true);
        if l_v20_FirstChild_0 and l_v20_FirstChild_0:IsA("NumberValue") then
            v23 = l_v20_FirstChild_0.Value;
        elseif v22 and v22.PlantData and v22.PlantData.GrowRate then
            v23 = v22.PlantData.GrowRate;
        end;
        local v25 = v22 and v22.PlantData and v22.PlantData.GrowTickTime or NumberRange.new(1, 2);
        local v26 = v22 and v22.PlantData and v22.PlantData.GrowFruitTime;
        local v27 = v22 and v22.FruitData and v22.FruitData.GrowTickTime;
        local v28 = math.floor(v25.Min * 10 + 0.5) / 10;
        local v29 = math.floor(v25.Max * 10 + 0.5) / 10;
        local v30 = string.format("\n\t\t\tGrowRate = %s;", v18(v23));
        local v31 = "";
        if v26 then
            local v32 = math.floor(v26.Min * 10 + 0.5) / 10;
            local v33 = math.floor(v26.Max * 10 + 0.5) / 10;
            v31 = string.format("\n\t\t\tGrowFruitTime = NumberRange.new(%s, %s);", string.format("%.4g", v32), v18(v33));
        end;
        local v34 = "";
        if l_Fruit_Spawn_0:FindFirstChild(l_Name_0) then
            local v35 = l_Fruit_Spawn_0[l_Name_0];
            local v36 = 1;
            local l_v35_FirstChild_0 = v35:FindFirstChild("Grow_Rate", true);
            if l_v35_FirstChild_0 and l_v35_FirstChild_0:IsA("NumberValue") then
                v36 = l_v35_FirstChild_0.Value;
            elseif v22 and v22.FruitData and v22.FruitData.GrowRate then
                v36 = v22.FruitData.GrowRate;
            end;
            v34 = ";\n\t\tFruitData = { -- Fruit_Spawn[\"" .. l_Name_0 .. "\"]";
            if v27 then
                local v38 = math.floor(v27.Min * 10 + 0.5) / 10;
                local v39 = math.floor(v27.Max * 10 + 0.5) / 10;
                v34 = v34 .. string.format("\n\t\t\tGrowTickTime = NumberRange.new(%s, %s);", string.format("%.4g", v38), v18(v39));
            else
                v34 = v34 .. "\n\t\t\tGrowTickTime = NumberRange.new(1, 2);";
            end;
            v34 = v34 .. string.format("\n\t\t\tGrowRate = %s;", v18(v36));
            local v40 = 0;
            local l_v35_FirstChild_1 = v35:FindFirstChild("Plant_Down", true);
            if l_v35_FirstChild_1 and l_v35_FirstChild_1:IsA("NumberValue") then
                v40 = l_v35_FirstChild_1.Value;
            elseif v22 and v22.FruitData and v22.FruitData.PlantDown then
                v40 = v22.FruitData.PlantDown;
            end;
            v34 = (v34 .. string.format("\n\t\t\tPlantDown = %s;", v18(v40))) .. "\n\t\t}";
        end;
        local v42 = 0;
        local l_v20_FirstChild_1 = v20:FindFirstChild("Plant_Down", true);
        if l_v20_FirstChild_1 and l_v20_FirstChild_1:IsA("NumberValue") then
            v42 = l_v20_FirstChild_1.Value;
        elseif v22 and v22.PlantData and v22.PlantData.PlantDown then
            v42 = v22.PlantData.PlantDown;
        end;
        local v44 = string.format("\n\t\t\tPlantDown = %s;", v18(v42));
        v16 = v16 .. string.format("\t[\"%s\"] = {\n\t\tPlantName = \"%s\";\n\t\tPlantData = { -- Collectables[\"%s\"]\n\t\t\tGrowTickTime = NumberRange.new(%s, %s);%s%s%s\n\t\t}%s\n\t};\n\n", l_Name_0, l_Name_0, l_Name_0, string.format("%.4g", v28), string.format("%.4g", v29), v31, v30, v44, v34);
    end;
    return v16;
end;
local function v54() --[[ Line: 1087 ]] --[[ Name: v56 ]]
    -- upvalues: v5 (copy), l_Fruit_Spawn_0 (copy)
    local l_Collectables_1 = game:GetService("ServerStorage"):WaitForChild("Collectables");
    local v47 = 0;
    for _, v49 in pairs(l_Collectables_1:GetChildren()) do
        local l_Name_1 = v49.Name;
        if not v5[l_Name_1] then
            warn("Missing plant entry: ", v49);
            v47 = v47 + 1;
        else
            if not v5[l_Name_1].PlantData or not v5[l_Name_1].PlantData.GrowTickTime then
                warn("Missing GrowTickTime for plant: ", v49);
                v47 = v47 + 1;
            end;
            if not v5[l_Name_1].PlantData or not v5[l_Name_1].PlantData.GrowRate then
                warn("Missing required GrowRate for plant: ", v49);
                v47 = v47 + 1;
            end;
            if not v5[l_Name_1].PlantData.PlantDown then
                warn("Missing required PlantDown for plant: ", v49);
                v47 = v47 + 1;
            end;
            if l_Fruit_Spawn_0:FindFirstChild(l_Name_1) then
                if not v5[l_Name_1].PlantData.GrowFruitTime then
                    warn("Missing GrowFruitTime for plant with fruit: ", v49);
                    v47 = v47 + 1;
                end;
                if not v5[l_Name_1].FruitData or not v5[l_Name_1].FruitData.GrowTickTime then
                    warn("Missing FruitData.GrowTickTime for fruit: ", v49);
                    v47 = v47 + 1;
                end;
                if not v5[l_Name_1].FruitData or not v5[l_Name_1].FruitData.GrowRate then
                    warn("Missing required FruitData.GrowRate for fruit: ", v49);
                    v47 = v47 + 1;
                end;
            end;
        end;
    end;
    for _, v52 in pairs(l_Fruit_Spawn_0:GetChildren()) do
        if not v52.Name:find("TODO") then
            local l_Name_2 = v52.Name;
            if not v5[l_Name_2] then
                warn("Missing plant entry for fruit: ", v52);
                v47 = v47 + 1;
            elseif not v5[l_Name_2].FruitData then
                warn("Missing FruitData for fruit: ", v52);
                v47 = v47 + 1;
            elseif v5[l_Name_2].FruitData and not v5[l_Name_2].FruitData.PlantDown then
                warn("Missing required PlantDown for fruit: ", v52);
                v47 = v47 + 1;
            end;
        end;
    end;
    if v47 > 0 then
        print("Validation complete: " .. v47 .. " issues found.");
    end;
    return v47 == 0;
end;
if l_RunService_1:IsStudio() and l_RunService_1:IsServer() then
    v54();
end;
return v3;