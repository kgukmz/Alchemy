local Menu = {}

local Library = require("Files/Utils/Library/UILibrary.lua")

local MainTab = require("Files/Games/Rogue-Lineage/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library
    self.Window = Library:Window({
        Size = UDim2.new(0, 500, 0, 550)
    })

    self.Main = MainTab:Init(self.Window)

    return Menu
end

return Menu