local Menu = {}

local Library = require("Files/Utils/Library/Linoria.lua")

local MainTab = require("Files/Games/Rogue-Lineage/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library

    self.Window = Library:CreateWindow({
        Title = ("Alchemy | %s"):format(identifyexecutor() or "EXECUTOR") ,
        Centered = true,
        AutoShow = true,
        Size = UDim2.fromOffset(550, 625)
    })

    self.Main = MainTab:Init(self.Window)

    return Menu
end

return Menu