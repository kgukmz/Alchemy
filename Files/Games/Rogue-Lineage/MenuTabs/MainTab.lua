local Main = {}
local Sections = {}

function CheckEnv(Global, Callback)
    if (getgenv == nil) then
        return
    end

    if (getgenv()[Global] == nil) then
        return
    end

    coroutine.wrap(Callback)()
end

function Sections:Movement(WindowTab)
    local MovementSection = WindowTab:Section({
        Name = "Movement";
        AutoSize = true;
    })
    
    MovementSection:Toggle({
        Name = "Fly";
    })

    MovementSection:Toggle({
        Name = "Speedhack";
    })

    MovementSection:Toggle({
        Name = "Infinite Jump";
    })

    MovementSection:Slider({
        Name = "Fly [Velocity]";
        Min = 0;
        Max = 125;
    })

    MovementSection:Slider({
        Name = "Speedhack [Velocity]";
        Min = 0;
        Max = 125;
    })

    MovementSection:Slider({
        Name = "Infinite Jump [Velocity]";
        Min = 0;
        Max = 125;
    })
end

function Sections:Client(WindowTab)
    local ClientSection = WindowTab:Section({
        Name = "Client";
        AutoSize = true;
    })
    
    CheckEnv("hookfunction", function()
        ClientSection:Toggle({
            Name = "Disable Fall Damage";
        })
    end)

    CheckEnv("getscriptclosure", function()
        ClientSection:Toggle({
            Name = "Disable Fall Damage";
        })
    end)
end

function Main:Initialize(Window)
    local MainPage = Window:Page({ Name = "Main"} )

    Sections:Movement(MainPage)
    Sections:Client(MainPage)
end

return Main