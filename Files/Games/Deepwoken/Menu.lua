local Menu = {}

local Library = require("Files/Utils/Library/Linoria.lua")

local MainTab = require("Files/Games/Deepwoken/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library

    self.Window = Library:CreateWindow({
        Title = ("ALCHEMY | %s"):format(identifyexecutor() or "EXECUTOR"),
        Center = true,
        AutoShow = true,
    })

    self.Main = MainTab:Init(self.Window)

    return Menu
end

return Menu