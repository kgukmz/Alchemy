local Configs = {}
local Sections = {}

local CurrentGame = "Rogue-Lineage"
local FolderPath = string.format("ALCHEMY/Configurations/%s/", CurrentGame)

local ConfigSelected = nil
local ConfigName = ""

function GetFiles()
    local FileList = {}

    for i, ConfigFile in next, listfiles(FolderPath) do
        local FileName = string.split(ConfigFile, ".")
        print(FileName[1] .. "." .. FileName[2])
        table.insert(FileList, FileName[1] .. "." .. FileName[2])
    end

    return FileList
end

function Sections:Configs(WindowTab, Library)
    local ConfigSection = WindowTab:Section({
        Name = "Configurations";
        AutoSize = true;
        Side = "Left";
    })

    local ConfigsList = ConfigSection:List({
        Name = "Config List";
        Options = GetFiles();
        Callback = function(Selected)
            ConfigSelected = Selected
        end
    })

    local ConfigRefresh = ConfigSection:Button({
        Name = "Refresh";
        Callback = function()
            local NewConfigsList = GetFiles()
            ConfigsList:Refresh(NewConfigsList)
        end;
    })
    
    ConfigSection:Textbox({
        Name = "Config Alias";
        Placeholder = "Enter your config name...";
        Callback = function(Input)
            ConfigName = Input
        end;
    })

    ConfigSection:Button({
        Name = "Save Config";
        Callback = function()
            if (ConfigName == "") then
                getgenv().Drawification:Notification("l_error", {
                    Text = "[ALCHEMY]: Config name cannot be blank; did you press enter?";
                    Size = 18;
                    Time = 4;
                })
                return
            end

            local FileFormat = string.format("%s.txt", ConfigName)
            local CurrentConfig = Library:GetConfig()

            if (isfile(FolderPath .. FileFormat) == true) then
                delfile(FolderPath .. FileFormat)
            end

            print(FolderPath .. FileFormat)
            local Success, Error = pcall(writefile, FolderPath .. FileFormat, CurrentConfig)

            if (Success == false) then
                getgenv().Drawification:Notification("l_error", {
                    Text = string.format("[ALCHEMY]: Cannot save config: %s", Error);
                    Size = 18;
                    Time = 4;
                })
                return
            end

            getgenv().Drawification:Notification("success", {
                Text = string.format("[ALCHEMY]: Successfully written config: %s", ConfigName);
                Size = 18;
                Time = 4;
            })

            ConfigRefresh:Callback()
        end;
    })

    ConfigSection:Button({
        Name = "Load Config";
        Callback = function()
            if (ConfigSelected == nil) then
                getgenv().Drawification:Notification("l_error", {
                    Text = "[ALCHEMY]: No config selected";
                    Size = 18;
                    Time = 4;
                })
                return
            end

            local Success, ConfigData = pcall(readfile, FolderPath .. ConfigSelected)

            if (Success == false) then
                getgenv().Drawification:Notification("l_error", {
                    Text = string.format("[ALCHEMY]: Unable to read config: %s | %s", ConfigSelected, ConfigData);
                    Size = 18;
                    Time = 4;
                })
                return
            end

            local Success, Error = pcall(Library.LoadConfig, Library, ConfigData)

            if (Success == false) then
                getgenv().Drawification:Notification("l_error", {
                    Text = string.format("[ALCHEMY]: Unable to load config: %s | %s", ConfigSelected, Error);
                    Size = 18;
                    Time = 4;
                })
                return
            end

            getgenv().Drawification:Notification("success", {
                Text = string.format("[ALCHEMY]: Loaded config %s", ConfigSelected);
                Size = 18;
                Time = 4;
            })
        end
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


function Configs:Initialize(Window, Library)
    local Configs = Window:Page({ Name = "Configuration" })

    Sections:Configs(Configs, Library)
end

return Configs