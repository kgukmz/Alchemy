local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/GetEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

print("[ALCHEMY] Loading...")

local LoadModule = getgenv().loadModule

if (LoadModule ~= nil and LoadModule ~= "") then
    require(LoadModule)
    return
end

local GameList = require("Files/Utils/GameList.lua")
local GameMenu = require("Files/Games/Universal/Menu.lua")

for GameID, MenuName in next, GameList do
    if (game.PlaceId ~= GameID) then
        continue
    end

    warn(MenuName)
    GameMenu = require(("Files/Games/%s/Menu.lua"):format(MenuName))
    break
end

GameMenu:Load()