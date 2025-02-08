local Main = {}
local Sections = {}

function CheckEnv(Global, Callback)
    if (getgenv == nil) then
        return
    end

    warn(getgenv()[Global])

    if (getgenv()[Global] == nil) then
        return
    end

    coroutine.wrap(Callback)()
end

function Sections:Movement(WindowTab)
    local MovementSection = WindowTab:Section({
        Name = "Movement";
        AutoSize = true;
        Side = "Left";
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
        Name = "Fly";
        Min = 0;
        Max = 125;
        State = 0;
    })

    MovementSection:Slider({
        Name = "Speedhack";
        Min = 0;
        Max = 125;
        State = 0;
    })

    MovementSection:Slider({
        Name = "Infinite Jump";
        Min = 0;
        Max = 125;
        State = 0;
    })

    return MovementSection
end

function Sections:Client(WindowTab)
    local ClientSection = WindowTab:Section({
        Name = "Client";
        AutoSize = true;
        Side = "Right";
    })
    
    CheckEnv("hookfunction", function()
        ClientSection:Toggle({
            Name = "Disable Fall Damage";
        })
    end)

    ClientSection:Toggle({
        Name = "Disable Kill Bricks";
    })

    ClientSection:Toggle({
        Name = "Disable Poison Pits";
    })

    return ClientSection
end

function Main:Initialize(Window)
    local MainPage = Window:Page({ Name = "Main"} )

    Sections:Movement(MainPage)
    Sections:Client(MainPage)
end

return Main