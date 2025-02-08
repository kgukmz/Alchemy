local Workspace = game:GetService("Workspace")
local Main = {}

function CheckEnv(Global, Callback)
    if (getgenv == nil) then
        return
    end

    if (getgenv()[Global] == nil) then
        return
    end

    coroutine.wrap(Callback)()
end

function Main:Initialize(Window)
    local MainPage = Window:Page({ Name = "Main"} )
    local AutomationPage = Window:Page({ Name = "Automation"} )
    local VisualPage = Window:Page({ Name = "Visual"} )
    local SettingsPage = Window:Page({ Name = "Settings"})
end

return Main