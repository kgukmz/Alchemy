local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/loadEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

require("Files/Utils/ESPModule.lua")