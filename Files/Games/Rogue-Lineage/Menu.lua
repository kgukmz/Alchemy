local Menu = {}

local Library = require("Files/Utils/Library/ImGui.lua")

local MainTab = require("Files/Games/Rogue-Lineage/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library

    self.Window = Library:CreateWindow({
        Title = ("Alchemy | [%s]"):format(identifyexecutor() or "EXECUTOR") ,
        Size = UDim2.new(0, 425, 0, 275),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    self.Main = MainTab:Init(self.Window)

    return Menu
end

return Menu