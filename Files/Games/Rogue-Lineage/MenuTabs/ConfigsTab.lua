local Configs = {}
local Sections = {}

local CurrentGame = "Rogue-Lineage"
local FolderPath = string.format("ALCHEMY/Configurations/%s/", CurrentGame)

local ConfigSelected = nil
local ConfigName = ""

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
        Callback = function()
            if (ConfigName == "") then
                getgenv().Drawification:Notification("l_error", {
                    Text = "[ALCHEMY]: Config name cannot be blank";
                })
                return
            end

            local FileFormat = string.format("%s.txt", ConfigName)

            if (isfile(FolderPath .. FileFormat == true)) then
                delfile(FolderPath .. FileFormat)
            end

            local Success, Error = pcall(writefile, FolderPath .. FileFormat)

            if (Success == false) then
                getgenv().Drawification:Notification("l_error", {
                    Text = string.format("[ALCHEMY]: Cannot save config: %s", Error);
                })
                return
            end

            getgenv().Drawification:Notification("success", {
                Text = string.format("[ALCHEMY]: Successfully written config: %s", ConfigName);
            })
        end
    })

    ConfigSection:Button({
        Name = "Load Config";
    })

    ConfigSection:Button({
        Name = "Remove Config";
    })

    ConfigSection:Button({
        Name = "Set Auto Load Config";
    })

    ConfigSection:Button({
        Name = "Reset Auto Load Config";
    })

    return ConfigSection
end


function Configs:Initialize(Window)
    local Configs = Window:Page({ Name = "Configuration" })

    Sections:Configs(Configs)
end

return Configs