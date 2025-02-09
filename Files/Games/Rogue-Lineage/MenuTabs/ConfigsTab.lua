local Configs = {}
local Sections = {}

local CurrentGame = "Rogue-Lineage"
local FolderPath = string.format("ALCHEMY/Configurations/%s/", CurrentGame)

function GetFiles()
    local FileList = {}

    for i, ConfigFile in next, listfiles(FolderPath) do
        table.insert(FileList, string.split(ConfigFile, "//")[2])
    end

    return FileList
end

function Sections:Configs(WindowTab)
    local ConfigSection = WindowTab:Section({
        Name = "Configurations";
        AutoSize = true;
        Side = "Left";
    })

    local ConfigsList = ConfigSection:List({
        Name = "Config List";
        Options = GetFiles()
    })

    ConfigSection:Button({
        Name = "Refresh";
        Callback = function()
            local NewConfigsList = GetFiles()
            ConfigsList:Refresh(NewConfigsList)
        end
    })
    
    ConfigSection:Textbox({
        Name = "Config Alias";
        Placeholder = "Enter your config name...";
    })

    ConfigSection:Button({
        Name = "Save Config";
    })

    ConfigSection:Button({
        Name = "Load Config";
    })

    ConfigSection:Button({
        Name = "Remove Config";
    })

    ConfigSection:Button({
        Name = "Auto Load Config";
    })

    return ConfigSection
end


function Configs:Initialize(Window)
    local Configs = Window:Page({ Name = "Configuration" })

    Sections:Configs(Configs)
end

return Configs