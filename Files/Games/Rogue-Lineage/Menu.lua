local Menu = {}
local Tabs = {}

local Library = require("Files/Utils/Library/Linoria.lua")

table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/MainTab.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/AutomationTab.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/KeybindsTab.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/SettingsTab.lua"))

function Menu:Load()
    self.Library = Library

    self.Window = Library:CreateWindow({
        Title = ("Alchemy | %s"):format(identifyexecutor() or "EXECUTOR") ,
        Centered = true,
        AutoShow = true,
        Size = UDim2.fromOffset(560, 600),
        MenuFadeTime = 0,
    })

    for i, MenuTab in next, Tabs do
        local Success, Error = pcall(MenuTab.Init, self.Window, self.Window)

        if (Success == false) then
            warn("UNABLE TO INITIALIZE TAB '" .. i .. "'", Error) 
        end
    end

    -- // temp
    Library.ToggleKeybind = getgenv().Options.MenuKeybind
    
    return Menu
end

return Menu