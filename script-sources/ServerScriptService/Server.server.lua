local ServerScriptService = game:GetService("ServerScriptService")
local Cmdr = require(ServerScriptService.Cmdr)

Cmdr:RegisterHooksIn(ServerScriptService.Server.Hooks)
Cmdr:RegisterDefaultCommands()
Cmdr:RegisterCommandsIn(ServerScriptService.Server.Admin)