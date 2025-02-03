local Settings = {}
local TabSections = {}

function TabSections:Configurations(Library, WindowTab)
    local ConfigsSection = WindowTab:Section({ Name = "Configurations"; })

    do -- // Configs
        local ConfigDropdown = ConfigsSection:List({
            Name = "Configs",
            Values = {},
            Value = "-",
            Flag = "config_dropdown",
            Size = 190,
            Callback = function(v)
                if Library.ConfigFlags["config_name"] then
                    Library.ConfigFlags["config_name"].Set(v)
                end
            end
        })

        ConfigsSection:Textbox({
            Name = "Config Name",
            Value = "",
            Flag = "config_name"
        })

	    ConfigsSection:Button({
            Name = "Save Config",
            Confirm = true,
            Callback = function()
		        local ConfigName = Library.Flags["config_name"]

		        Library:Notify({
			        Text = ("Successfully %s config (%s)!"):format(isfile(`{Library.Folder}/Configs/{ConfigName}.txt`) and "saved" or "created", ConfigName)
		        })

        		writefile(`{Library.Folder}/Configs/{ConfigName}.txt`, Library:GetConfig())

		        local _, FileNames = Library:GetFiles("Configs", {".txt"})
		        ConfigDropdown.Refresh(FileNames)
		        ConfigDropdown.Set(ConfigName)
	        end
        })

	    ConfigsSection:Button({ Name = "Load Config", Confirm = true, Callback = function()
		    local ConfigName = Library.Flags["config_name"]

		    if isfile(`{Library.Folder}/Configs/{ConfigName}.txt`) then
			    Library:LoadConfig(readfile(`{Library.Folder}/Configs/{ConfigName}.txt`))

			    Library:Notify({
				    Text = ("Successfully loaded config (%s)!"):format(ConfigName)
			    })
		    else
			    Library:Notify({
				    Text = ("Couldn't find config (%s)!"):format(ConfigName)
			    })
		    end

		    local _, FileNames = Library:GetFiles("Configs", {".txt"})

		    ConfigDropdown.Refresh(FileNames)
	    end})

	    ConfigsSection:Button({Name = "Reset Config", Confirm = true, Callback = function()
		    local ConfigName = Library.Flags["config_name"]

		    if isfile(`{Library.Folder}/Configs/{ConfigName}.txt`) then
			    writefile(`{Library.Folder}/Configs/{ConfigName}.txt`, "")

			    Library:Notify({
				    Text = ("Successfully reseted config (%s)!"):format(ConfigName)
			    })
		    else
			    Library:Notify({
				    Text = ("Couldn't find config (%s)!"):format(ConfigName)
			    })
		    end

		    local Files, FileNames = Library:GetFiles("Configs", {".txt"})
		    ConfigDropdown.Refresh(FileNames)
	    end})

	    ConfigsSection:Button({Name = "Delete Config", Confirm = true, Callback = function()
		    local ConfigName = Library.Flags["config_name"]

		    if isfile(`{Library.Folder}/Configs/{ConfigName}.txt`) then
			    delfile(`{Library.Folder}/Configs/{ConfigName}.txt`)

			    Library:Notify({
				    Text = ("Successfully deleted config (%s)!"):format(ConfigName)
			    })
		    else
			    Library:Notify({
				    Text = ("Couldn't find config (%s)!"):format(ConfigName)
			    })
		    end

		    local _, FileNames = Library:GetFiles("Configs", {".txt"})
		    ConfigDropdown.Refresh(FileNames)
		    ConfigDropdown.Set(FileNames[1])
	    end})
	
        ConfigsSection:Button({Name = "Refresh Config", Confirm = true, Callback = function()
		    local _, FileNames = Library:GetFiles("Configs", {".txt"})
		    ConfigDropdown.Refresh(FileNames)
	    end})

	    local _, FileNames = Library:GetFiles("Configs", {".txt"})
	    ConfigDropdown.Refresh(FileNames)
    end
end

function TabSections:Extra(Library, Window)
    local ExtraSection = Window:Section({ Name = "Extras"; })

    do -- // Extra
        ExtraSection:Slider({
            Name = "Tween Speed",
            Flag = "menu_tween_speed",
            Min = 0,
            Max = 1000,
            Value = 100,
            Float = 1,
            Callback = function(v)
                Library.TweenSpeed = v / 1000
            end
        })
        
        ExtraSection:Slider({
            Name = "Lerp Speed",
            Flag = "menu_lerp_speed",
            Min = 0,
            Max = 1000,
            Value = 100,
            Float = 1,
            Callback = function(v)
                Library.LerpSpeed = v / 1000
            end
        })
    
        local TweenStyles = {}
    
        for _,v in Enum.EasingStyle:GetEnumItems() do
            TweenStyles[#TweenStyles + 1] = tostring(v):gsub("Enum.EasingStyle.", "")
        end
    
        print(TweenStyles)
    
        ExtraSection:Dropdown({Name = "Easing Style", Values = TweenStyles, Value = "Quad", Flag = "menu_easing_style", Callback = function(v)
            Library.TweenEasingStyle = Enum.EasingStyle[v]
        end})
    
        local ThemeColorpickers = {}
        for _,v in Library.Theme do
            ThemeColorpickers[_] = ExtraSection:Colorpicker({Name = _, Flag = _ .. "_theme", Color = v, Callback = function(v)
                Library:ChangeTheme(_, v.c)
            end})
        end
    
        ExtraSection:Button({Name = "Reset Theme", Confirm = true, Callback = function()
            for _,v in Library.OriginalTheme do
                Library:ChangeTheme(_, v)
    
                ThemeColorpickers[_].Set(v)
            end
        end})  
    end
end

function Settings:Init(Library, Window)
    local SettingsTab = Window:Tab({ Name = "Settings" })

    TabSections:Configurations(Library, SettingsTab)
    TabSections:Extra(Library, Window)
end

return Settings