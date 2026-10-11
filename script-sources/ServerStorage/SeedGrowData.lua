-- TODO: SWITCH FROM THE SCRIPTS IN EVERY PLANT TO THIS BRO
local SeedGrowData = {
	Carrot = {
		[0] = { -- age
			["1"] = { -- part name
				Transparency = 1,
			},
			["2"] = {
				Transparency = 1,
			},
			["3"] = {
				Transparency = 1,
			}
		},
		[0.4] = {
			["2"] = {
				Transparency = 1,
			},
			["3"] = {
				Transparency = 1,
			}
		},
		[0.8] = {
			["1"] = {
				Transparency = 0,
			}
		},
		[1.2] = {
			["1"] = {
				Transparency = 0,
			}
		},
		[1.6] = {
			["2"] = {
				Transparency = 0,
			}
		},
		[2] = {
			["2"] = {
				Transparency = 0,
			}
		},
		[2.8] = {
			["3"] = {
				Transparency = 0,	
			}
		}
	}
}

return SeedGrowData
