local StartTick = tick()

local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/GetEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

local Drawificiation = require("Files/Utils/Drawification.lua")

local Loading = Drawificiation:Notification({
    Text = "[ALCHEMY]: Loading...";
    Size = 18;
})

local GameList = require("Files/Utils/GameList.lua")
local GameMenu = require("Files/Games/Universal/Menu.lua")

for GameID, MenuName in next, GameList do
    if (game.PlaceId ~= GameID) then
        continue
    end

    Drawificiation:Notification({
        Text =  "[ALCHEMY: Game: " .. MenuName;
        Size = 18;
        Time = 5;
    })
    local Success, GetMenu = pcall(require, "Files/Games/" .. MenuName .. "/Menu.lua")

    if (Success == false) then
        warn(GetMenu)
    else
        GameMenu = GetMenu
    end
    break
end

local LoadedMenu = GameMenu:Load()

Drawificiation:Notification("success", {
    Text = "[ALCHEMY]: Took: " .. tick() - StartTick .. "/s to load";
    Time = 5;
})