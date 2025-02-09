local Configs = {}
local Sections = {}

local CurrentGame = "Rogue-Lineage"
local FolderPath = string.format("ALCHEMY/Configurations/%s/", CurrentGame)

function Sections:Configs(WindowTab)
    local ConfigSection = WindowTab:Section({
        Name = "Configurations";
        AutoSize = true;
        Side = "Left";
    })

    local ConfigsList = ConfigSection:List({
        Name = "Config List";
        Options = {}
    })

    ConfigSection:Button({
        Name = "Refresh";
        Callback = function()
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

    for i, ConfigFile in next, listfiles(ConfigsList) do
        print(i, ConfigFile)
    end

    return ConfigSection
end


function Configs:Initialize(Window)
    local Configs = Window:Page({ Name = "Configuration" })

    Sections:Configs(Configs)
end

return Configs