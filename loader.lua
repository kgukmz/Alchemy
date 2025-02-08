local StartTick = tick()

local Success, Error = pcall(function()
    loadstring(game:HttpGet("https://github.com/kgukmz/Alchemy/raw/refs/heads/main/Files/Utils/GetEnv.lua"))()
end)

if (Success == false) then
    warn("Unable to load script environment")
    return
end

local RunService = GetService("RunService")

local CurrentAction = "Loading..."

local Drawificiation = require("Files/Utils/Drawification.lua")
local LoadingNotif = Drawificiation:Notification({
    Text = "[ALCHEMY]: " .. CurrentAction;
    Size = 18;
})

local HeartbeatConnection;
HeartbeatConnection = RunService.Heartbeat:Connect(function()
    LoadingNotif:ChangeText(CurrentAction)
end)

local GameList = require("Files/Utils/GameList.lua")
local GameMenu = require("Files/Games/Universal/Menu.lua")

for GameID, MenuName in next, GameList do
    if (game.PlaceId ~= GameID) then
        continue
    end
    
    local Success, GetMenu = pcall(require, "Files/Games/" .. MenuName .. "/Menu.lua")
    CurrentAction = "Loading Game: " .. MenuName

    if (Success == false) then
        warn(GetMenu)
    else
        GameMenu = GetMenu
    end
    break
end

local LoadedMenu = GameMenu:Load()

HeartbeatConnection:Disconnect()
LoadingNotif:Remove()

Drawificiation:Notification("success", {
    Text = "[ALCHEMY]: Took: " .. tick() - StartTick .. "/s to load";
    Size = 18;
    Time = 5;
})