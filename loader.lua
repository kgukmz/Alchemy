local StartTick = tick()

local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/GetEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

print("[ALCHEMY] Loading...")

local GameList = require("Files/Utils/GameList.lua")
local GameMenu = require("Files/Games/Universal/Menu.lua")

for GameID, MenuName in next, GameList do
    if (game.PlaceId ~= GameID) then
        continue
    end

    warn(MenuName)
    GameMenu = require(("Files/Games/" .. MenuName .. "/Menu.lua"))
    warn("Loading")
    break
end

local LoadedMenu = GameMenu:Load()

warn("[ALCHEMY] Took:", tick() - StartTick .. ".s", "to load")