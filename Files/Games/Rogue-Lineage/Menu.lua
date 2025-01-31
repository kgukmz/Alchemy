local Menu = {}

local Library = require("Files/Utils/Library/Linoria.lua")

local Tabs = {
    Main = require("Files/Games/Rogue-Lineage/MenuTabs/Main.lua");
    Automation = require("Files/Games/Rogue-Lineage/MenuTabs/Automation.lua");
}

function Menu:Load()
    self.Library = Library

    self.Window = Library:CreateWindow({
        Title = ("Alchemy | %s"):format(identifyexecutor() or "EXECUTOR") ,
        Centered = true,
        AutoShow = true,
        Size = UDim2.fromOffset(560, 600)
    })

    for i, Tab in next, Tabs do
        Tab:Init(self.Window)
    end

    return Menu
end

return Menu