local Keybinds = {}
local TabGroups = {}

function TabGroups:MenuBind(WindowTab)
    local MenuGroup = WindowTab:AddLeftGroupbox("[ MENU ]")
    
    do -- // Menu Group Keybinds
        local MenuKeybindLabel = MenuGroup:AddLabel('Toggle Menu [UI]')
        MenuKeybindLabel:AddKeyPicker('MenuKeybind', {
            Default = 'Insert',
            NoUI = true,
            Text = 'Bind Menu Key'
        }) 
    end
end

function Keybinds:Init(Window)
    local KeybindsTab = Window:AddTab("[ KEYBINDS ]")

    TabGroups:MenuBind(KeybindsTab)
end

return Keybinds