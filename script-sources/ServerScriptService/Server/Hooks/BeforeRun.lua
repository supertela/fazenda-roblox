local ADMINS = {
	[6169089637] = true,
	[2548824942] = true,
	[8642956213] = true, 
	[8665170207] = true,  -- Roblox player userid
}


return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if context.Group == "DefaultAdmin" and not ADMINS[context.Executor.UserId] then
			return "You don't have permission to run this command"
		end
	end)
end