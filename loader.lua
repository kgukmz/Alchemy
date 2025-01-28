local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/GetEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

local LoadModule = getgenv().loadModule

if (LoadModule ~= nil and LoadModule ~= "") then
    require(LoadModule)
    return
end