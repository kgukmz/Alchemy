local Menu = {}

local Library = require("Files/Utils/Library/Linoria.lua")

local Tabs = {
    MainTab = require("Files/Games/Rogue-Lineage/MenuTabs/MainTab.lua");
    AutomationTab = require("Files/Games/Rogue-Lineage/MenuTabs/AutomationTab.lua");
    SettingsTab = require("Files/Games/Rogue-Lineage/MenuTabs/SettingsTab.lua");
    KeybindsTab = require("Files/Games/Rogue-Lineage/MenuTabs/KeybindsTab.lua");
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
        if (Tab.Init) then
            Tab:Init(self.Window)
        else
            warn("UNABLE TO INITIALIZE TAB:", i)
        end
    end

    -- // temp
    Library.ToggleKeybind = getgenv().Options.MenuKeybind
    
    return Menu
end

return Menu