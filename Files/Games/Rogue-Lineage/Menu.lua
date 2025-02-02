local Menu = {}
local Tabs = {}

local Library = require("Files/Utils/Library/UILatest.lua")

table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/MainTab.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/SettingsTab.lua"))

function Menu:Load()
    self.Library = Library

    self.Window = Library:Window({
        Name = ("Alchemy | %s"):format(identifyexecutor());
        Watermark = false;
        Keybinds = false;
        Size = Vector2.new(600, 450);
        Folder = "Alchemy";
        Selects = true;
    })

    self.Library:Colorpicker({
        Name = "GlobalColorpicker";
    })

    for i, MenuTab in next, Tabs do
        local Success, Error = pcall(MenuTab.Init, self.Window, self.Library, self.Window)

        if (Success == false) then
            warn("UNABLE TO INITIALIZE TAB '" .. i .. "'", Error) 
        end
    end
    
    return Menu
end

return Menu