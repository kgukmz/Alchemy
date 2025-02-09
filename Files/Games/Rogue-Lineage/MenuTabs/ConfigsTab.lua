local Configs = {}
local Sections = {}

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

    ConfigSection:Toggle({
        Name = "Auto Load";
        Pointer = "ConfigAutoLoadToggle";
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

    return ConfigSection
end


function Configs:Initialize(Window)
    local Configs = Window:Page("Configuration")

    Sections:Configs(Configs)
end

return Configs