local Menu = {}
local Tabs = {}

local Library = require("Files/Utils/Library/UILibrary.lua")
local Drawification = require("Files/Utils/Modules/Drawification.lua")

table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/MainTab.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/SettingsTab.lua"))

function Menu:Load()
    self.Library = Library

    self.Window = Library:Window({
        Name = ("Alchemy [%s]"):format(identifyexecutor());
    })

    for i, WindowTab in next, Tabs do
        local Success, Error = pcall(WindowTab.Initialize, WindowTab, Window)

        if (Success == false) then
            Drawification:Notification("l_error", {
                Text = string.format("Unable to initialize tab: %s, %s", i, Error);
                Size = 18;
                Time = 10;
            })
        end
    end

    return Menu
end

return Menu