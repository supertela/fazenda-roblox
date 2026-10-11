-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PassiveRegistry, time of decompilation: Wed Jun  4 21:30:45 2025 ]]
return {
    ["Milk of the Land"] = {
        Description = "All plants within <Range> studs grow <Multiplier>x faster!", 
        States = {
            Range = {
                Base = 10, 
                Scale = 0.1
            }, 
            Multiplier = {
                Base = 1.25, 
                Scale = 0.0125
            }
        }
    }, 
    ["For the Blue Colony"] = {
        Description = "<Chance>% chance harvested crops duplicate! Rarer crops have lower chance to duplicate.", 
        States = {
            Chance = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    ["For the Red Colony"] = {
        Description = "<Chance>% chance harvested crops duplicate! Rarer crops have lower chance to duplicate.", 
        States = {
            Chance = {
                Base = 5, 
                Scale = 0.1
            }
        }
    }, 
    ["Candy Harvester"] = {
        Description = "<Chance>% extra chance for Candy type crops to duplicate!", 
        States = {
            Chance = {
                Base = 5, 
                Scale = 0.15
            }
        }
    }, 
    ["Slow and Steady"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to duplicate.", 
        States = {
            Chance = {
                Base = 5, 
                Scale = 0.05
            }
        }
    }, 
    ["Digging Buddy"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 60, 
                Scale = -0.3
            }, 
            Chance = {
                Base = 5, 
                Scale = 0.05
            }
        }
    }, 
    ["Digging Friend"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 60, 
                Scale = -0.5
            }, 
            Chance = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    ["Carrot Chomper"] = {
        Description = "Every <Cooldown>s, eats a carrot for <Multiplier>x value bonus!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 45, 
                Scale = -0.225
            }, 
            Multiplier = {
                Base = 1.5, 
                Scale = 0.015
            }
        }
    }, 
    ["Carrot Devourer"] = {
        Description = "Every <Cooldown>s, eats a carrot for <Multiplier>x value bonus!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 40, 
                Scale = -0.2
            }, 
            Multiplier = {
                Base = 3, 
                Scale = 0.03
            }
        }
    }, 
    ["Cat Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 80, 
                Scale = -0.4
            }, 
            Duration = {
                Base = 10, 
                Scale = 0.1
            }, 
            Range = {
                Base = 10, 
                Scale = 0.1
            }, 
            Multiplier = {
                Base = 1.25, 
                Scale = 0.0025
            }
        }
    }, 
    ["Lazy Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 90, 
                Scale = -0.4
            }, 
            Duration = {
                Base = 15, 
                Scale = 0.15
            }, 
            Range = {
                Base = 15, 
                Scale = 0.15
            }, 
            Multiplier = {
                Base = 1.5, 
                Scale = 0.01
            }
        }
    }, 
    Forester = {
        Description = "<Chance>% chance berry fruit stays after harvest!", 
        States = {
            Chance = {
                Max = 25, 
                Base = 2.5, 
                Scale = 0.025
            }
        }
    }, 
    ["Spotted Forester"] = {
        Description = "<Chance>% chance berry fruit stays after harvest!", 
        States = {
            Chance = {
                Max = 30, 
                Base = 5, 
                Scale = 0.05
            }
        }
    }, 
    ["Water Spray"] = {
        Description = "Every <Cooldown>s, sprays water on a nearby plant.", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 30, 
                Scale = -0.15
            }
        }
    }, 
    Eggcelerator = {
        Description = "Increases egg hatch speed by <Multiplier>%!", 
        States = {
            Multiplier = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    ["Better Eggcelerator"] = {
        Description = "Increases egg hatch speed by <Multiplier>%!", 
        States = {
            Multiplier = {
                Base = 20, 
                Scale = 0.2
            }
        }
    }, 
    ["Fertilizer Frenzy"] = {
        Description = "Every <Cooldown>s, emits an aura for <Duration>s granting <Multiplier>x chance for new fruit to grow as variants within <Range> studs!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 120, 
                Scale = -0.6
            }, 
            Duration = {
                Base = 15, 
                Scale = 0.15
            }, 
            Range = {
                Base = 15, 
                Scale = 0.15
            }, 
            Multiplier = {
                Base = 2, 
                Scale = 0.01
            }
        }
    }, 
    ["Turtle Tinkerer"] = {
        Description = "All Sprinklers last <Multiplier>% longer!", 
        States = {
            Range = {
                Base = 35, 
                Scale = 0.5
            }, 
            Multiplier = {
                Base = 20, 
                Scale = 0.2
            }
        }
    }, 
    ["Cheeky Refund"] = {
        Description = "<Chance>% chance to refund fruit back to your inventory. Rarer plants have lower chance to refund!", 
        States = {
            Chance = {
                Base = 2.5, 
                Scale = 0.025
            }
        }
    }, 
    ["Premium Cheeky Refund"] = {
        Description = "<Chance>% chance to refund fruit back to your inventory. Rarer plants have lower chance to refund!", 
        States = {
            Chance = {
                Base = 7.5, 
                Scale = 0.075
            }
        }
    }, 
    ["Movement Variation"] = {
        Description = " ", 
        States = {
            Cooldown = {
                Min = 8, 
                Base = 8, 
                Scale = 0
            }
        }
    }, 
    Transmutation = {
        Description = "Every <Cooldown>m, turns one random fruit gold!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 300, 
                Scale = -3, 
                Formatter = "ColonTime"
            }
        }
    }, 
    ["Polar Express"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit becomes Chilled or Frozen!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 80, 
                Scale = -0.4
            }, 
            Chance = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    Bamboozle = {
        Description = "Every <Cooldown>m, eats bamboo for <Multiplier>x value bonus!", 
        States = {
            Cooldown = {
                Min = 60, 
                Base = 180, 
                Scale = -0.9, 
                Formatter = "ColonTime"
            }, 
            Multiplier = {
                Base = 1.5, 
                Scale = 0.015
            }
        }
    }, 
    ["Leaf Lover"] = {
        Description = "Passive: All leafy plants grow <Multiplier>x faster!", 
        States = {
            Range = {
                Base = 25, 
                Scale = 0
            }, 
            Multiplier = {
                Base = 1.45, 
                Scale = 0.15
            }
        }
    }, 
    ["Zen Zone"] = {
        Description = "Every <Cooldown>s, prays for <Duration>s granting <Multiplier>x variant chance within <Range> studs!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 80, 
                Scale = -0.3
            }, 
            Duration = {
                Base = 10, 
                Scale = 0.1
            }, 
            Range = {
                Base = 10, 
                Scale = 0.1
            }, 
            Multiplier = {
                Base = 1.5, 
                Scale = 0.005
            }
        }
    }, 
    ["Prickly Lover"] = {
        Description = "Grants prickly fruit a <Multiplier>x size bonus!", 
        States = {
            Multiplier = {
                Base = 1.5, 
                Scale = 0.015
            }, 
            Range = {
                Base = 25, 
                Scale = 0
            }
        }
    }, 
    ["Nocturnal Nursery"] = {
        Description = "Every <Cooldown>s, goes to the egg with the highest hatch time, and reduces its hatch time by <Amount>s!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 60, 
                Scale = -0.3
            }, 
            Amount = {
                Base = 25, 
                Scale = 0.25
            }
        }
    }, 
    ["Treasure Hunter"] = {
        Description = "Every <Cooldown>s, digs down underground to find treasure. Can dig up gear or sheckles!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 80, 
                Scale = -0.4
            }
        }
    }, 
    Croak = {
        Description = "Every <Cooldown>m, croaks and a random nearby plant will advance growth by 24 hours!", 
        States = {
            Cooldown = {
                Min = 200, 
                Base = 904.5, 
                Scale = -4.5, 
                Formatter = "ColonTime"
            }
        }
    }, 
    ["Echo Croak"] = {
        Description = "Every <Cooldown>m, croaks and a random nearby plant will advance growth by 24 hours!", 
        States = {
            Cooldown = {
                Min = 200, 
                Base = 603, 
                Scale = -3, 
                Formatter = "ColonTime"
            }
        }
    }, 
    ["Prince of the Night"] = {
        Description = "All active pets gain an additional <Chance> XP/s!", 
        States = {
            Chance = {
                Base = 0.2, 
                Scale = 0.01
            }
        }
    }, 
    ["King of the Night"] = {
        Description = "All active pets gain an additional <Chance> XP/s!", 
        States = {
            Chance = {
                Base = 0.2, 
                Scale = 0.01
            }
        }
    }, 
    Rascal = {
        Description = "Every <Cooldown>m, goes to another player's plot and steals (duplicate) a random crop and gives it to you!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 900, 
                Scale = -4.5, 
                Formatter = "ColonTime"
            }
        }
    }, 
    ["Whisker Wisdom"] = {
        Description = "Every <Cooldown>m, gains additional <Amount> bonus experience!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 603, 
                Scale = -3, 
                Formatter = "ColonTime"
            }, 
            Amount = {
                Base = 500, 
                Scale = 8
            }
        }
    }, 
    Scamper = {
        Description = "Grants additional <Chance>% increase to player movement speed!", 
        States = {
            Chance = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    ["Seed Stash"] = {
        Description = "<Chance>% chance to not consume the seed when planting. Rarer seeds have lower chance to recover!", 
        States = {
            Chance = {
                Base = 2.5, 
                Scale = 0.025
            }
        }
    }, 
    ["Whiskier Wisdom"] = {
        Description = "Every <Cooldown>m, gains additional <Amount> bonus experience!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 503, 
                Scale = -3, 
                Formatter = "ColonTime"
            }, 
            Amount = {
                Base = 750, 
                Scale = 11
            }
        }
    }, 
    ["Cheese Hop"] = {
        Description = "Grants additional <Chance>% increase to player jump height!", 
        States = {
            Chance = {
                Base = 10, 
                Scale = 0.1
            }
        }
    }, 
    ["Fruit Harvester"] = {
        Description = "<Chance>% extra chance for Fruit type crops to duplicate!", 
        States = {
            Chance = {
                Base = 5, 
                Scale = 0.1
            }
        }
    }, 
    Scoundrel = {
        Description = "Every <Cooldown>m, goes to another player's random crop tries to get a seed from it and gives it to you. Rarer seeds have less chance to succesfully steal!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 543, 
                Scale = -3, 
                Formatter = "ColonTime"
            }
        }
    }, 
    Zombify = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Zombified!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 1800, 
                Scale = -10, 
                Formatter = "ColonTime"
            }, 
            Chance = {
                Base = 20, 
                Scale = 0.2
            }
        }
    }, 
    ["Crimson Cradle"] = {
        Description = "Every <Cooldown>s, goes to the egg with the highest hatch time, and reduces its hatch time by <Amount>s!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 60, 
                Scale = -0.3
            }, 
            Amount = {
                Base = 45, 
                Scale = 0.45
            }
        }
    }, 
    ["Monarch of Midnight"] = {
        Description = "All active pets gain an additional <Chance> XP/s!", 
        States = {
            Chance = {
                Base = 0.5, 
                Scale = 0.03
            }
        }
    }, 
    ["Sanguine Spike"] = {
        Description = "Grants all prickly fruit a <Multiplier>x size bonus!", 
        States = {
            Multiplier = {
                Base = 2, 
                Scale = 0.02
            }, 
            Range = {
                Base = 25, 
                Scale = 0
            }
        }
    }, 
    ["Prickly Blessing"] = {
        Description = "Grants all prickly fruit a <Multiplier>x variant bonus!", 
        States = {
            Multiplier = {
                Base = 1.15, 
                Scale = 0.0115
            }, 
            Range = {
                Base = 25, 
                Scale = 0
            }
        }
    }, 
    ["Scorched Soil"] = {
        Description = "Every <Cooldown>s, <Chance>% chance nearby fruit becomes Burnt!", 
        States = {
            Cooldown = {
                Min = 5, 
                Base = 80, 
                Scale = -0.4
            }, 
            Chance = {
                Base = 20, 
                Scale = 0.2
            }
        }
    }, 
    ["Lightning Bug"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit becomes Shocked!", 
        States = {
            Cooldown = {
                Min = 10, 
                Base = 80, 
                Scale = -0.4
            }, 
            Chance = {
                Base = 3, 
                Scale = 0.03
            }
        }
    }
};