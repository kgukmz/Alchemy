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

local Drawificiation = require("Files/Utils/Modules/Drawification.lua")
local LoadingNotif = Drawificiation:Notification({
    Text = "[ALCHEMY]: " .. CurrentAction;
    Size = 18;
})

local HeartbeatConnection;
HeartbeatConnection = RunService.Heartbeat:Connect(function()
    LoadingNotif.Instance.Text = CurrentAction
end)

if (isfolder("ALCHEMY") == false) then
    CurrentAction = "Creating environment..."
    makefolder("ALCHEMY")
end

do
    CurrentAction = "Verifying dependencies..."

    if (isfolder("ALCHEMY/Configurations") == false) then
        CurrentAction = "Installing dependencies..."
        makefolder("ALCHEMY/Configurations")
    end

    if (isfolder("ALCHEMY/Dependencies") == false) then
        makefolder("ALCHEMY/Dependencies")
    end

    if (isfile("ALCHEMY/Dependencies/ProggyClean.ttf") == false) then
        writefile("ProggyClean.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyClean.ttf"))
    end
end

local GameList = require("Files/Utils/GameList.lua")
local GameMenu = require("Files/Games/Universal/Menu.lua")

local PlaceId = game.PlaceId
for i, v in next, GameList do
    if (i ~= PlaceId) then
        continue
    end

    GameMenu = require(string.format("Files/Games/%s/Menu.lua", v))
    CurrentAction = "Loading Game: " .. v
    break
end

local Menu = GameMenu:Load()

HeartbeatConnection:Disconnect()
LoadingNotif:Remove()

Drawificiation:Notification("success", {
    Text = "[ALCHEMY]: Took: " .. tick() - StartTick .. "/s to load";
    Size = 18;
    Time = 5;
})