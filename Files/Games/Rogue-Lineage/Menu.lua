local Menu = {}
local Tabs = {}
    
local ConfigFolder = "ALCHEMY/Configurations/"
local GameConfig = ConfigFolder .. "Rogue-Lineage"

local Library = require("Files/Utils/Library/UILibrary.lua")

table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/Main.lua"))
-- // table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/Players.lua"))
table.insert(Tabs, require("Files/Games/Rogue-Lineage/MenuTabs/Configs.lua"))

function Menu:Load()
    repeat
        task.wait()
    until game:IsLoaded() == true

    if (isfolder(GameConfig) == false) then
        makefolder(GameConfig)
    end

    self.Library = Library
    getgenv().Library = Library

    self.Window = Library:Window({
        Name = ("Alchemy [%s]"):format(identifyexecutor());
        Size = UDim2.new(0, 550, 0, 600)
    })

    for i, WindowTab in next, Tabs do
        local Success, Error = pcall(WindowTab.Initialize, Library, self.Window, self.Library)

        if (Success == false) then
            getgenv().Drawification:Notification("l_error", {
                Text = string.format("[ALCHEMY]: Unable to initialize tab: %s, %s", i, Error);
                Size = 18;
                Time = 10;
            })
        end
    end

    if (isfile(GameConfig .. "/Auto-Load.txt") == true) then
        local Success, AutoLoad = pcall(readfile, GameConfig .. "/Auto-Load.txt")

        if (Success == false) then
            return
        end

        local ConfigPath = string.format(GameConfig .. "/%s", AutoLoad)
        local Success, ConfigData = pcall(readfile, ConfigPath)

        if (Success == true) then
            local Success, Error = pcall(Library.LoadConfig, Library, ConfigData)

            if (Success == true) then
                getgenv().Drawification:Notification("success", {
                    Text = string.format("[ALCHEMY]: Auto Loaded Config: %s", AutoLoad);
                    Size = 18;
                    Time = 6;
                })
            else
                getgenv().Drawification:Notification("l_error", {
                    Text = string.format("[ALCHEMY]: Library error loading config, : %s", Error);
                    Size = 18;
                    Time = 6;
                })
            end
        else
            getgenv().Drawification:Notification("l_error", {
                Text = string.format("[ALCHEMY]: Unable to load config: %s", AutoLoad);
                Size = 18;
                Time = 6;
            })
        end
    end

    return Menu
end

return Menu